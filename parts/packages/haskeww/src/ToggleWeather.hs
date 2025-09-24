import EWWLib (update)
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  update $
    case args of
      ["false"] ->
        [ ("weatherPopupVisible", "true"),
          ("weatherEventboxClass", "weatherEventboxOpen")
        ]
      _ ->
        [ ("weatherPopupVisible", "false"),
          ("weatherEventboxClass", "weatherEventboxClosed")
        ]
