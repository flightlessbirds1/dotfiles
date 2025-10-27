{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      btop
      proxychains-ng
      ;
  };
}
