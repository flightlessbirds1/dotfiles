{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      plex-desktop
      ;
  };
}
