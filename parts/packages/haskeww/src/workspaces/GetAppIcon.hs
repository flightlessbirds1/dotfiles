{-# LANGUAGE ScopedTypeVariables #-}

module GetAppIcon (getAppIcon, IconCache) where

import           Control.Exception   (SomeException, catch)
import           Control.Monad       (filterM, when)
import           Data.Char           (isAlphaNum, isDigit, isSpace, toLower)
import           Data.HashMap.Strict (HashMap, insert, lookup)
import           Data.List           (dropWhileEnd, elemIndex, intercalate,
                                      isInfixOf, isPrefixOf, isSuffixOf, sortBy)
import           Data.List.Split     (splitOn)
import           Data.Maybe          (catMaybes, fromMaybe, listToMaybe)
import           Data.Ord            (Down (..), comparing)
import           Data.Traversable    (for)
import           Prelude             hiding (lookup)
import           System.Directory    (doesDirectoryExist, doesFileExist,
                                      listDirectory)
import           System.Environment  (lookupEnv)
import           System.FilePath     (dropExtension, takeExtension,
                                      takeFileName, (</>))
import           System.IO           (hPutStrLn, stderr)
import           System.Process      (readProcess)

debugMode :: Bool
debugMode = True

debugLog :: String -> IO ()
debugLog msg = when debugMode $ hPutStrLn stderr $ "[GetAppIcon] " ++ msg

getAppIcon :: FilePath -> IconCache -> Maybe String -> IO (FilePath, IconCache)
getAppIcon home iconCache maybeAppID = case maybeAppID of
  Nothing -> pure (errorIcon, iconCache)
  Just appID -> case lookup appID iconCache of
    Just cachedPath -> do
      debugLog $ "Using cached icon for " ++ appID ++ ": " ++ cachedPath
      pure (cachedPath, iconCache)
    Nothing -> do
      debugLog $ "=== Searching icon for app: " ++ appID ++ " ==="
      result <- computeIconForAppID home errorIcon appID
      debugLog $ "Final result: " ++ result
      pure (result, insert appID result iconCache)
  where
    errorIcon :: FilePath
    errorIcon = home </> ".config/eww/images/error.png"

computeIconForAppID :: FilePath -> FilePath -> String -> IO FilePath
computeIconForAppID home errorIcon appID
  -- Equibop has corrupted icons in nixpkgs, use vesktop as fallback
  | appID == "equibop" = do
      debugLog "Equibop detected, using vesktop icon as fallback"
      shareDirs <- getShareDirs home
      getIconPathFromIconName home shareDirs errorIcon "vesktop"
  | otherwise = case splitOn "_" appID of
      ["steam", "app", steamID] | all isDigit steamID -> do
        debugLog $ "Detected Steam app: " ++ steamID
        let iconDir = home </> ".steam/steam/appcache/librarycache" </> steamID
        exists <- doesDirectoryExist iconDir
        if not exists
          then pure errorIcon
          else do
            files <- listDirectory iconDir
            let preferredFiles = ["library_600x900.jpg", "header.jpg", "icon.jpg"]
                candidates = filter (\f -> takeFileName f `elem` preferredFiles) files
                          ++ filter (\f -> takeExtension f == ".jpg" && length f > 30) files
            case listToMaybe candidates of
              Just iconFile -> pure $ iconDir </> iconFile
              Nothing       -> pure errorIcon
      _ -> do
        shareDirs <- getShareDirs home
        maybeDesktopPath <- findBestDesktopFile shareDirs appID

        case maybeDesktopPath of
          Just path -> do
            debugLog $ "Found desktop file: " ++ path
            maybeIconName <- getIconNameFromDesktopFilePath path
            case maybeIconName of
              Just iconName -> getIconPathFromIconName home shareDirs errorIcon iconName
              Nothing -> searchByAppID home shareDirs errorIcon appID
          Nothing -> searchByAppID home shareDirs errorIcon appID

searchByAppID :: FilePath -> [FilePath] -> FilePath -> String -> IO FilePath
searchByAppID home shareDirs errorIcon appID = do
  debugLog "No desktop file found, searching by app ID variants..."
  let variants = generateAppIDVariants appID
  debugLog $ "Generated variants: " ++ show variants
  searchIconByVariants home shareDirs errorIcon variants

findBestDesktopFile :: [FilePath] -> String -> IO (Maybe FilePath)
findBestDesktopFile shareDirs appID = do
  let appDirs = (</> "applications") <$> shareDirs
  existingAppDirs <- filterM doesDirectoryExist appDirs

  allDesktopFiles <- fmap concat . for existingAppDirs $ \dir -> do
    files <- safeListDirectory dir
    pure $ map (dir </>) $ filter (isSuffixOf ".desktop") files

  nixDesktopFiles <- findNixStoreDesktopFiles appID

  let allFiles = allDesktopFiles ++ nixDesktopFiles

  if null allFiles
    then pure Nothing
    else do
      scoredFiles <- mapM (scoreDesktopFile appID) allFiles
      let sortedFiles = sortBy (comparing (Down . fst)) scoredFiles

      debugLog $ "Top 5 desktop file matches:"
      mapM_ (\(score, path) -> debugLog $ "  " ++ show score ++ ": " ++ path) (take 5 sortedFiles)

      case sortedFiles of
        ((score, path):_) | score > 0 -> pure (Just path)
        _                             -> pure Nothing

scoreDesktopFile :: String -> FilePath -> IO (Int, FilePath)
scoreDesktopFile appID desktopPath = do
  let baseName = dropExtension $ takeFileName desktopPath
      lowerAppID = map toLower appID
      lowerBaseName = map toLower baseName

  let filenameScore
        | baseName == appID = 1000
        | lowerBaseName == lowerAppID = 900
        | lowerAppID `isInfixOf` lowerBaseName = 500
        | lowerBaseName `isInfixOf` lowerAppID = 400
        | any (\variant -> variant == lowerBaseName) (map (map toLower) (generateAppIDVariants appID)) = 300
        | otherwise = 0

  maybeContent <- safeReadFile desktopPath
  let contentScore = case maybeContent of
        Nothing -> 0
        Just content ->
          let lowerContent = map toLower content
              execMatch = ("exec=" ++ lowerAppID) `isInfixOf` lowerContent
              wmClassMatch = ("startupwmclass=" ++ lowerAppID) `isInfixOf` lowerContent
              iconMatch = ("icon=" ++ lowerAppID) `isInfixOf` lowerContent
          in (if execMatch then 200 else 0)
           + (if wmClassMatch then 150 else 0)
           + (if iconMatch then 100 else 0)

  pure (filenameScore + contentScore, desktopPath)

findNixStoreDesktopFiles :: String -> IO [FilePath]
findNixStoreDesktopFiles appID = do
  let variants = generateAppIDVariants appID
  nixPaths <- mapM findNixStorePackage variants
  let validPaths = catMaybes nixPaths

  fmap concat . for validPaths $ \nixPath -> do
    let appDir = nixPath </> "share/applications"
    exists <- doesDirectoryExist appDir
    if not exists
      then pure []
      else do
        files <- safeListDirectory appDir
        pure $ map (appDir </>) $ filter (isSuffixOf ".desktop") files

generateAppIDVariants :: String -> [String]
generateAppIDVariants appID =
  [ appID
  , map toLower appID
  ] ++ reverseDomainVariants appID
    ++ dashUnderscore appID
    ++ withoutSpecialChars appID
  where
    reverseDomainVariants id' =
      let parts = splitOn "." id'
      in if length parts > 1
         then [ last parts
              , map toLower (last parts)
              , intercalate "-" parts
              , intercalate "-" (map (map toLower) parts)
              , intercalate "_" parts
              ] ++ parts
         else []

    dashUnderscore id' =
      [ map (\c -> if c == '_' then '-' else c) id'
      , map (\c -> if c == '-' then '_' else c) id'
      ]

    withoutSpecialChars id' =
      let alphaNum = filter isAlphaNum id'
      in [alphaNum | not (null alphaNum) && alphaNum /= id']

searchIconByVariants :: FilePath -> [FilePath] -> FilePath -> [String] -> IO FilePath
searchIconByVariants home shareDirs errorIcon variants = go variants
  where
    go [] = pure errorIcon
    go (variant:rest) = do
      result <- getIconPathFromIconName home shareDirs errorIcon variant
      if result == errorIcon
        then go rest
        else pure result

findNixStorePackage :: String -> IO (Maybe FilePath)
findNixStorePackage appName = do
  maybePath <- safeReadProcess "which" [appName]
  case maybePath of
    Nothing -> pure Nothing
    Just binPath -> do
      maybeRealPath <- safeReadProcess "readlink" ["-f", binPath]
      case maybeRealPath of
        Nothing -> pure Nothing
        Just realPath ->
          let parts = splitOn "/" realPath
              nixStoreIdx = elemIndex "nix" parts >>= \i ->
                if i + 1 < length parts && parts !! (i + 1) == "store"
                then Just (i + 2) else Nothing
          in case nixStoreIdx of
               Just idx | idx < length parts ->
                 let storePath = "/" </> intercalate "/" (take (idx + 1) parts)
                 in do
                   exists <- doesDirectoryExist storePath
                   if exists then pure (Just storePath) else pure Nothing
               _ -> pure Nothing

getShareDirs :: FilePath -> IO [FilePath]
getShareDirs home = do
  xdgDataHome <- lookupEnv "XDG_DATA_HOME"
  xdgDataDirs <- lookupEnv "XDG_DATA_DIRS"

  let homeDataDir = fromMaybe (home </> ".local/share") xdgDataHome
      systemDataDirs = maybe [] (splitOn ":") xdgDataDirs
      homeDirs = [homeDataDir, home </> ".nix-profile/share"]
      nixSystemDirs = ["/run/current-system/sw/share", "/etc/profiles/per-user/insomniac/share"]
      flatpakDirs = ["/var/lib/flatpak/exports/share", home </> ".local/share/flatpak/exports/share"]

  pure $ nixSystemDirs ++ homeDirs ++ flatpakDirs ++ systemDataDirs

getIconNameFromDesktopFilePath :: FilePath -> IO (Maybe String)
getIconNameFromDesktopFilePath path = do
  maybeContent <- safeReadFile path
  case maybeContent of
    Nothing -> pure Nothing
    Just content -> do
      let iconLines = [line | line <- lines content, "Icon" `isPrefixOf` line, "=" `isInfixOf` line]
          iconValue line = dropWhile (== ' ') $ drop 1 $ dropWhile (/= '=') line
          nonLocalizedIcons = [iconValue line | line <- iconLines, "Icon=" `isPrefixOf` line]
          localizedIcons = [iconValue line | line <- iconLines, "Icon[" `isPrefixOf` line]
      pure $ listToMaybe (nonLocalizedIcons ++ localizedIcons)

getIconPathFromIconName :: FilePath -> [FilePath] -> FilePath -> String -> IO FilePath
getIconPathFromIconName _ shareDirs errorIcon iconName = do
  debugLog $ "Searching for icon: " ++ iconName
  if "/" `isPrefixOf` iconName
    then do
      exists <- doesFileExist iconName
      if exists then pure iconName else searchForIcon
    else searchForIcon
  where
    searchForIcon = do
      existingIconPaths <- filterM doesFileExist allCandidates
      when (null existingIconPaths && debugMode) $ do
        debugLog "No icon found! Checked these paths:"
        mapM_ (debugLog . ("  - " ++)) (take 20 allCandidates)
      pure $ fromMaybe errorIcon (listToMaybe existingIconPaths)

    hicolorDirs = (</> "icons/hicolor") <$> shareDirs
    themeDirs = [dir </> "icons" </> theme | dir <- shareDirs, theme <- ["Adwaita", "breeze", "Papirus", "gnome"]]
    allIconDirs = hicolorDirs ++ themeDirs
    pixmapDirs = (</> "pixmaps") <$> shareDirs

    scalableSvgs = [dir </> "scalable" </> "apps" </> (iconName <> ".svg") | dir <- allIconDirs]
    nearSizeSvgs = [dir </> size </> "apps" </> (iconName <> ".svg")
                   | dir <- allIconDirs, size <- ["28x28", "32x32", "24x24", "36x36", "22x22", "20x20"]]
    nearSizePngs = [dir </> size </> "apps" </> (iconName <> ".png")
                   | dir <- allIconDirs, size <- ["28x28", "32x32", "24x24", "36x36", "22x22", "20x20"]]
    otherSvgs = [dir </> size </> "apps" </> (iconName <> ".svg")
                | dir <- allIconDirs, size <- map (\n -> show n <> "x" <> show n)
                ([48, 40, 64, 16, 72, 96, 128, 192, 256, 512, 1024] :: [Int])]
    otherPngs = [dir </> size </> "apps" </> (iconName <> ".png")
                | dir <- allIconDirs, size <- map (\n -> show n <> "x" <> show n)
                ([48, 40, 64, 16, 72, 96, 128, 192, 256, 512, 1024] :: [Int])]
    pixmapCandidates = [dir </> (iconName <> ext) | dir <- pixmapDirs, ext <- [".svg", ".png", ".xpm"]]

    allCandidates = scalableSvgs ++ nearSizeSvgs ++ nearSizePngs ++ otherSvgs ++ otherPngs ++ pixmapCandidates

safeReadFile :: FilePath -> IO (Maybe String)
safeReadFile path = (Just <$> readFile path) `catch` \(_ :: SomeException) -> pure Nothing

safeListDirectory :: FilePath -> IO [FilePath]
safeListDirectory path = listDirectory path `catch` \(_ :: SomeException) -> pure []

safeReadProcess :: FilePath -> [String] -> IO (Maybe String)
safeReadProcess cmd args = do
  result <- (Just . trim <$> readProcess cmd args "") `catch` \(_ :: SomeException) -> pure Nothing
  pure $ case result of
    Just s | null s -> Nothing
    other           -> other
  where
    trim = dropWhileEnd isSpace . dropWhile isSpace

type IconCache = HashMap String FilePath
