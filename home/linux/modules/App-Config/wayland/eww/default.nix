{
  hostname,
  username,
  flake,
  lib,
  pkgs,
  ...
}:
let
  inherit (flake.self.packages.${pkgs.system}) haskeww;
  makeEWWService = bin: envFile: {
    Unit = {
      Description = "Eww feeder: ${bin}";
      After = [
        "graphical-session.target"
        "eww.service"
      ];
      Wants = [ "eww.service" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = lib.mkMerge [
      {
        ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 2 && exec ${lib.getBin haskeww}/bin/${bin}'";
        Restart = "always";
        RestartSec = 5;
      }
      (lib.optionalAttrs (envFile != null) { EnvironmentFile = envFile; })
    ];

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
in
{
  programs.eww = {
    configDir = if hostname == "desktop" then ./desktop else ./laptop;
    enable = true;
  };

  home.packages = [
    haskeww
    pkgs.rocmPackages.rocm-smi
  ];

  systemd.user.services = {
    eww = {
      Unit = {
        Description = "Eww daemon";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.bash}/bin/bash -c '${lib.getExe pkgs.eww} ping || exec ${lib.getExe pkgs.eww} daemon'";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    eww-manage-cryptos = makeEWWService "manageCryptos" null;
    eww-manage-gpu = makeEWWService "manageGPU" null;
    eww-manage-network = makeEWWService "manageNetwork" null;
    eww-manage-time = makeEWWService "manageTime" null;
    eww-manage-weather = makeEWWService "manageWeather" "/etc/environment.d/50-weather-secrets.conf";
    eww-manage-workspaces = makeEWWService "manageWorkspaces" null;
  }
  // (
    if hostname == "laptop" then
      {
        eww-manage-battery = makeEWWService "manageBattery" null;
        eww-battery-time = makeEWWService "batteryTime" null;
      }
    else
      { }
  );
}
