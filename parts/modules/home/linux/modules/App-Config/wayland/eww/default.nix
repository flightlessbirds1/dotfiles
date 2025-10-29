{
  hostname,
  username,
  flake,
  lib,
  pkgs,
  users,
  osConfig,
  ...
}: let
  inherit
    (flake.self.packages.${pkgs.system})
    haskeww
    ;
  inherit
    (builtins)
    filter
    listToAttrs
    map
    ;
  configSource =
    if hostname == "desktop"
    then "desktop"
    else "laptop";
  configPath = "${osConfig.users.users.${username}.home}/.config/eww";

  processYuckFile = file:
    builtins.replaceStrings
    ["pathto"]
    [configPath]
    (builtins.readFile file);

  scan = lib.filesystem.listFilesRecursive ./${configSource};

  fileFilter = suffix: (filter (file: lib.hasSuffix "${suffix}" (toString file)) scan);

  yuckFiles = fileFilter ".yuck";

  # scssFiles = ./${configSource}/scss;

  imageFiles = (fileFilter ".svg") ++ (fileFilter ".png");

  allFiles = yuckFiles ++ imageFiles;

  xdgConfig = listToAttrs (map (
      name:
        if lib.hasSuffix ".yuck" (toString name)
        then {
          name = builtins.replaceStrings [("eww/" + configSource)] ["eww"] (builtins.toString (builtins.tail (lib.splitString "wayland/" (toString name))));
          value.text = processYuckFile name;
        }
        else {
          name = builtins.replaceStrings [("eww/" + configSource)] ["eww"] (builtins.toString (builtins.tail (lib.splitString "wayland/" (toString name))));
          value.source = name;
        }
    )
    allFiles);

  makeEWWService = bin: envFile: {
    Unit = {
      Description = "Eww feeder: ${bin}";
      After = [
        "graphical-session.target"
        "eww.service"
      ];
      Wants = [
        "eww.service"
      ];
      PartOf = [
        "graphical-session.target"
      ];
    };

    Service = lib.mkMerge [
      {
        ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 2 && exec ${lib.getBin haskeww}/bin/${bin}'";
        Restart = "always";
        RestartSec = 5;
      }
      (lib.optionalAttrs (envFile != null) {
        EnvironmentFile = envFile;
      })
    ];

    Install = {
      WantedBy = [
        "graphical-session.target"
      ];
    };
  };
in
  lib.mkIf (flake.config.environment == "mine") {
    programs.eww = {
      enable = true;
      package = pkgs.eww;
    };

    xdg.configFile =
      xdgConfig
      // {
        "eww/scss".source = ./${configSource}/scss;
        "eww/eww.scss".source = ./${configSource}/eww.scss;
      };

    home.packages = [
      haskeww
      pkgs.rocmPackages.rocm-smi
    ];

    systemd.user.services =
      {
        eww = {
          Unit = {
            Description = "Eww daemon";
            After = [
              "graphical-session.target"
            ];
            PartOf = [
              "graphical-session.target"
            ];
          };
          Service = flake.self.dependent-checker.function {
            inherit username hostname;
            concatenation_type = "attribute";
            portable_content = {
              Type = "oneshot";
              RemainAfterExit = true;
              ExecStart = "${pkgs.bash}/bin/bash -c '${lib.getExe pkgs.eww} ping || exec ${lib.getExe pkgs.eww} daemon'";
            };

            desktop_content = {
              ExecStartPost = "${pkgs.bash}/bin/bash -c 'sleep 1; eww open monitorBar1; eww open monitorBar2'";
            };
            laptop_content = {
              ExecStartPost = "${pkgs.bash}/bin/bash -c 'sleep 1; eww open monitorBar'";
            };
            backup_content = {
            };
          };
          Install = {
            WantedBy = [
              "graphical-session.target"
            ];
          };
        };

        eww-manage-gpu = makeEWWService "manageGPU" null;
        eww-manage-network = makeEWWService "manageNetwork" null;
        eww-manage-time = makeEWWService "manageTime" null;
        eww-manage-weather = makeEWWService "manageWeather" "/etc/environment.d/50-weather-secrets.conf";
        eww-manage-workspaces = makeEWWService "manageWorkspaces" null;
      }
      // (
        if hostname == "laptop"
        then {
          eww-manage-battery = makeEWWService "manageBattery" null;
          eww-battery-time = makeEWWService "batteryTime" null;
        }
        else {}
      );
  }
