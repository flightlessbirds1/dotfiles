{-# LANGUAGE OverloadedRecordDot #-}
{-# LANGUAGE OverloadedStrings   #-}

module GetWorkspaceGroups
  ( Window (Window, windowIcon, windowIsFocused),
    Workspace (Workspace, workspaceIsFocused, workspaceMaybeWindows, workspaceOutput),
    getWorkspaceGroups,
  )
where

import           Control.Monad             (foldM)
import           Data.Aeson                (FromJSON, Value, eitherDecode,
                                            parseJSON, withObject, (.:), (.:?))
import           Data.Aeson.KeyMap         (elems)
import           Data.Aeson.Types          (Parser, parseEither)
import           Data.ByteString.Lazy.UTF8 (ByteString, fromString)
import           Data.Function             (on)
import           Data.List                 (elemIndex, groupBy, sortOn)
import           Data.Maybe                (fromMaybe, mapMaybe)
import           GetAppIcon                (IconCache, defaultIconConfig,
                                            getAppIcon)
import           System.Process            (readProcess)

getWorkspaceGroups :: FilePath -> IconCache -> IO ([[Workspace]], IconCache)
getWorkspaceGroups home currentIconCache = do
  outputsRawStr <- readProcess "niri" ["msg", "--json", "outputs"] ""
  windowsRawStr <- readProcess "niri" ["msg", "--json", "windows"] ""
  workspacesRawStr <- readProcess "niri" ["msg", "--json", "workspaces"] ""
  let outputsRaw :: ByteString
      outputsRaw = fromString outputsRawStr
      windowsRaw :: ByteString
      windowsRaw = fromString windowsRawStr
      workspacesRaw :: ByteString
      workspacesRaw = fromString workspacesRawStr
  case eitherDecode outputsRaw of
    Left err -> error $ "Failed to decode outputs: " <> err
    Right outputsObj -> do
      let outputValues :: [Value]
          outputValues = elems outputsObj
          parsedOutputs :: [Either String Output]
          parsedOutputs = map (parseEither parseJSON) outputValues
      case sequence parsedOutputs of
        Left err -> error $ "Failed to parse outputs: " <> err
        Right outputs -> do
          let sortedOutputs :: [Output]
              sortedOutputs = outputX `sortOn` outputs
              outputOrder :: [String]
              outputOrder = outputName <$> sortedOutputs
          case eitherDecode windowsRaw :: Either String [WindowBase] of
            Left err -> error $ "Failed to decode windows: " <> err
            Right allWindowsBase -> do
              let windowsBase = filter (\wb -> windowBaseWorkspaceId wb /= Nothing) allWindowsBase
              (enrichedWindows, finalIconCache) <-
                foldM
                  ( \(windows, currentIconCache') wb -> do
                      (icon, newCache) <- getAppIcon home currentIconCache' defaultIconConfig (windowBaseAppID wb)
                      let window :: Window
                          window =
                            Window
                              (windowBaseAppID wb)
                              (windowBaseId wb)
                              (windowBaseIsFocused wb)
                              (fromMaybe 0 $ windowBaseWorkspaceId wb)
                              icon
                              (windowBasePosInScrollingLayout wb)
                      pure (windows ++ [window], newCache)
                  )
                  ([], currentIconCache)
                  windowsBase
              case eitherDecode workspacesRaw of
                Left err -> error $ "Failed to decode workspaces: " <> err
                Right wsVals -> do
                  let parsedWorkspaces :: [Either String Workspace]
                      parsedWorkspaces = map (parseEither (parseWorkspace enrichedWindows)) wsVals
                  case sequence parsedWorkspaces of
                    Left err -> error $ "Failed to parse workspace values: " <> err
                    Right workspaces -> do
                      let filteredWorkspaces = filter (\ws -> workspaceIsFocused ws || workspaceMaybeWindows ws /= Nothing) workspaces
                          sortByOutputOrder :: Workspace -> Int
                          sortByOutputOrder ws =
                            fromMaybe 9999 $ ws.workspaceOutput `elemIndex` outputOrder
                          groupedByOutput :: [[Workspace]]
                          groupedByOutput =
                            groupBy ((==) `on` workspaceOutput) $
                              sortOn sortByOutputOrder filteredWorkspaces
                          sorted :: [[Workspace]]
                          sorted = sortOn workspaceIdx <$> groupedByOutput
                      pure (sorted, finalIconCache)

parseWorkspace :: [Window] -> Value -> Parser Workspace
parseWorkspace windows = withObject "Workspace" $ \v -> do
  idx <- v .: "idx"
  isActive <- v .: "is_active"
  isFocused <- v .: "is_focused"
  name <- v .:? "name"
  output <- v .: "output"
  workspaceId <- v .: "id"
  let allWindows :: [Window]
      allWindows = filter ((== workspaceId) . windowWorkspaceId) windows
      sortedWindows :: [Window]
      sortedWindows = sortOn windowPosInScrollingLayout allWindows
      maybeWindows :: Maybe [Window]
      maybeWindows = if null sortedWindows then Nothing else Just sortedWindows
  pure $ Workspace maybeWindows idx isActive isFocused name output

data Output = Output
  { outputName :: String,
    outputX    :: Int
  }
  deriving (Show, Eq)

data Window = Window
  { windowAppID                :: Maybe String,
    windowId                   :: Int,
    windowIsFocused            :: Bool,
    windowWorkspaceId          :: Int,
    windowIcon                 :: FilePath,
    windowPosInScrollingLayout :: (Int, Int)
  }
  deriving (Show, Eq)

data WindowBase = WindowBase
  { windowBaseAppID                :: Maybe String,
    windowBaseId                   :: Int,
    windowBaseIsFocused            :: Bool,
    windowBaseWorkspaceId          :: Maybe Int,
    windowBasePosInScrollingLayout :: (Int, Int)
  }
  deriving (Show)

data Workspace = Workspace
  { workspaceMaybeWindows :: Maybe [Window],
    workspaceIdx          :: Int,
    workspaceIsActive     :: Bool,
    workspaceIsFocused    :: Bool,
    workspaceName         :: Maybe String,
    workspaceOutput       :: String
  }
  deriving (Show, Eq)

instance FromJSON Output where
  parseJSON = withObject "Output" $ \v -> do
    name <- v .: "name"
    logical <- v .: "logical"
    x <- logical .: "x"
    pure $ Output name x

instance FromJSON WindowBase where
  parseJSON = withObject "WindowBase" $ \v -> do
    appID <- v .: "app_id"
    windowID <- v .: "id"
    isFocused <- v .: "is_focused"
    workspaceID <- v .:? "workspace_id"
    layout <- v .: "layout"
    posInScrollingLayout <- layout .: "pos_in_scrolling_layout"
    pure $ WindowBase appID windowID isFocused workspaceID posInScrollingLayout
