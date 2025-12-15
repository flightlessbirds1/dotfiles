{
  inputs,
  pkgs,
  lib,
  config,
  flake,
  ...
}:
let
  username = config.home.username;
in
{
  imports = with flake.self.homeManagerModules; [ session ];

  home = {
    file.".local/share/backgrounds/.background-image" = {
      source = "${flake.self.deploy}/.background-image";
      force = true;
    };

    file.".local/share/backgrounds/.switcher-background-image" = {
      source = "${flake.self.deploy}/.switcher-background-image";
      force = true;
    };

    file.".local/share/themes/custom/gnome-shell/gnome-shell.css" = {
      source = "${flake.self.deploy}/gnome-shell.css";
      force = true;
      onChange = ''
        sed -i "s/USERNAME/${username}/" "/home/${username}/.local/share/themes/custom/gnome-shell/gnome-shell.css"
      '';
    };
  };
  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        scaling-factor = 0;
        font-name = "Adwaita Sans 11";
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = true;
      };

      # This picture comes from deploy/.background-image
      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "/home/${username}/.local/share/backgrounds/.background-image";
        picture-uri-dark = "/home/${username}/.local/share/backgrounds/.background-image";
        primary-color = "#000000000000";
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
        disabled-extensions = [ ];
        enabled-extensions = [
          "compiz-windows-effect@hermes83.github.com"
          "logomenu@aryan_k"
          "tiling-assistant@leleat-on-github"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
        last-selected-power-profile = "power-saver";
        favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "org.gnome.Calendar.desktop"
          "mullvad-vpn.desktop"
          "firefox.desktop"
          "obsidian.desktop"
          "zotero.desktop"
          "codium.desktop"
          "Alacritty.desktop"
          "com.mitchellh.ghostty.desktop"
          "signal-desktop.desktop"
          "gnome-system-monitor.desktop"
          "com.obsproject.Studio.desktop"
        ];
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

      # Mouse scroll direction
      "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = true;
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

      "org/gnome/desktop/wm/keybindings" = {
        begin-move = [ "<Control>Right" ];
        switch-to-workspace-left = [ "<Ctrl>s" ];
        switch-to-workspace-right = [ "<Ctrl>g" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        search = [ "<Control>space" ];
      };

      "org/gnome/desktop/input-sources" = {
        xkb-options = [ "compose:sclk" ];
      };
    };
  };
}
