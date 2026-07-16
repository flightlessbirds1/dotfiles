{ inputs, ... }:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;
    niri = {
      enableSpawn = true;
      includes.enable = false;
    };
    enableDynamicTheming = true;
    settings = {
      currentThemeName = "dynamic";
      currentThemeCategory = "dynamic";
      matugenScheme = "scheme-fruit-salad";
      use24HourClock = false;
      showSeconds = true;
      useFahrenheit = true;
      animationSpeed = 2;
      popoutAnimationSpeed = 2;
      modalAnimationSpeed = 2;
      showWorkspaceIndex = false;
      useAutoLocation = false;
      muxType = "zellij";
      showDock = false;
      powerMenuGridLayout = true;
      niriOutputSettings = {
        DP-1 = {
          vrrOnDemand = true;
        };
        DP-2 = {
          vrrOnDemand = true;
        };
      };
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [
            "all"
          ];
          showOnLastDisplay = true;
          leftWidgets = [
            {
              id = "workspaceSwitcher";
              enabled = true;
            }
            {
              id = "network_speed_monitor";
              enabled = true;
            }
          ];
          centerWidgets = [
            {
              id = "clock";
              enabled = true;
              clockCompactMode = false;
            }
          ];
          rightWidgets = [
            {
              id = "colorPicker";
              enabled = true;
            }
            {
              id = "idleInhibitor";
              enabled = true;
            }
            {
              id = "notificationButton";
              enabled = true;
            }
            {
              id = "weather";
              enabled = true;
            }
            {
              id = "controlCenterButton";
              enabled = true;
            }
          ];
        }
      ];
    };
  };
}
