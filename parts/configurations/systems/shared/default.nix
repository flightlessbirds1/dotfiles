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
}
