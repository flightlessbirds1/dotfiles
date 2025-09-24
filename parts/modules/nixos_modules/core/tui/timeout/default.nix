{pkgs, ...}: {
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "15s";
  };
  systemd.services."user@".serviceConfig.TimeoutStopSec = "15s";

  systemd.services.kill-graphics = {
    description = "Force kill graphics processes";
    before = ["shutdown.target" "reboot.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'pkill -9 niri || true; pkill -9 xwayland || true'";
      RemainAfterExit = true;
    };
    wantedBy = ["shutdown.target" "reboot.target"];
  };
}
