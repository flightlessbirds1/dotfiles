module EWWLib where

import System.Process (callProcess)

update :: [(String, String)] -> IO ()
update tuples =
  callProcess "eww" $ testingArgs <> ("update" : ((\(var, val) -> var <> "=" <> val) <$> tuples))

-- When not testing just switch this for the empty list.
testingArgs :: [String]
testingArgs = []

-- testingArgs = ["--config", "/home/insomniac/dotfiles/parts/modules/home_manager/eww/desktop_eww/config"]
