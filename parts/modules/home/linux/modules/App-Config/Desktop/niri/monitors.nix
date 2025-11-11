{
  username,
  hostname,
  flake,
  ...
}: {
  programs.niri.settings = flake.self.dependent-checker.function {
    inherit
      username
      hostname
      ;
    concatenation_type = "attribute";
    portable_content = {};
    laptop_content = {
      outputs = {
        "eDP-1" = {
          mode = {
            width = 1920;
            height = 1200;
            refresh = 90.001;
          };
          position = {
            x = 0;
            y = 0;
          };
          scale = 1.17;
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
    backup_content = {};
  };
}
