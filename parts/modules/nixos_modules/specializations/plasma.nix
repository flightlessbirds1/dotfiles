{
  inputs,
  pkgs,
  lib,
  config,
  username,
  ...
}: {
  options.specializations.plasma = {
    enable = lib.mkEnableOption "Enable Plasma desktop specialization";
  };

  config = lib.mkIf config.specializations.plasma.enable {
    specialisation.plasma = {
      inheritParentConfig = true;

      configuration = {
        services.desktopManager.plasma6.enable = true;
        services.displayManager.sddm.enable = true;
        services.displayManager.sddm.wayland.enable = true;

        dual_modules.modules.gnome.enable = lib.mkForce false;

        environment.systemPackages = with pkgs; [
          kdePackages.dolphin
          kdePackages.konsole
          kdePackages.kate
          kdePackages.okular
          kdePackages.gwenview
          kdePackages.spectacle
          kdePackages.kcalc
          kdePackages.partitionmanager
          kdePackages.filelight
          kdePackages.kdeconnect-kde
          kdePackages.kcolorchooser
          kdePackages.plasma-browser-integration
          # libsForQt5.qt5.qttools
          xcb-util-cursor
          xorg.libxcb
          xorg.xcbutilwm
          xorg.xcbutilimage
          xorg.xcbutilkeysyms
          xorg.xcbutilrenderutil
        ];

        home-manager.sharedModules = [
          inputs.plasma-manager.homeModules.plasma-manager
        ];

        home-manager.users.${username} = {
          programs = {
            eww.enable = lib.mkForce false;
          };

          services = {
            swaync.enable = lib.mkForce false;
            swww.enable = lib.mkForce false;
          };
          programs.plasma = {
            enable = true;

            workspace = {
              clickItemTo = "open";
              lookAndFeel = "org.kde.breezedark.desktop";
              theme = "breeze-dark";
              colorScheme = "BreezeDark";

              cursor = {
                theme = "breeze_cursors";
                size = 24;
              };

              iconTheme = "breeze-dark";

              wallpaper = "/home/${username}/Desktop/dotfiles/deploy/background-image.png";
            };

            fonts = {
              general = {
                family = "JetBrainsMono Nerd Font";
                pointSize = 10;
              };
              fixedWidth = {
                family = "JetBrainsMono Nerd Font Mono";
                pointSize = 10;
              };
              small = {
                family = "JetBrainsMono Nerd Font";
                pointSize = 8;
              };
              toolbar = {
                family = "JetBrainsMono Nerd Font";
                pointSize = 10;
              };
              menu = {
                family = "JetBrainsMono Nerd Font";
                pointSize = 10;
              };
              windowTitle = {
                family = "JetBrainsMono Nerd Font";
                pointSize = 10;
              };
            };

            shortcuts = {
              kwin = {
                "Window Close" = "Meta+K";
                "Window Maximize" = "Meta+F";
                "Window Fullscreen" = "Meta+Shift+F";
                "Window Quick Tile Bottom" = "none";
                "Window Quick Tile Left" = "Meta+Left";
                "Window Quick Tile Right" = "Meta+Right";
                "Window Quick Tile Top" = "none";
                "Switch Window Down" = "Meta+Down";
                "Switch Window Up" = "Meta+Up";
                "Switch Window Left" = "Meta+Left";
                "Switch Window Right" = "Meta+Right";
                "Window Move Down" = "Meta+Shift+Down";
                "Window Move Up" = "Meta+Shift+Up";
                "Window Move Left" = "Meta+Shift+Left";
                "Window Move Right" = "Meta+Shift+Right";
                "Switch to Desktop 1" = "Meta+1";
                "Switch to Desktop 2" = "Meta+2";
                "Switch to Desktop 3" = "Meta+3";
                "Switch to Desktop 4" = "Meta+4";
                "Switch to Desktop 5" = "Meta+5";
                "Switch to Desktop 6" = "Meta+6";
                "Switch to Desktop 7" = "Meta+7";
                "Switch to Desktop 8" = "Meta+8";
                "Window to Desktop 1" = "Meta+Shift+1";
                "Window to Desktop 2" = "Meta+Shift+2";
                "Window to Desktop 3" = "Meta+Shift+3";
                "Window to Desktop 4" = "Meta+Shift+4";
                "Window to Desktop 5" = "Meta+Shift+5";
                "Window to Desktop 6" = "Meta+Shift+6";
                "Window to Desktop 7" = "Meta+Shift+7";
                "Window to Desktop 8" = "Meta+Shift+8";
                "Window to Next Screen" = "Meta+Ctrl+Right";
                "Window to Previous Screen" = "Meta+Ctrl+Left";
              };

              spectacle = {
                "RectangularRegionScreenShot" = "Meta+S";
              };

              krunner = {
                "run command" = "Meta+Space";
              };
            };

            configFile = {
              kwinrc = {
                Windows = {
                  FocusPolicy = "FocusFollowsMouse";
                };
              };
              kglobalshortcutsrc = {
                "com.mitchellh.ghostty.desktop"."_launch" = "Meta+Return,none,Ghostty";
                "firefox.desktop"."_launch" = "Meta+Shift+Ctrl+F,none,Firefox";
                "org.gnome.Nautilus.desktop"."_launch" = "Meta+Shift+Ctrl+I,none,Nautilus";
                "spotify.desktop"."_launch" = "Meta+Shift+Ctrl+S,none,Spotify";
                "org.qbittorrent.qBittorrent.desktop"."_launch" = "Meta+Shift+Ctrl+Q,none,qBittorrent";
                "obsidian.desktop"."_launch" = "Meta+Shift+Ctrl+O,none,Obsidian";
              };
            };

            panels = [
              {
                location = "top";
                height = 32;
                widgets = [
                  {
                    name = "org.kde.plasma.appmenu";
                  }
                  "org.kde.plasma.panelspacer"
                  {
                    systemTray.items = {
                      shown = [
                        "org.kde.plasma.clipboard"
                        "org.kde.plasma.networkmanagement"
                        "org.kde.plasma.volume"
                      ];
                      hidden = [
                        "org.kde.plasma.brightness"
                      ];
                    };
                  }
                  {
                    digitalClock = {
                      calendar.firstDayOfWeek = "sunday";
                      time.format = "24h";
                      date = {
                        enable = true;
                        format = "longDate";
                        position = "besideTime";
                      };
                    };
                  }
                ];
              }
              {
                location = "bottom";
                height = 56;
                hiding = "dodgewindows";
                widgets = [
                  {
                    iconTasks = {
                      launchers = [
                        "applications:org.kde.dolphin.desktop"
                        "applications:firefox.desktop"
                        "applications:org.kde.konsole.desktop"
                      ];
                    };
                  }
                ];
              }
            ];

            krunner = {
              activateWhenTypingOnDesktop = true;
            };

            window-rules = [
              {
                description = "Code editors to workspace 1";
                match = {
                  window-class = {
                    value = "ghostty|code|codium|zed|org.gnome.Nautilus";
                    type = "regex";
                  };
                };
                apply = {
                  desktops = {
                    value = "01-terminal";
                    apply = "initially";
                  };
                  maximizehoriz = {
                    value = true;
                    apply = "initially";
                  };
                  maximizevert = {
                    value = true;
                    apply = "initially";
                  };
                };
              }
              {
                description = "Firefox to workspace 2";
                match = {
                  window-class = {
                    value = "firefox";
                    type = "substring";
                  };
                };
                apply = {
                  desktops = {
                    value = "02-web";
                    apply = "initially";
                  };
                  maximizehoriz = {
                    value = true;
                    apply = "initially";
                  };
                  maximizevert = {
                    value = true;
                    apply = "initially";
                  };
                };
              }
              {
                description = "Spotify to workspace 4";
                match = {
                  window-class = {
                    value = "spotify";
                    type = "substring";
                  };
                };
                apply = {
                  desktops = {
                    value = "04-music";
                    apply = "initially";
                  };
                  maximizehoriz = {
                    value = true;
                    apply = "initially";
                  };
                  maximizevert = {
                    value = true;
                    apply = "initially";
                  };
                };
              }
              {
                description = "Chat apps to workspace 5";
                match = {
                  window-class = {
                    value = "vesktop|discord|signal|equibop";
                    type = "regex";
                  };
                };
                apply = {
                  desktops = {
                    value = "05-chat";
                    apply = "initially";
                  };
                  maximizehoriz = {
                    value = true;
                    apply = "initially";
                  };
                  maximizevert = {
                    value = true;
                    apply = "initially";
                  };
                };
              }
            ];

            kwin = {
              virtualDesktops = {
                rows = 2;
                number = 8;
                names = [
                  "01-terminal"
                  "02-web"
                  "03-code"
                  "04-music"
                  "05-chat"
                  "06-files"
                  "07-gaming"
                  "08-misc"
                ];
              };

              effects = {
                translucency.enable = true;
                blur.enable = true;
                desktopSwitching.animation = "slide";
                dimInactive.enable = true;
              };

              titlebarButtons = {
                left = ["close"];
                right = ["minimize" "maximize"];
              };

              borderlessMaximizedWindows = false;
            };

            powerdevil = {
              AC = {
                autoSuspend.action = "nothing";
                turnOffDisplay.idleTimeout = 900;
                dimDisplay = {
                  enable = true;
                  idleTimeout = 600;
                };
              };
            };

            kscreenlocker = {
              autoLock = true;
              timeout = 10;
            };
          };
        };
      };
    };
  };
}
