{
  config,
  hostname,
  stateVersion,
  pkgs,
  username,
  flake,
  ...
}:
{
  imports = [
    ../../home/linux/default.nix
  ];
  users.users.${username} = flake.self.checker.function {
    inherit
      username
      hostname
      ;
    concatenation_type = "attribute";
    portable_content = {
      home = "/home/${username}";
      isNormalUser = true;
      extraGroups = [
        "networkManager"
        "wheel"
        "plugdev"
        "lp"
        "lpadmin"
        "input"
      ];
      shell = pkgs.nushell;
    };
    unportable_content = {
      hashedPasswordFile = config.sops.secrets.password.path;
    };
    backup_content = {
      initialPassword = "nixos";
    };
  };
  home-manager.users.${username} =
    {
      inputs,
      ...
    }:
    {
      imports = with flake.self.homeManagerModules; [
        Communication
        Desktop
        Editors
        Gaming
        Media
        Security
        Terminal
        wayland
        System-Config
        inputs.zen-browser.homeModules.beta
        ../../home/linux/modules/App-Config/Browser/split-conf
      ];
      home = {
        inherit
          username
          stateVersion
          ;
        homeDirectory = "/home/${username}";
        packages = builtins.attrValues {
          inherit (pkgs)
            bluez
            ;
        };
      };
    };
  services = {
    flatpak = {
      enable = true;
    };
  };
  qt.enable = true;
  # qt.platformTheme = "gnome";
  qt.style = "adwaita-dark";
  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];

    config.gnome = {
      default = [ "gnome" ];
    };
    xdgOpenUsePortal = true;
    config.niri = {
      default = [
        "gtk"
        "gnome"
      ];
      "org.freedesktop.impl.portal.FileChooser" = "kde";
      # "org.freedesktop.impl.portal.OpenURI" = "gnome";
    };
    config.common.default = [ "gnome" ];
  };

  dual_modules.users."${username}".use = [
    "fcitx5"
    # "gnome"
    # "mullvad"
  ];
}
