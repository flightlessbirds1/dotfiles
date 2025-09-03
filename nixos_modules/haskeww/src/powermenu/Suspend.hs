import EWWLib (update)
import System.Process (callCommand)

main :: IO ()
main = do
  update
    [ ("power", "false"),
      ("powermenuEventboxClass", "powermenuEventboxClosed")
    ]
  callCommand "systemctl suspend"
