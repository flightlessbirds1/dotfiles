{
  pkgs,
  hostname,
  username,
  stateVersion,
  flake,
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
      ];
      unportable_content = with flake.self.nixosModules; [
        sops
        wireguard
      ];
      backup_content = [
      ];
    };

  nix = {
    package = pkgs.nixVersions.stable;
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
