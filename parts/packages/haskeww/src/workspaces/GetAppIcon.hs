{-# LANGUAGE ScopedTypeVariables #-}
module GetAppIcon
  ( getAppIcon
  , IconCache
  , IconConfig(..)
  , defaultIconConfig
  ) where

import           Control.Concurrent.Async (mapConcurrently)
import           Control.Exception        (SomeException, catch)
import           Control.Monad            (filterM, when)
import           Data.Char                (isAlphaNum, isDigit, isSpace,
                                           toLower)
import           Data.HashMap.Strict      (HashMap)
import qualified Data.HashMap.Strict      as HM
import           Data.List                (dropWhileEnd, elemIndex, intercalate,
                                           isInfixOf, isPrefixOf, isSuffixOf,
                                           sortBy)
import           Data.List.Split          (splitOn)
import           Data.Maybe               (catMaybes, fromMaybe, listToMaybe)
import           Data.Ord                 (Down (..), comparing)
import           Data.Traversable         (for)
import           System.Directory         (doesDirectoryExist, doesFileExist,
                                           listDirectory)
import           System.Environment       (lookupEnv)
import           System.FilePath          (dropExtension, takeExtension,
                                           takeFileName, (</>))
import           System.IO                (hPutStrLn, stderr)
import           System.Process           (readProcess)

data IconConfig = IconConfig
  { preferredSize   :: Int
  , preferSVG       :: Bool
  , enableDebugLog  :: Bool
  , cacheNegative   :: Bool
  , preferredThemes :: [String]
  , customIconDirs  :: [FilePath]
  }

defaultIconConfig :: IconConfig
defaultIconConfig = IconConfig
  { preferredSize   = 28
  , preferSVG       = True
  , enableDebugLog  = True
  , cacheNegative   = True
  , preferredThemes = ["Adwaita", "breeze", "Papirus", "gnome", "hicolor"]
  , customIconDirs  = []
  }

debugLog :: IconConfig -> String -> IO ()
debugLog cfg msg = when (enableDebugLog cfg) $
  hPutStrLn stderr $ "[GetAppIcon] " ++ msg

type IconCache = HashMap String FilePath

getAppIcon
  :: FilePath
  -> IconCache
  -> IconConfig
  -> Maybe String
  -> IO (FilePath, IconCache)
getAppIcon home cache cfg maybeAppID = case maybeAppID of
  Nothing -> pure (errorIcon, cache)
  Just appID -> case HM.lookup appID cache of
    Just path -> do
      debugLog cfg $ "Cache hit for " ++ appID ++ ": " ++ path
      pure (path, cache)
    Nothing -> do
      debugLog cfg $ "=== Searching icon for " ++ appID ++ " ==="
      path <- computeIconForAppID home cfg errorIcon appID
      debugLog cfg $ "Result: " ++ path
      pure (path, HM.insert appID path cache)
  where
    errorIcon = home </> ".config/eww/images/error.png"

computeIconForAppID :: FilePath -> IconConfig -> FilePath -> String -> IO FilePath
computeIconForAppID home cfg err appID
  | appID == "equibop" = do
      dirs <- getShareDirs home cfg
      getIconPathFromIconName home cfg dirs err "vesktop"
  | otherwise = case splitOn "_" appID of
      ["steam", "app", sid] | all isDigit sid -> do
        findSteamIcon home cfg err sid
      _ -> do
        dirs <- getShareDirs home cfg
        mDesk <- findBestDesktopFile cfg dirs appID
        case mDesk of
          Just desk -> do
            mName <- getIconNameFromDesktopFilePath desk
            case mName of
              Just name -> getIconPathFromIconName home cfg dirs err name
              Nothing   -> searchByAppID home cfg dirs err appID
          Nothing -> searchByAppID home cfg dirs err appID

findSteamIcon :: FilePath -> IconConfig -> FilePath -> String -> IO FilePath
findSteamIcon home cfg err steamID = do
  let dir = home </> ".steam/steam/appcache/librarycache" </> steamID
  exists <- doesDirectoryExist dir
  if not exists
    then do
      dirs <- getShareDirs home cfg
      getIconPathFromIconName home cfg dirs err "steam"
    else do
      files <- listDirectory dir
      let prefs = ["library_600x900.jpg","library_hero.jpg","header.jpg","icon.jpg"]
          cand  = filter (`elem` prefs) (map takeFileName files)
               ++ filter (\f -> takeExtension f `elem` [".jpg",".png"] && length f > 30) files
      case listToMaybe cand of
        Just f  -> pure (dir </> f)
        Nothing -> do
          dirs <- getShareDirs home cfg
          getIconPathFromIconName home cfg dirs err "steam"

searchByAppID :: FilePath -> IconConfig -> [FilePath] -> FilePath -> String -> IO FilePath
searchByAppID home cfg dirs err appID = do
  let vars = generateAppIDVariants appID
  searchIconByVariants home cfg dirs err vars

findBestDesktopFile :: IconConfig -> [FilePath] -> String -> IO (Maybe FilePath)
findBestDesktopFile cfg shareDirs appID = do
  let appDirs = (</> "applications") <$> shareDirs
  existing <- filterM doesDirectoryExist appDirs
  allFiles <- concat <$> mapConcurrently listDesktopFiles existing
  nixFiles <- findNixStoreDesktopFiles appID
  let files = allFiles ++ nixFiles
  if null files
    then pure Nothing
    else do
      scored <- mapM (scoreDesktopFile cfg appID) files
      let sorted = sortBy (comparing (Down . fst)) scored
      pure $ case sorted of
               ((s,p):_) | s > 0 -> Just p
               _                 -> Nothing
  where
    listDesktopFiles dir = do
      fs <- safeListDirectory dir
      pure [dir </> f | f <- fs, isSuffixOf ".desktop" f]

scoreDesktopFile :: IconConfig -> String -> FilePath -> IO (Int, FilePath)
scoreDesktopFile _cfg appID path = do
  let base = dropExtension $ takeFileName path
      lowApp = map toLower appID
      lowBase = map toLower base
      filenameScore
        | base == appID                                   = 1000
        | lowBase == lowApp                               = 900
        | lowApp `isInfixOf` lowBase                      = 500
        | lowBase `isInfixOf` lowApp                      = 400
        | any ((== lowBase) . map toLower) (generateAppIDVariants appID) = 300
        | otherwise                                       = 0
  mContent <- safeReadFile path
  let contentScore = case mContent of
        Nothing -> 0
        Just c  ->
          let lc = map toLower c
              exec = ("exec=" ++ lowApp) `isInfixOf` lc
              wm   = ("startupwmclass=" ++ lowApp) `isInfixOf` lc
              icn  = ("icon=" ++ lowApp) `isInfixOf` lc
          in (if exec then 200 else 0)
           + (if wm   then 150 else 0)
           + (if icn  then 100 else 0)
  pure (filenameScore + contentScore, path)

findNixStoreDesktopFiles :: String -> IO [FilePath]
findNixStoreDesktopFiles appID = do
  let vars = generateAppIDVariants appID
  mPaths <- mapM findNixStorePackage vars
  let paths = catMaybes mPaths
  concat <$> for paths (\p -> do
    let appDir = p </> "share/applications"
    ex <- doesDirectoryExist appDir
    if not ex then pure [] else do
      fs <- safeListDirectory appDir
      pure [appDir </> f | f <- fs, isSuffixOf ".desktop" f])

generateAppIDVariants :: String -> [String]
generateAppIDVariants appID =
  [ appID
  , map toLower appID
  ] ++ reverseDomainVariants appID
     ++ dashUnderscore appID
     ++ withoutSpecialChars appID
  where
    reverseDomainVariants id' =
      let ps = splitOn "." id'
      in if length ps > 1
         then [ last ps
              , map toLower (last ps)
              , intercalate "-" ps
              , intercalate "-" (map (map toLower) ps)
              , intercalate "_" ps
              ] ++ ps
         else []
    dashUnderscore id' =
      [ map (\c -> if c == '_' then '-' else c) id'
      , map (\c -> if c == '-' then '_' else c) id'
      ]
    withoutSpecialChars id' =
      let alnum = filter isAlphaNum id'
      in [alnum | not (null alnum) && alnum /= id']

searchIconByVariants :: FilePath -> IconConfig -> [FilePath] -> FilePath -> [String] -> IO FilePath
searchIconByVariants home cfg dirs err = go
  where
    go [] = pure err
    go (v:vs) = do
      p <- getIconPathFromIconName home cfg dirs err v
      if p == err then go vs else pure p

findNixStorePackage :: String -> IO (Maybe FilePath)
findNixStorePackage name = do
  mBin <- safeReadProcess "which" [name]
  case mBin of
    Nothing -> pure Nothing
    Just bin -> do
      mReal <- safeReadProcess "readlink" ["-f", bin]
      case mReal of
        Nothing -> pure Nothing
        Just real ->
          let parts = splitOn "/" real
              nixIdx = elemIndex "nix" parts >>= \i ->
                         if i + 1 < length parts && parts !! (i+1) == "store"
                         then Just (i+2) else Nothing
          in case nixIdx of
               Just idx | idx < length parts ->
                 let store = "/" </> intercalate "/" (take (idx+1) parts)
                 in doesDirectoryExist store >>= \e -> pure $ if e then Just store else Nothing
               _ -> pure Nothing

getShareDirs :: FilePath -> IconConfig -> IO [FilePath]
getShareDirs home cfg = do
  mXdgHome <- lookupEnv "XDG_DATA_HOME"
  mXdgDirs <- lookupEnv "XDG_DATA_DIRS"
  let homeData = fromMaybe (home </> ".local/share") mXdgHome
      sysData  = maybe [] (splitOn ":") mXdgDirs
      homeDirs = [homeData, home </> ".nix-profile/share"]
      nixSys   = ["/run/current-system/sw/share", "/etc/profiles/per-user/insomniac/share"]
      flatpak  = ["/var/lib/flatpak/exports/share", home </> ".local/share/flatpak/exports/share"]
      custom   = customIconDirs cfg
  pure $ custom ++ nixSys ++ homeDirs ++ flatpak ++ sysData

getIconNameFromDesktopFilePath :: FilePath -> IO (Maybe String)
getIconNameFromDesktopFilePath path = do
  mContent <- safeReadFile path
  case mContent of
    Nothing -> pure Nothing
    Just c  -> do
      let iconLines = filter (\l -> "Icon" `isPrefixOf` l && "=" `isInfixOf` l) (lines c)
          value l = dropWhile (==' ') $ drop 1 $ dropWhile (/='=') l
          nonLoc = [value l | l <- iconLines, "Icon=" `isPrefixOf` l]
          loc    = [value l | l <- iconLines, "Icon[" `isPrefixOf` l]
      pure $ listToMaybe (nonLoc ++ loc)

getIconPathFromIconName :: FilePath -> IconConfig -> [FilePath] -> FilePath -> String -> IO FilePath
getIconPathFromIconName _ cfg shareDirs err name = do
  if "/" `isPrefixOf` name
    then doesFileExist name >>= \e -> if e then pure name else search
    else search
  where
    search = do
      existing <- filterM doesFileExist allCands
      pure $ fromMaybe err (listToMaybe existing)

    themeDirs = [d </> "icons" </> t | d <- shareDirs, t <- preferredThemes cfg]
    pixDirs   = (</> "pixmaps") <$> shareDirs
    sz        = preferredSize cfg
    near      = [sz, sz+4, sz-4, sz+8, sz-8]
    far       = [48,40,64,16,72,96,128,192,256,512,1024] \\ near
    exts      = if preferSVG cfg then [".svg",".png"] else [".png",".svg"]

    scalable  = [d </> "scalable/apps" </> (name ++ ".svg") | d <- themeDirs]
    nearSz    = [d </> show s ++ "x" ++ show s </> "apps" </> (name ++ e)
                | d <- themeDirs, s <- near, e <- exts]
    farSz     = [d </> show s ++ "x" ++ show s </> "apps" </> (name ++ e)
                | d <- themeDirs, s <- far, e <- exts]
    pixCands  = [d </> (name ++ e) | d <- pixDirs, e <- [".svg",".png",".xpm"]]
    allCands  = scalable ++ nearSz ++ farSz ++ pixCands

(\\) :: Eq a => [a] -> [a] -> [a]
xs \\ ys = filter (`notElem` ys) xs

safeReadFile :: FilePath -> IO (Maybe String)
safeReadFile p = (Just <$> readFile p) `catch` \(_ :: SomeException) -> pure Nothing

safeListDirectory :: FilePath -> IO [FilePath]
safeListDirectory p = listDirectory p `catch` \(_ :: SomeException) -> pure []

safeReadProcess :: FilePath -> [String] -> IO (Maybe String)
safeReadProcess cmd args = do
  res <- (Just . trim <$> readProcess cmd args "") `catch` \(_ :: SomeException) -> pure Nothing
  pure $ case res of
           Just s | null s -> Nothing
           other           -> other
  where
    trim = dropWhileEnd isSpace . dropWhile isSpace
