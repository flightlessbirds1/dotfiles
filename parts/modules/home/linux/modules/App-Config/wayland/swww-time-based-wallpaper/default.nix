{
  pkgs,
  lib,
  flake,
  ...
}:
lib.mkIf (flake.config.environment == "mine") {
  home.file."scripts/wallpaper-switcher" = {
    source = ../../../System-Config/Scripts/wallpaper-switcher;
    executable = true;
  };

  systemd.user.services.swww-daemon = lib.mkIf (flake.config.environment == "mine") {
    Unit = {
      Description = "swww wallpaper daemon";
      PartOf = [
        "graphical-session.target"
      ];
      After = [
        "graphical-session.target"
      ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = {
      Type = "simple";
      ExecStartPre = "-/bin/sh -c 'rm -f /run/user/$UID/swww*.sock'";
      ExecStart = "${pkgs.swww}/bin/swww-daemon --format xrgb";
      Restart = "on-failure";
      RestartSec = "3s";
      MemoryMax = "256M";
      CPUQuota = "75%";
      Nice = 10;
      Environment = [
        "WAYLAND_DISPLAY=wayland-1"
        "XDG_RUNTIME_DIR=/run/user/1000"
        "SWWW_TRANSITION_ANGLE=0"
        "SWWW_TRANSITION_DURATION=0"
      ];
    };
    Install.WantedBy = [
      "graphical-session.target"
    ];
  };

  systemd.user.services.wallpaper-switcher =
    lib.mkIf (flake.config.environment == "mine")
    {
      Unit = {
        Description = "Time-based wallpaper switcher";
        After = [
          "swww-daemon.service"
        ];
        Wants = [
          "swww-daemon.service"
        ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash %h/scripts/wallpaper-switcher";
        Environment = [
          "PATH=${pkgs.swww}/bin:${pkgs.coreutils}/bin:/run/current-system/sw/bin"
        ];
        PassEnvironment = [
          "WAYLAND_DISPLAY"
          "XDG_RUNTIME_DIR"
        ];
      };
    };

  systemd.user.timers.wallpaper-switcher = lib.mkIf (flake.config.environment == "mine") {
    Unit.Description = "Run wallpaper switcher at the start of every hour";
    Timer = {
      OnCalendar = "hourly";
      Persistent = true;
      AccuracySec = "1min";
    };
    Install.WantedBy = [
      "timers.target"
    ];
  };

  systemd.user.services.wallpaper-startup = lib.mkIf (flake.config.environment == "mine") {
    Unit = {
      Description = "Set initial wallpaper on login";
      After = [
        "graphical-session.target"
        "swww-daemon.service"
      ];
      Wants = [
        "swww-daemon.service"
      ];
      # Don't block login
      DefaultDependencies = false;
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 1 && exec ${pkgs.bash}/bin/bash %h/scripts/wallpaper-switcher'";
      Environment = [
        "PATH=${pkgs.swww}/bin:${pkgs.coreutils}/bin:/run/current-system/sw/bin"
      ];
      PassEnvironment = [
        "WAYLAND_DISPLAY"
        "XDG_RUNTIME_DIR"
      ];
      Nice = 15;
      IOSchedulingClass = "idle";
    };
    Install.WantedBy = [
      "graphical-session.target"
    ];
  };
}
