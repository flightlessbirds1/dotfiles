{
  lib,
  config,
  ...
}: let
  username = config.home.username;
in {
  home = {
    file.".local/share/backgrounds/.background-image".source =
      ../../../../../../deploy/.background-image;
    file.".local/share/backgrounds/.switcher-background-image".source =
      ../../../../../../deploy/.switcher-background-image;
    file.".local/share/themes/custom/gnome-shell/gnome-shell.css" = {
      source = ../../../../../../deploy/gnome-shell.css;
      onChange = ''
        sed -i "s/USERNAME/${username}/" "/home/${username}/.local/share/themes/custom/gnome-shell/gnome-shell.css"
      '';
    };
  };
  dconf = {
    enable = true;

    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        scaling-factor = 0;
        clock-show-weekday = true;
        clock-format = "12h";
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        experimental-features = [
          "scale-monitor-framebuffer"
        ];
      };

      # This picture comes from deploy/.background-image
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "/home/${username}/.local/share/backgrounds/.background-image";
        picture-uri-dark = "/home/${username}/.local/share/backgrounds/.background-image";
        primary-color = "000000000000";
        secondary-color = "#000000000000";
      };

      "org/gnome/desktop/screensaver" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "/home/${username}/.local/share/backgrounds/.background-image";
        primary-color = "#000000000000";
        secondary-color = "#000000000000";
      };

      # Enable Gnome extensions
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [];
        enabled-extensions = [
          "compiz-windows-effect@hermes83.github.com"
          "logomenu@aryan_k"
          "tiling-assistant@leleat-on-github"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "appindicatorsupport@rgcjonas.gmail.com"
          "clipboard-history@alexsaveau.dev"
        ];

        last-selected-power-profile = "performance";

        idle-delay = lib.gvariant.mkUint32 0; # makes the screen never idle

        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "firefox.desktop"
          "vesktop.desktop"
          "spotify.desktop"
          "steam.desktop"
          "plex-desktop.desktop"
          "com.mitchellh.ghostty.desktop"
          "gnome-system-monitor.desktop"
        ]; # change the apps in the favorite bar
      };

      # Compiz window effect
      "org/gnome/shell/extensions/com/github/hermes83/compiz-windows-effect" = {
        friction = 2.0;
        mass = 20.0;
        maximize-effect = false;
        speedup-factor-divider = 2.0;
        spring-k = 1.0;
        x-tiles = 10.0;
        y-tiles = 10.0;
      };

      # Clip-hist
      "org/gnome/shell/extensions/clipboard-history" = {
        history-size = 50;
      };

      # Mouse scroll direction
      "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = false; # changes scroll direction
      };

      "org/gnome/shell/extensions/Logo-menu" = {
        menu-button-icon-image = 23;
      };

      # This theme comes from deploy/gnome-shell.css
      "org/gnome/shell/extensions/user-theme" = {
        name = "custom";
      };

      "org/gnome/shell/extensions/appindicator" = {
        icon-brightness = -0.4;
        icon-contrast = 0.8;
        icon-opacity = 255;
        icon-saturation = 1;
        icon-size = 21;
        legacy-tray-enabled = true;
        tray-pos = "right";
      };
      "org/gnome/desktop/notifications" = {
        show-banners = false; # turns DND on
      };
      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing"; # makes the screen not sleep
      };
    };
  };

  xsession.enable = true;
}
