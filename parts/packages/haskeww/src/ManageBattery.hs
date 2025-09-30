{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedStrings  #-}

import           Control.Concurrent   (threadDelay)
import           Data.Text            (Text, pack)
import           Data.Void            (Void)
import           EWWLib               (update)
import           System.Directory     (getHomeDirectory)
import           System.FilePath      ((</>))
import           System.Process       (readProcess)
import           Text.Megaparsec      (Parsec, parse, (<|>))
import           Text.Megaparsec.Char (string)
import           Text.Read            (readMaybe)

main :: IO ()
main = do
  home <- getHomeDirectory
  loop home 0

loop :: FilePath -> Int -> IO ()
loop home currentIndex = do
  tuplifyBattery home newIndex
  threadDelay 1_000_000
  loop home newIndex
  where
    newIndex :: Int
    newIndex = (currentIndex + 1) `mod` 2

tuplifyBattery :: FilePath -> Int -> IO ()
tuplifyBattery home newIndex = do
  status <- readProcess "cat" ["/sys/class/power_supply/BATT/status"] ""
  capacity <- readProcess "cat" ["/sys/class/power_supply/BATT/capacity"] ""
  let (newBatteryClass, newBatteryText) = getBatteryClassAndText home capacity status
  update
    [ ("batteryClass" <> show newIndex, newBatteryClass),
      ("batteryImagePath" <> show newIndex, newBatteryText),
      ("batterySelected", show newIndex)
    ]

getBatteryClassAndText :: FilePath -> String -> String -> (String, String)
getBatteryClassAndText home capacityText statusText = case ( parse statusParser "" $ pack statusText,
                                                             readMaybe capacityText :: Maybe Int
                                                           ) of
  (Right Charging, Just capacity) | capacity > 90 ->
    ("batteryGreen", batImagePath </> "discharging" </> "6.svg")
  (Right Charging, Just capacity) ->
    ("batteryYellow", batImagePath </> "charging" </> capacityToIcon capacity <> ".svg")
  (Right _, Just capacity) ->
    (capacityToClass capacity, batImagePath </> "discharging" </> capacityToIcon capacity <> ".svg")
  _ -> ("ERROR", "ERROR")
  where
    batImagePath :: String
    batImagePath = home </> ".config/eww/images/battery"
    capacityToClass :: Int -> String
    capacityToClass c
      | c <= 30 = "batteryRed"
      | c <= 60 = "batteryPeach"
      | otherwise = "batteryGreen"
    capacityToIcon :: Int -> String
    capacityToIcon c
      | c <= 20 = "0"
      | c <= 30 = "1"
      | c <= 50 = "2"
      | c <= 60 = "3"
      | c <= 80 = "4"
      | c <= 90 = "5"
      | otherwise = "6"

statusParser :: Parser BatteryState
statusParser =
  Charging
    <$ string "Charging"
      <|> Discharging
    <$ string "Discharging"
      <|> Full
    <$ string "Full"

data BatteryState
  = Charging
  | Discharging
  | Full

type Parser = Parsec Void Text
