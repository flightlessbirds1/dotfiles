{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (config.home) username;
  profiles = import ./profiles.nix {
    inherit
      inputs
      pkgs
      lib
      config
      username
      ;
  };
  package = inputs.old-nixpkgs.legacyPackages.${pkgs.system}.floorp;
in {
  imports = [];

  programs.floorp = {
    enable = true;

    inherit
      package
      ;

    # Equivalent to Firefox's native messaging hosts
    nativeMessagingHosts = [
      pkgs.gnome-browser-connector
    ];

    policies = import ./policies.nix {
      inherit
        pkgs
        lib
        config
        inputs
        ;
    };

    inherit
      profiles
      ;
  };
}
