{
  config,
  hostname,
  stateVersion,
  pkgs,
  username,
  flake,
  ...
}: {
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
      isNormalUser =
        true;
      extraGroups = [
        "networkManager"
        "wheel"
        "plugdev"
        "lp"
        "lpadmin"
        "input"
      ];
      shell =
        pkgs.fish;
    };
    unportable_content = {
      hashedPasswordFile =
        config.sops.secrets.password.path;
    };
    backup_content = {
      initialPassword = "nixos";
    };
  };
  home-manager.users.${username} = {pkgs, ...}: {
    imports = with flake.self.homeManagerModules; [
      Communication
      Desktop-Environments
      Editors
      Gaming
      Media
      Terminal
      wayland
      System-Config
      ../../home/linux/modules/App-Config/browser/split-conf
    ];
    home = {
      inherit
        username
        stateVersion
        ;
      homeDirectory = "/home/${username}";
      packages = with pkgs; [
      ];
    };
  };
  services = {
    flatpak = {
      enable =
        true;
    };
  };

  dual_modules.users."${username}".use = [
    "fcitx5"
    "gnome"
  ];
}
