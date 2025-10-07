{-# LANGUAGE NumericUnderscores #-}

import Control.Concurrent (threadDelay)
import EWWLib (update)
import System.Process (readProcess)
import Text.Read (readMaybe)

main :: IO ()
main = do
  loop 0

loop :: Int -> IO ()
loop currentIndex = do
  calculateBatteryTime currentIndex
  threadDelay 20_000_000 -- Update every 20 seconds
  loop newIndex
  where
    newIndex :: Int
    newIndex = (currentIndex + 1) `mod` 2

calculateBatteryTime :: Int -> IO ()
calculateBatteryTime newIndex = do
  -- Read battery data
  capacityStr <- readProcess "cat" ["/sys/class/power_supply/BATT/capacity"] ""
  statusStr <- readProcess "cat" ["/sys/class/power_supply/BATT/status"] ""
  currentNowStr <- readProcess "cat" ["/sys/class/power_supply/BATT/current_now"] ""
  chargeNowStr <- readProcess "cat" ["/sys/class/power_supply/BATT/charge_now"] ""

  let capacity = maybe 0 id (readMaybe (init capacityStr) :: Maybe Double)
      currentNow = maybe 1 id (readMaybe (init currentNowStr) :: Maybe Double) -- microamps
      chargeNow = maybe 0 id (readMaybe (init chargeNowStr) :: Maybe Double) -- microamp-hours
      status = init statusStr

  -- Calculate time remaining in hours
  let timeRemaining =
        if currentNow > 0 && status == "Discharging"
          then chargeNow / currentNow -- µAh / µA = hours
          else 0
      timeRoundedStr = show (fromIntegral (round (timeRemaining * 10 :: Double) :: Int) / (10 :: Double))

  update
    [ ("batteryTimeRemaining" <> show newIndex, timeRoundedStr)
    ]
