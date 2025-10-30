{-# LANGUAGE NumericUnderscores #-}
import           Control.Concurrent (threadDelay)
import           Control.Exception  (SomeException, catch)
import           EWWLib             (update)
import           System.Process     (readProcess)
import           Text.Printf        (printf)
import           Text.Read          (readMaybe)

main :: IO ()
main = loop 0

loop :: Int -> IO ()
loop currentIndex = do
  calculateBatteryTime currentIndex
  threadDelay 5_000_000 -- Update every 5 seconds
  loop newIndex
  where
    newIndex = (currentIndex + 1) `mod` 2

calculateBatteryTime :: Int -> IO ()
calculateBatteryTime _newIndex = do
  result <- catch readBatteryData handleError
  case result of
    Just (capacity, status, currentNow, chargeNow, chargeFull) -> do
      let (_timeRemaining, timeStr) = calculateTime status currentNow chargeNow chargeFull
      update
        [ ("batteryTimeRemaining0", timeStr)
        , ("batteryTimeRemaining1", timeStr)
        , ("batteryStatus", status)
        , ("batteryCapacity", show (round capacity :: Int))
        ]
    Nothing ->
      update
        [ ("batteryTimeRemaining0", "N/A")
        , ("batteryTimeRemaining1", "N/A")
        ]

readBatteryData :: IO (Maybe (Double, String, Double, Double, Double))
readBatteryData = do
  capacityStr <- readProcess "cat" ["/sys/class/power_supply/BATT/capacity"] ""
  statusStr   <- readProcess "cat" ["/sys/class/power_supply/BATT/status"] ""
  currentNowStr <- readProcess "cat" ["/sys/class/power_supply/BATT/current_now"] ""
  chargeNowStr  <- readProcess "cat" ["/sys/class/power_supply/BATT/charge_now"] ""
  chargeFullStr <- readProcess "cat" ["/sys/class/power_supply/BATT/charge_full"] ""
  let capacity   = readMaybe (init capacityStr) :: Maybe Double
      currentNow = readMaybe (init currentNowStr) :: Maybe Double
      chargeNow  = readMaybe (init chargeNowStr) :: Maybe Double
      chargeFull = readMaybe (init chargeFullStr) :: Maybe Double
      status     = init statusStr
  return $ do
    c    <- capacity
    curr <- currentNow
    now  <- chargeNow
    full <- chargeFull
    return (c, status, curr, now, full)

calculateTime :: String -> Double -> Double -> Double -> (Double, String)
calculateTime status currentNow chargeNow chargeFull
  | status == "Discharging" && currentNow > 0 =
      let hours = chargeNow / currentNow
      in (hours, formatTime hours)
  | status == "Charging" && currentNow > 0 =
      let hours = (chargeFull - chargeNow) / currentNow
      in (hours, formatTime hours)
  | status == "Full"        = (0, "Full")
  | status == "Not charging" = (0, "N/C")
  | otherwise               = (0, "N/A")

formatTime :: Double -> String
formatTime hours
  | hours < 0 = "N/A"
  | hours >= 24 = ">24h"
  | otherwise =
      let totalMinutes = round (hours * 60) :: Int
          h = totalMinutes `div` 60
          m = totalMinutes `mod` 60
      in printf "%d:%02d" h m

handleError :: SomeException -> IO (Maybe a)
handleError _ = return Nothing
