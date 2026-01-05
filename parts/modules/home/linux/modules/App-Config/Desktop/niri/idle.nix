{ pkgs, ... }:
let
  lockCmd = "${pkgs.swaylock}/bin/swaylock";
  displayOnCmd = "${pkgs.wlr-randr}/bin/wlr-randr --output ALL --on";
in
{
  home.packages = [
    pkgs.wlr-randr
  ];

  services.swayidle.enable = false;

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = lockCmd;
        before_sleep_cmd = lockCmd;
        after_sleep_cmd = displayOnCmd;
        ignore_dbus_inhibit = false;
      };
      listener = [
        {
          timeout = 300;
          on-timeout = lockCmd;
        }
      ];
    };
  };
}
