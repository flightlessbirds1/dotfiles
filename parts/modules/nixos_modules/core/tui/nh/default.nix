{
  lib,
  pkgs,
  config,
  username,
  ...
}: {
  programs.nh = {
    enable = true;
    flake = "${config.users.users.${username}.home}/Desktop/dotfiles";
  };
}
