{
  pkgs,
  inputs,
  flake,
  lib,
  osConfig,
  username,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = lib.mkIf (flake.config.environment == "noctalia") {
    enable = true;
    settings = {
      settingsVersion = 12;
      bar = {
        position = "top";
        backgroundOpacity = 1;
        monitors = [ ];
        density = "comfortable";
        showCapsule = false;
        floating = false;
        widgets = {
          left = [
            {
              id = "SystemMonitor";
              "showCpuTemp" = true;
              "showCpuUsage" = true;
              "showDiskUsage" = false;
              "showMemoryAsPercent" = false;
              "showMemoryUsage" = true;
              "showNetworkStats" = false;
            }
            {
              id = "WiFi";
            }
            {
              id = "Bluetooth";
            }
          ];
          center = [
            {
              id = "Workspace";
              "formatHorizontal" = "h:mm:ss AP dddd, MMM dd";
              "hideUnoccupied" = true;
            }
            {
              id = "Clock";
              "formatHorizontal" = "h:mm:ss AP dddd, MMM dd";
            }
            {
              id = "MediaMini";
            }
          ];
          right = [
            {
              id = "NotificationHistory";
            }
            {
              id = "Volume";
            }
            {
              id = "WallpaperSelector";
            }
            (
              if osConfig.networking.hostName == "laptop" then
                {
                  id = "Battery";
                }
              else
                { }
            )
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };
      general = {
        avatarImage = "";
        dimDesktop = true;
        showScreenCorners = false;
        forceBlackScreenCorners = false;
        radiusRatio = 1;
        screenRadiusRatio = 1;
        animationSpeed = 1;
        animationDisabled = false;
      };
      location = {
        name = "dummy";
        useFahrenheit = true;
        use12hourFormat = true;
        showWeekNumberInCalendar = false;
      };
      screenRecorder = {
        directory = "";
        frameRate = 60;
        audioCodec = "opus";
        videoCodec = "h264";
        quality = "very_high";
        colorRange = "limited";
        showCursor = true;
        audioSource = "default_output";
        videoSource = "portal";
      };
      wallpaper = {
        enabled = true;
        "directory" = "${osConfig.users.users.${username}.home}/Desktop/dotfiles/deploy";
        enableMultiMonitorDirectories = false;
        setWallpaperOnAllMonitors = true;
        fillMode = "crop";
        fillColor = "#000000";
        randomEnabled = false;
        transitionDuration = 1500;
        transitionType = "random";
        transitionEdgeSmoothness = 0.05;
        monitors = (
          if osConfig.networking.hostName == "laptop" then
            [
              {
                "directory" = "${osConfig.users.users.${username}.home}/Desktop/dotfiles/deploy";
                "name" = "eDP-1";
                "wallpaper" = "${
                  osConfig.users.users.${username}.home
                }/Desktop/dotfiles/deploy/background-image.png";
              }
            ]
          else
            [
              {
                "directory" = "${osConfig.users.users.${username}.home}/Desktop/dotfiles/deploy";
                "name" = "DP-1";
                "wallpaper" = "${
                  osConfig.users.users.${username}.home
                }/Desktop/dotfiles/deploy/background-image.png";
              }
              {
                "directory" = "${osConfig.users.users.${username}.home}/Desktop/dotfiles/deploy";
                "name" = "DP-2";
                "wallpaper" = "${
                  osConfig.users.users.${username}.home
                }/Desktop/dotfiles/deploy/background-image.png";
              }
            ]
        );
      };
      appLauncher = {
        enableClipboardHistory = true;
        position = "center";
        backgroundOpacity = 1;
        pinnedExecs = [ ];
        useApp2Unit = false;
        sortByMostUsed = true;
      };
      dock = {
        autoHide = false;
        exclusive = false;
        backgroundOpacity = 1;
        floatingRatio = 1;
        monitors = [ ];
        pinnedApps = [ ];
      };
      network = {
        wifiEnabled = true;
      };
      notifications = {
        doNotDisturb = false;
        monitors = [ ];
        location = "bottom_right";
        alwaysOnTop = false;
        lastSeenTs = 0;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
      };
      osd = {
        enabled = true;
        location = "top_right";
        monitors = [ ];
        autoHideMs = 2000;
      };
      audio = {
        volumeStep = 5;
        volumeOverdrive = false;
        cavaFrameRate = 60;
        visualizerType = "linear";
        mprisBlacklist = [ ];
        preferredPlayer = "";
      };
      ui = {
        fontDefault = "JetBrainsMono Nerd Font";
        fontFixed = "JetBrainsMono Nerd Font";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        monitorsScaling = (
          if osConfig.networking.hostName == "desktop" then
            [
              {
                "name" = "DP-1";
                "scale" = 1.2;
              }
              {
                "name" = "DP-2";
                "scale" = 1.2;
              }
            ]
          else
            [
              {
                "name" = "eDP-1";
                "scale" = 1.2;
              }
            ]
        );
        idleInhibitorEnabled = false;
      };
      brightness = {
        brightnessStep = 5;
      };
      colorSchemes = {
        useWallpaperColors = false;
        predefinedScheme = "Catppuccin";
        darkMode = true;
        matugenSchemeType = "scheme-fruit-salad";
      };
      matugen = {
        gtk4 = false;
        gtk3 = false;
        qt6 = false;
        qt5 = false;
        kitty = false;
        ghostty = false;
        foot = false;
        fuzzel = false;
        vesktop = false;
        pywalfox = false;
        enableUserTemplates = false;
      };
      nightLight = {
        enabled = false;
        forced = false;
        autoSchedule = true;
        nightTemp = "4000";
        dayTemp = "6500";
        manualSunrise = "06:30";
        manualSunset = "18:30";
      };
      hooks = {
        enabled = false;
        wallpaperChange = "";
        darkModeChange = "";
      };
    };
  };
  home.activation.noctaliaSetLocation = lib.hm.dag.entryAfter [ "writeBoundary" "linkGeneration" ] ''
    set -eu

    $DRY_RUN_CMD echo "Setting noctalia location..."

    files=(
      "$HOME/.config/noctalia/settings.json"
      "$HOME/.config/noctalia/gui-settings.json"
    )

    if [ ! -f "${osConfig.sops.secrets.location.path}" ]; then
      echo "Warning: Location secret file not found"
      exit 0
    fi

    loc="$(${pkgs.coreutils}/bin/cat ${osConfig.sops.secrets.location.path} | ${pkgs.coreutils}/bin/tr -d '\n')"

    if [ -z "$loc" ]; then
      echo "Warning: Location value is empty"
      exit 0
    fi

    for f in "''${files[@]}"; do
      if [ -f "$f" ]; then
        tmp="$(${pkgs.coreutils}/bin/mktemp)"
        $DRY_RUN_CMD ${pkgs.jq}/bin/jq --arg v "$loc" '
          .location.name = $v
        ' "$f" > "$tmp"

        $DRY_RUN_CMD ${pkgs.coreutils}/bin/mv "$tmp" "$f"
        $DRY_RUN_CMD ${pkgs.coreutils}/bin/chmod 0600 "$f"
      fi
    done

    $DRY_RUN_CMD echo "Noctalia location set to: $loc"
  '';
}
