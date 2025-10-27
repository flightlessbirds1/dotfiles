{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs.nodePackages_latest)
      prettier
      ;
  };
}
