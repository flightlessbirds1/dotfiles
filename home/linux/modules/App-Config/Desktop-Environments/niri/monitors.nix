{
  username,
  hostname,
  flake,
  lib,
  ...
}:

let
  helper = import ../../../../../../lib/Helper-Functions/System-dependent-checker.nix;
in

{
  programs.niri.settings = helper.system-dependent-checker {
    inherit username hostname;
    concatenation_type = "attribute";
    portable_content = { };
    laptop_content = {
      outputs = {
        "eDP-1" = {
          mode = {
            width = 2880;
            height = 1800;
            refresh = 90.0;
          };
          position = {
            x = 0;
            y = 0;
          };
        };
      };
    };
    desktop_content = {
      outputs = {
        "DP-1" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 180.002;
          };
          position = {
            x = 0;
            y = 0;
          };
        };
        "DP-2" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 180.002;
          };
          position = {
            x = 2560;
            y = 0;
          };
        };
        # DP-1.transform.rotation = 90;
      };

    };
    backup_content = { };

  };

}
