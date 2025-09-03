{
  pkgs,
  ...
}:
{
  home.packages = builtins.attrValues {
    inherit (pkgs.kdePackages)
      plasma-nm
      ;
  };
}
