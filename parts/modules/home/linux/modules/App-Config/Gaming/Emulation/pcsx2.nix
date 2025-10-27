{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      pcsx2
      ;
  };
}
