{-# LANGUAGE NumericUnderscores #-}

import Control.Concurrent (threadDelay)
import Data.Char (isSpace)
import Data.List (dropWhileEnd)
import EWWLib (update)

main :: IO ()
main = loop

trim :: String -> String
trim = dropWhileEnd isSpace . dropWhile isSpace

loop :: IO ()
loop = do
  status <- readFile "/sys/class/drm/card1/device/power/runtime_status"
  if trim status == "suspended"
    then 
      update [("gpu", "0")]
    else do
      usage <- readFile "/sys/class/drm/card1/device/gpu_busy_percent"
      let cleanUsage = filter (`elem` ['0'..'9']) usage
      update [("gpu", cleanUsage)]
  threadDelay 1_000_000
