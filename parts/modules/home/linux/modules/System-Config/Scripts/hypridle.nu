#!/usr/bin/env nu

let hypridleProcess = (ps | where name == "hypridle")
def hypridleChecker [hypridleProcess: table] {
  if ($hypridleProcess | length) > 0 { true } else { false }
}

(match (hypridleChecker $hypridleProcess)
  {true => (run-external "systemctl" "--user" "stop" "hypridle.service"; run-external "notify-send" "Stopping HyprIdle"),
   _ => (run-external "systemctl" "--user" "start" "hypridle.service"; run-external "notify-send" "Starting HyprIdle")})
