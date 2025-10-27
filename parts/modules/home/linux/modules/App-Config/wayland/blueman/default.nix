{
  pkgs,
  lib,
  flake,
  ...
}:
lib.mkIf (flake.config.environment == "mine")
{
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      blueman
      ;
  };
}
