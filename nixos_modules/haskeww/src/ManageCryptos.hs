{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent (threadDelay)
import Control.Lens ((^?!))
import Data.Aeson.Key (fromString)
import Data.Aeson.Lens (key, _Double)
import Data.Char (toLower)
import Data.List (intercalate)
import Data.List.Split (chunksOf)
import Data.Yaml (Value)
import EWWLib (update)
import Network.HTTP.Client (parseRequest)
import Network.HTTP.Simple (Response, getResponseBody, httpJSON)
import Numeric (showFFloat)
import System.Directory (getHomeDirectory)
import System.FilePath ((</>))
import Text.Printf (printf)

main :: IO ()
main = do
  home <- getHomeDirectory
  loop home [Bitcoin, Cardano, Encoins, Ethereum, Orcfax] 0

loop :: FilePath -> [Crypto] -> Int -> IO ()
loop home cryptos currentIndex = do
  case cryptos of
    (nextCrypto : _) -> tuplifyCrypto home nextCrypto newIndex
    _ -> pure ()
  threadDelay 15_000_000
  loop home (rotateCrypto cryptos) newIndex
  where
    newIndex :: Int
    newIndex = (currentIndex + 1) `mod` 2

tuplifyCrypto :: FilePath -> Crypto -> Int -> IO ()
tuplifyCrypto home nextCrypto newIndex = do
  let lowerNextCrypto :: String
      lowerNextCrypto = toLower <$> show nextCrypto
  request <-
    parseRequest $
      "https://api.coingecko.com/api/v3/simple/price?ids="
        <> lowerNextCrypto
        <> "&vs_currencies=cad"
  response <- httpJSON request :: IO (Response Value)
  let newCryptoImagePath :: String
      newCryptoImagePath = home </> ".config/eww/images/crypto" </> lowerNextCrypto <> ".png"

      newPrice :: String
      newPrice =
        formatPrice $
          getResponseBody response ^?! key (fromString lowerNextCrypto) . key "cad" . _Double
  update
    [ ("cryptoImagePath" <> show newIndex, newCryptoImagePath),
      ("cryptoPrice" <> show newIndex, newPrice),
      ("cryptoSelected", show newIndex)
    ]

formatPrice :: Double -> String
formatPrice x
  | x >= 1 = "$" <> addCommas intPart <> take 3 fracPart
  | otherwise = "$" <> showFFloat Nothing x ""
  where
    (intPart, fracPart) = span (/= '.') $ printf "%.2f" x

addCommas :: String -> String
addCommas xs = intercalate "," $ filter (not . null) [q] <> chunksOf 3 r
  where
    (q, r) = splitAt (length xs `mod` 3) xs

rotateCrypto :: [Crypto] -> [Crypto]
rotateCrypto [] = []
rotateCrypto (x : xs) = xs <> [x]

data Crypto
  = Cardano
  | Bitcoin
  | Encoins
  | Ethereum
  | Orcfax
  deriving (Show)
