module GetAppIcon (getAppIcon, IconCache) where

import           Control.Monad       (filterM)
import           Data.Char           (isAlphaNum, isDigit, toLower)
import           Data.HashMap.Strict (HashMap, insert, lookup)
import           Data.List           (isInfixOf, isPrefixOf, isSuffixOf)
import           Data.List.Split     (splitOn)
import           Data.Maybe          (fromMaybe, listToMaybe)
import           Data.Traversable    (for)
import           Prelude             hiding (lookup)
import           System.Directory    (doesDirectoryExist, doesFileExist,
                                      listDirectory)
import           System.FilePath     (takeExtension, takeFileName, (</>))

getAppIcon :: FilePath -> IconCache -> Maybe String -> IO (FilePath, IconCache)
getAppIcon home iconCache maybeAppID = case maybeAppID of
  Nothing -> pure (errorIcon, iconCache)
  Just appID -> case lookup appID iconCache of
    Just cachedPath -> pure (cachedPath, iconCache)
    Nothing -> do
      result <- computeIconForAppID home errorIcon appID
      pure (result, insert appID result iconCache)
  where
    errorIcon :: FilePath
    errorIcon = home </> ".config/eww/images/error.png"

computeIconForAppID :: FilePath -> FilePath -> String -> IO FilePath
computeIconForAppID home errorIcon appID = do
  case splitOn "_" appID of
    ["steam", "app", steamID] | all isDigit steamID -> do
      let iconDir :: FilePath
          iconDir = home </> ".steam/steam/appcache/librarycache" </> steamID
      exists <- doesDirectoryExist iconDir
      if not exists
        then pure errorIcon
        else do
          files <- listDirectory iconDir
          let candidates :: [FilePath]
              candidates = filter (\f -> takeExtension f == ".jpg" && length f > 30) files
          case listToMaybe candidates of
            Just iconFile -> pure $ iconDir </> iconFile
            Nothing       -> pure errorIcon
    _ -> do
      let normalizedAppID :: String
          normalizedAppID
            | "steam_app_" `isPrefixOf` appID = "steam"
            | "." `isPrefixOf` appID = takeWhile isAlphaNum $ dropWhile (not . isAlphaNum) appID
            | otherwise = appID
          shareDirs :: [FilePath]
          shareDirs = getShareDirs home
      maybeDesktopPath <- getDesktopFileFromAppID shareDirs normalizedAppID
      case maybeDesktopPath of
        Just path -> do
          maybeIconName <- getIconNameFromDesktopFilePath path
          case maybeIconName of
            Just iconName -> getIconPathFromIconName shareDirs errorIcon iconName
            Nothing -> pure errorIcon
        Nothing -> getIconPathFromIconName shareDirs errorIcon normalizedAppID

getShareDirs :: FilePath -> [FilePath]
getShareDirs home = nixDirs ++ homeDirs ++ [runDir]
  where
    homeDirs :: [FilePath]
    homeDirs = (home </>) <$> [".local/share", ".nix-profile/share"]
    runDir :: FilePath
    runDir = "/run/current-system/sw/share"
    nixDirs :: [FilePath]
    nixDirs = ["/etc/profiles/per-user/insomniac/share"]

getDesktopFileFromAppID :: [FilePath] -> String -> IO (Maybe FilePath)
getDesktopFileFromAppID shareDirs appName = do
  let appDirs :: [FilePath]
      appDirs = (</> "applications") <$> shareDirs
  existingAppDirs <- filterM doesDirectoryExist appDirs
  let deskPaths :: [FilePath]
      deskPaths = [dir </> (appName <> ".desktop") | dir <- existingAppDirs]
  existingDeskPaths <- filterM doesFileExist deskPaths
  case listToMaybe existingDeskPaths of
    Just exactDeskPath -> pure $ Just exactDeskPath
    Nothing -> do
      allDesktopFiles <- fmap concat . for existingAppDirs $ \dir -> do
        files <- listDirectory dir
        pure $ filter (isSuffixOf ".desktop") $ (dir </>) <$> files
      let matchingDeskFiles :: [FilePath]
          matchingDeskFiles =
            filter
              (\deskFile -> map toLower appName `isInfixOf` map toLower (takeFileName deskFile))
              allDesktopFiles
      case listToMaybe matchingDeskFiles of
        Just fuzzyDeskPath -> pure $ Just fuzzyDeskPath
        Nothing -> do
          matchInContent <-
            filterM
              ( \deskPath -> do
                  content <- readFile deskPath
                  let lowerAppId :: String
                      lowerAppId = map toLower appName
                      lns :: [String]
                      lns = map (map toLower) $ lines content
                      prefixes :: [String]
                      prefixes = ["exec=", "startupwmclass=", "icon="]
                  pure $ any (\line -> any (`isPrefixOf` line) prefixes && lowerAppId `isInfixOf` line) lns
              )
              allDesktopFiles
          pure $ listToMaybe matchInContent

getIconNameFromDesktopFilePath :: FilePath -> IO (Maybe String)
getIconNameFromDesktopFilePath path = do
  content <- readFile path
  pure $ listToMaybe [drop (length iconEquals) line | line <- lines content, iconEquals `isPrefixOf` line]
  where
    iconEquals :: String
    iconEquals = "Icon="

getIconPathFromIconName :: [FilePath] -> FilePath -> String -> IO FilePath
getIconPathFromIconName shareDirs errorIcon iconName = do
  existingIconPaths <- filterM doesFileExist allCandidates

  pure $ fromMaybe errorIcon (listToMaybe existingIconPaths)
  where
    hicolorDirs :: [FilePath]
    hicolorDirs = (</> "icons/hicolor") <$> shareDirs
    pixmapDirs :: [FilePath]
    pixmapDirs = (</> "pixmaps") <$> shareDirs
    sizes :: [String]

    sizes =
        ( (\n -> show n <> "x" <> show n)
          <$> [64 :: Int, 96, 128, 48, 72, 192, 256, 512, 32, 36, 40, 24, 22, 20, 16]
        )
          <> ["scalable"]
    hicolorCandidates :: [FilePath]
    hicolorCandidates =
      [ dir </> size </> "apps" </> (iconName <> ext)
        | dir <- hicolorDirs,
          size <- sizes,
          ext <- [".png", ".svg"]
      ]
    pixmapCandidates :: [FilePath]
    pixmapCandidates = [dir </> (iconName <> ext) | dir <- pixmapDirs, ext <- [".xpm", ".png"]]
    allCandidates :: [FilePath]
    allCandidates = hicolorCandidates ++ pixmapCandidates

type IconCache = HashMap String FilePath
