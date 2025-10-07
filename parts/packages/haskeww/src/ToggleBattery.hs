import EWWLib (update)
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  update $
    case args of
      ["false"] ->
        [ ("batteryPopupVisible", "true"),
          ("batteryEventboxClass", "batteryEventboxOpen")
        ]
      _ ->
        [ ("batteryPopupVisible", "false"),
          ("batteryEventboxClass", "batteryEventboxClosed")
        ]
