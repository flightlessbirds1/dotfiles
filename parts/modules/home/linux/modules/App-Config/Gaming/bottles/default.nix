{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      bottles
      ;
  };
}
