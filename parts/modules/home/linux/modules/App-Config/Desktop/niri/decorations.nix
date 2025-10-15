{osConfig, ...}: {
  programs.niri.settings = {
    window-rules =
      [
        {
          geometry-corner-radius = {
            top-left = 10.0;
            top-right = 10.0;
            bottom-left = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
        }
      ]
      ++ (
        if osConfig.networking.hostName == "desktop"
        then [
          {
            matches = [
              {
                app-id = "ghostty";
              }
              {
                app-id = "org.gnome.Nautilus";
              }
              {
                app-id = "code";
              }
              {
                app-id = "codium";
              }
              {
                app-id = "zed";
              }
            ];
            open-on-workspace = "01-code";
            open-maximized = true;
          }
          {
            matches = [
              {
                app-id = "firefox";
              }
            ];
            open-on-workspace = "02-web";
            open-maximized = true;
          }
          {
            matches = [
              {
                app-id = "spotify";
              }
            ];
            open-on-workspace = "03-music";
            open-maximized = true;
          }
          {
            matches = [
              {
                app-id = "vesktop";
              }
              {
                app-id = "discord";
              }
              {
                app-id = "signal-desktop";
              }
              {
                app-id = "equibop";
              }
            ];
            open-on-workspace = "04-chat";
            open-maximized = true;
          }
        ]
        else [
          {
            matches = [
              {
                app-id = "ghostty";
              }
              {
                app-id = "org.gnome.Nautilus";
              }
              {
                app-id = "code";
              }
              {
                app-id = "codium";
              }
              {
                app-id = "zed";
              }
            ];
            open-on-workspace = "01-code";
            open-maximized = true;
          }
          {
            matches = [
              {
                app-id = "firefox";
              }
            ];
            open-on-workspace = "02-web";
            open-maximized = true;
          }
        ]
      );
    prefer-no-csd = true;
    layout = {
      border = {
        enable = true;
        width = 5;
        active = {
          gradient = {
            from = "#e879f9";
            to = "#7c3aed";
            angle = 45;
            relative-to = "workspace-view";
          };
        };
        inactive = {
          color = "#453a4a";
        };
      };
      focus-ring.enable = false;
      default-column-width = {
        proportion = 1. / 1.;
      };
    };
  };
}
