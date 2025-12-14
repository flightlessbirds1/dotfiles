{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      xwayland-satellite
      ;
  };
}
