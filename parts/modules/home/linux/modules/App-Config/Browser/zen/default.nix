{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (config.home) username;
  firefoxProfiles = import ../firefox/profiles.nix {
    inherit inputs pkgs lib config username;
  };
  zenProfiles =
    lib.mapAttrs (
      name: profile:
        builtins.removeAttrs profile ["userChrome"]
    )
    firefoxProfiles;
in {
  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [pkgs.ff2mpv-rust];
    policies = import ../firefox/policies.nix {inherit pkgs lib config inputs;};
    profiles = zenProfiles;
  };
}
