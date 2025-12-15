{
  username,
  hostname,
  flake,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    monitor = flake.self.dependent-checker.function {
      inherit
        username
        hostname
        ;
      concatenation_type = "list";
      portable_content = [ ];
      laptop_content = [
        "DP-1,2880x1800@90,auto,auto"
      ];
      desktop_content = [
        "DP-1,2560x1440@180,0x0,auto"
        "DP-2,2560x1440@180,2560x0,auto"
      ];
      backup_content = [ ];
    };
  };
}
