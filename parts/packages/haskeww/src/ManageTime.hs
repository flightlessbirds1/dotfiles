{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE QuasiQuotes #-}

import Control.Concurrent (threadDelay)
import Data.Time (defaultTimeLocale, formatTime, getZonedTime, zonedTimeToUTC)
import Data.Time.Clock.POSIX (utcTimeToPOSIXSeconds)
import EWWLib (update)
import Text.RawString.QQ (r)

main :: IO ()
main = loop 0

loop :: Int -> IO ()
loop currentIndex = do
  now <- getZonedTime
  let posix :: Double
      posix = realToFrac . utcTimeToPOSIXSeconds $ zonedTimeToUTC now
  update
    [ ( "time" <> show newIndex,
        [r|(box
        :class "time"
        :vexpand true
        (label :text "|]
          <> formatTime defaultTimeLocale "%I:%M:%S %p, %A, %B %-e, %Y" now
          <> [r|")
      )|]
      ),
      ("timeSelected", show newIndex)
    ]
  threadDelay $ floor ((1 - (posix - fromIntegral (floor posix :: Int))) * 1_000_000) + 10_000
  loop newIndex
  where
    newIndex :: Int
    newIndex = (currentIndex + 1) `mod` 2
