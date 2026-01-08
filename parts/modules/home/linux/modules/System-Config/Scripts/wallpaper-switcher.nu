#!/usr/bin/env nu

let Hour = (date now | format date "%H" | into int)
let imgDir = ("~/Desktop/dotfiles/deploy" | path expand | ls $in | find 1 2 3 --no-highlight | get name)

def check [hour: int] {
  match $hour {
    1..8 => (run-external "swww" "img" $imgDir.0)
    9..20 => (run-external "swww" "img" $imgDir.1)
    21..24 => (run-external "swww" "img" $imgDir.2)
  }
}

check $Hour
