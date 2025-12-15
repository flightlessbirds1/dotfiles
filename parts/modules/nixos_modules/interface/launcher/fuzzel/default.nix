{ pkgs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      fuzzel
      papirus-icon-theme
      ;
  };
}
