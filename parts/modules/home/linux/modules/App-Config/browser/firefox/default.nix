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

  package = pkgs.firefox;
in {
  imports = [];

  programs.firefox = {
    enable = true;

    inherit
      package
      ;

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
