import EWWLib (update)
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  update $
    case args of
      ["false"] ->
        [ ("power", "true"),
          ("powermenuEventboxClass", "powermenuEventboxOpen")
        ]
      _ ->
        [ ("power", "false"),
          ("powermenuEventboxClass", "powermenuEventboxClosed")
        ]
