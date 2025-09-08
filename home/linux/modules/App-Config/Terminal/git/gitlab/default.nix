{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
in {
  home.packages = [pkgs.glab];

  programs.ssh = {
    matchBlocks = {
      "gitlab.com" = {
        hostname = "gitlab.com";
        identityFile = "${config.home.homeDirectory}/.ssh/gitlab_id_ed25519";
      };
    };
  };
}
