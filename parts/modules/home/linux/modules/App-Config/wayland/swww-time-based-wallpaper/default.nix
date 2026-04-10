{
  pkgs,
  lib,
  flake,
  ...
}:
{
  home.file."scripts/wallpaper-switcher.nu" = {
    source = ../../../System-Config/Scripts/wallpaper-switcher.nu;
    executable = true;
  };

  systemd.user.services.awww-daemon = {
    Unit = {
      Description = "awww wallpaper daemon";
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
      ExecStartPre = "-/bin/sh -c 'rm -f /run/user/$UID/awww*.sock'";
      ExecStart = "${pkgs.awww}/bin/awww-daemon --format xrgb";
      Restart = "on-failure";
      RestartSec = "3s";
      MemoryMax = "256M";
      CPUQuota = "75%";
      Nice = 10;
      Environment = [
        "WAYLAND_DISPLAY=wayland-1"
        "XDG_RUNTIME_DIR=/run/user/1000"
        "awwW_TRANSITION_ANGLE=0"
        "awwW_TRANSITION_DURATION=0"
      ];
    };
    Install.WantedBy = [
      "graphical-session.target"
    ];
  };

  systemd.user.services.wallpaper-switcher = {
    Unit = {
      Description = "Time-based wallpaper switcher";
      After = [
        "awww-daemon.service"
      ];
      Wants = [
        "awww-daemon.service"
      ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash %h/scripts/wallpaper-switcher";
      Environment = [
        "PATH=${pkgs.awww}/bin:${pkgs.coreutils}/bin:/run/current-system/sw/bin"
      ];
      PassEnvironment = [
        "WAYLAND_DISPLAY"
        "XDG_RUNTIME_DIR"
      ];
    };
  };

  systemd.user.timers.wallpaper-switcher = {
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

  systemd.user.services.wallpaper-startup = {
    Unit = {
      Description = "Set initial wallpaper on login";
      After = [
        "graphical-session.target"
        "awww-daemon.service"
      ];
      Wants = [
        "awww-daemon.service"
      ];
      # Don't block login
      DefaultDependencies = false;
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 1 && exec ${pkgs.bash}/bin/bash %h/scripts/wallpaper-switcher'";
      Environment = [
        "PATH=${pkgs.awww}/bin:${pkgs.coreutils}/bin:/run/current-system/sw/bin"
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
