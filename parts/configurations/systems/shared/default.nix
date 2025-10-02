{
  pkgs,
  hostname,
  username,
  stateVersion,
  flake,
  lib,
  ...
}: {
  imports =
    flake.self.checker.function
    {
      inherit hostname username;
      concatenation_type = "list";
      portable_content = with flake.self.nixosModules; [
        core
        apps
        interface
        other
        android
        ddcutil
        printing
        shell
        sound
        udev
        wallet
        dual
      ];
      unportable_content = with flake.self.nixosModules; [
        sops
        DC
      ];
      backup_content = [
      ];
    };

  dual_modules.modules = {
    fcitx5.enable = lib.mkDefault true;
    gnome.enable = lib.mkDefault true;
  };

  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    settings.allowed-users = [
      "@wheel"
    ];
  };

  system = {
    inherit
      stateVersion
      ;
  };

  nixpkgs.config.allowUnfree = true;

  networking.hostName = hostname;

  users.mutableUsers = false;

  users.users.root = {
    hashedPassword = "*";
  };

  environment.systemPackages = with pkgs; [
    libinput
  ];
  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
}
