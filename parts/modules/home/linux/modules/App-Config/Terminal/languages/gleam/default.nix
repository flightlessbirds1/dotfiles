{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      gleam
      exercism
      ;
  };
}
