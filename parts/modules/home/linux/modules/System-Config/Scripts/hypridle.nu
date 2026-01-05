#!/usr/bin/env nu

let hypridleProcess = (ps | where name == "hypridle")
def hypridleChecker [hypridleProcess : table] {
  if (($hypridleProcess) | length) > 0 {true} else {false}
}

if (hypridleChecker $hypridleProcess) == true {run-external (systemctl --user stop hypridle.service)} else {run-external (systemctl --user start hypridle.service)}
