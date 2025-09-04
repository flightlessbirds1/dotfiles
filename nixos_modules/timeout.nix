{...}: {
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "15s";
  };
  systemd.services."user@".serviceConfig.TimeoutStopSec = "15s";
}
