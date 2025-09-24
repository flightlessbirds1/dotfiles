{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent (threadDelay)
import Control.Lens ((^?!))
import Data.Aeson.Lens (key, nth, _Double, _String)
import Data.Text (unpack)
import Data.Yaml (Value)
import EWWLib (update)
import Network.HTTP.Client (parseRequest)
import Network.HTTP.Simple (getResponseBody, httpJSON)
import System.Directory (getHomeDirectory)
import System.Environment (getEnv)
import System.FilePath ((</>))

main :: IO ()
main = do
  home <- getHomeDirectory
  location <- getEnv "WEATHER_LOCATION"
  loop home location 0

loop :: FilePath -> String -> Int -> IO ()
loop home location currentIndex = do
  apiKey <- getEnv "WEATHER_API_KEY"
  request <-
    parseRequest $
      "http://api.openweathermap.org/data/2.5/weather?APPID="
        <> apiKey
        <> "&lat="
        <> takeWhile (/= ',') location
        <> "&lon="
        <> drop 1 (dropWhile (/= ',') location)
        <> "&units=imperial"
  response <- httpJSON request
  let body :: Value
      body = getResponseBody response
  print body -- Debug: print the full response
  let newIcon :: FilePath
      newIcon =
        home
          </> ".config/eww/images/weather"
          </> unpack (body ^?! key "weather" . nth 0 . key "icon" . _String) <> ".png"
      newTemperature :: String
      newTemperature = show (round (body ^?! key "main" . key "temp" . _Double)) <> "°F"
      newDescription :: String
      newDescription = unpack (body ^?! key "weather" . nth 0 . key "description" . _String)
      newFeelsLike :: String
      newFeelsLike = show (round (body ^?! key "main" . key "feels_like" . _Double)) <> "°F"
      newHumidity :: String
      newHumidity = show (round (body ^?! key "main" . key "humidity" . _Double))
      newPressure :: String
      newPressure = show (round (body ^?! key "main" . key "pressure" . _Double))
      newWindSpeed :: String
      newWindSpeed = show (round (body ^?! key "wind" . key "speed" . _Double))
  update
    [ ("weatherImagePath" <> show newIndex, newIcon),
      ("temperature" <> show newIndex, newTemperature),
      ("weatherDescription" <> show newIndex, newDescription),
      ("weatherFeelsLike" <> show newIndex, newFeelsLike),
      ("weatherHumidity" <> show newIndex, newHumidity),
      ("weatherPressure" <> show newIndex, newPressure),
      ("weatherWindSpeed" <> show newIndex, newWindSpeed),
      ("weatherSelected", show newIndex)
    ]
  threadDelay 15_000_000
  loop home location newIndex
  where
    newIndex :: Int
    newIndex = (currentIndex + 1) `mod` 2
