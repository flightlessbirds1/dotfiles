{
  inputs,
  pkgs,
  lib,
  config,
  browser,
  package ? browser,
  ...
}: let
  inherit (config.home) username;
  profiles = import ./profiles.nix {
    inherit inputs pkgs lib config username;
  };
in {
  programs.${browser} = {
    enable = true;
    package = pkgs.${package};
    nativeMessagingHosts = [pkgs.gnome-browser-connector];
    policies = import ./policies.nix {inherit pkgs lib config inputs;};
    inherit profiles;
  };
}
