{-# LANGUAGE QuasiQuotes     #-}
{-# LANGUAGE RecordWildCards #-}

import           Data.List              (intercalate)
import           EWWLib                 (update)
import           GetAppIcon             (IconCache)
import           GetWorkspaceGroups     (Window (Window, windowIcon, windowIsFocused),
                                         Workspace (Workspace, workspaceIsFocused, workspaceMaybeWindows, workspaceOutput),
                                         getWorkspaceGroups)
import           Network.Socket         (Family (AF_UNIX),
                                         SockAddr (SockAddrUnix),
                                         SocketType (Stream), defaultProtocol,
                                         socket, socketToHandle)
import           Network.Socket.Address (connect)
import           System.Directory       (getHomeDirectory)
import           System.Environment     (getEnv)
import           System.FilePath        ((</>))
import           System.IO              (BufferMode (LineBuffering), Handle,
                                         IOMode (ReadWriteMode), hFlush,
                                         hGetLine, hPutStrLn, hSetBuffering)
import           Text.RawString.QQ      (r)

main :: IO ()
main = do
  socketPath <- getEnv "NIRI_SOCKET"
  sock <- socket AF_UNIX Stream defaultProtocol
  connect sock $ SockAddrUnix socketPath
  handle <- socketToHandle sock ReadWriteMode
  hPutStrLn handle [r|"EventStream"|]
  hFlush handle
  hSetBuffering handle LineBuffering
  home <- getHomeDirectory
  loop
    LoopInput
      { loopInputCurrentEWWString = "",
        loopInputHandle = handle,
        loopInputHome = home,
        loopInputIconCache = mempty,
        loopInputSelectedLiteral = 0
      }

loop :: LoopInput -> IO ()
loop currentLoopInput@(LoopInput {..}) = do
  _ <- hGetLine loopInputHandle
  (workspaceGroups, newIconCache) <- getWorkspaceGroups loopInputHome loopInputIconCache
  let newEWWString :: String
      newEWWString = makeWorkspaceGroupsEWWString loopInputHome workspaceGroups
      newSelectedLiteral :: Int
      newSelectedLiteral = (loopInputSelectedLiteral + 1) `mod` 2
  if newEWWString /= loopInputCurrentEWWString
    then do
      update
        [ ("workspacesSelected", show newSelectedLiteral),
          ("workspaces" <> show newSelectedLiteral, newEWWString)
        ]
      loop
        LoopInput
          { loopInputHandle = loopInputHandle,
            loopInputHome = loopInputHome,
            loopInputIconCache = newIconCache,
            loopInputCurrentEWWString = newEWWString,
            loopInputSelectedLiteral = newSelectedLiteral
          }
    else loop currentLoopInput

makeWorkspaceGroupsEWWString :: FilePath -> [[Workspace]] -> String
makeWorkspaceGroupsEWWString home workspaceGroups =
  [r|(box
  :space-evenly false
  :spacing 4
  :vexpand true
|]
    <> intercalate "\n" (makeWorkspaceGroupEWWString home <$> workspaceGroups)
    <> [r|
)|]

makeWorkspaceGroupEWWString :: FilePath -> [Workspace] -> String
makeWorkspaceGroupEWWString home workspaceGroup =
  [r|  (box
    :class "workspaceGroup"
    :space-evenly false
    :spacing 4
    (label :text "|]
    <> ( case workspaceGroup of
           (Workspace {..} : _) -> workspaceOutput
           _                    -> "ERROW"
       )
    <> [r|")
|]
    <> intercalate "\n" (makeWorkspaceEWWString home <$> workspaceGroup)
    <> [r|
  )|]

makeWorkspaceEWWString :: FilePath -> Workspace -> String
makeWorkspaceEWWString home Workspace {..} =
  [r|    (box
      :class "workspace|]
    <> (if workspaceIsFocused then "F" else "Unf")
    <> [r|ocused"
      :valign "center"
|]
    <> makeImageBoxEWWString home workspaceMaybeWindows workspaceIsFocused
    <> [r|
    )|]

makeImageBoxEWWString :: FilePath -> Maybe [Window] -> Bool -> String
makeImageBoxEWWString home Nothing workspaceIsFocused =
  [r|      (image
        :class "image|]
    <> classStringSegment
    <> [r|ocused"
        :image-height 28
          :image-width 28
        :path "|]
    <> (home </> ".config/eww/images/empty_set_" <> emptySetStringSegment <> ".svg")
    <> [r|"
      )|]
  where
    (classStringSegment, emptySetStringSegment)
      | workspaceIsFocused = ("F", "dark")
      | otherwise = ("Unf", "light")
makeImageBoxEWWString _ (Just windows) _ =
  intercalate "\n" $
    ( \Window {..} -> do
        [r|      (image
        :class "image|]
          <> ( if windowIsFocused
                 then "F"
                 else "Unf"
             )
          <> [r|ocused"
        :image-height 28
        :image-width 28
        :path "|]
          <> windowIcon
          <> [r|"
      )|]
    )
      <$> windows

data LoopInput = LoopInput
  { loopInputCurrentEWWString :: String,
    loopInputHandle           :: Handle,
    loopInputHome             :: FilePath,
    loopInputIconCache        :: IconCache,
    loopInputSelectedLiteral  :: Int
  }
