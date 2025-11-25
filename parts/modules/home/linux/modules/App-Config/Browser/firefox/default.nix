{
  inputs,
  pkgs,
  pkgs-stable,
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
    package =
      if browser == "firefox"
      then pkgs.${package}
      else pkgs-stable.${package};
    nativeMessagingHosts = [pkgs.ff2mpv-rust];

    policies = import ./policies.nix {inherit pkgs lib config inputs;};
    inherit profiles;
  };
}
