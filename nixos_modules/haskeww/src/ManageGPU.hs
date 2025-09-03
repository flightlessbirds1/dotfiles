{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedStrings #-}

import Control.Concurrent (threadDelay)
import Control.Monad (forever)
import Data.Aeson (Value, decode, withObject, (.:))
import Data.Aeson.Types (Parser, parseMaybe)
import qualified Data.ByteString.Lazy.Char8 as BL
import Data.Text (Text, unpack)
import EWWLib (update)
import System.Process (readProcess)

main :: IO ()
main = forever $ do
  raw <- readProcess "rocm-smi" ["-u", "--json"] ""
  case decode (BL.pack raw) of
    Just val -> case parseMaybe extractGpu val of
      Just usage -> update [("gpu", unpack usage)]
      Nothing -> pure ()
    Nothing -> pure ()
  threadDelay 2_000_000

extractGpu :: Value -> Parser Text
extractGpu = withObject "top" $ \top ->
  top .: "card0" >>= withObject "card0" (.: "GPU use (%)")
