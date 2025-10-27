{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      parsec-bin
      ;
  };
}
