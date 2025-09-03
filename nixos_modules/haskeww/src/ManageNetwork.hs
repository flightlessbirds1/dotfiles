{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent (threadDelay)
import Data.List (find, isInfixOf)
import Data.Maybe (fromMaybe)
import Data.Text (pack)
import EWWLib (update)
import System.Process (readProcess)
import Text.Read (readMaybe)

main :: IO ()
main = loop

loop :: IO ()
loop = do
  updateNetworkStats
  threadDelay 1_000_000
  loop

updateNetworkStats :: IO ()
updateNetworkStats = do
  activeIface <- getActiveInterface
  (downBytes, upBytes) <- getNetworkStats activeIface
  update
    [ ("activeInterface", activeIface),
      ("netDown", show downBytes),
      ("netUp", show upBytes)
    ]

getActiveInterface :: IO String
getActiveInterface = do
  result <- readProcess "ip" ["route", "get", "8.8.8.8"] ""
  let routeWords = words result
  case findIndex "dev" routeWords of
    Just idx | idx + 1 < length routeWords -> return $ routeWords !! (idx + 1)
    _ -> return "wlp1s0"
  where
    findIndex :: String -> [String] -> Maybe Int
    findIndex x xs = find (\i -> xs !! i == x) [0..length xs - 1]

getNetworkStats :: String -> IO (Double, Double)
getNetworkStats iface = do
  result <- readProcess "cat" ["/proc/net/dev"] ""
  let devLines = lines result
      ifaceLine = find (isInfixOf iface) devLines
  case ifaceLine of
    Just line -> do
      let afterColon = drop 1 $ dropWhile (/= ':') line
          stats = words afterColon
      case stats of
        (rxBytes:_:_:_:_:_:_:_:txBytes:_) -> do
          let rx = fromMaybe 0.0 (readMaybe rxBytes :: Maybe Double)
              tx = fromMaybe 0.0 (readMaybe txBytes :: Maybe Double)
          return (rx / 1024, tx / 1024)
        _ -> return (0.0, 0.0)
    Nothing -> return (0.0, 0.0)