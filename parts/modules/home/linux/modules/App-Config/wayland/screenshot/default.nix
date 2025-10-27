{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      grim
      slurp
      wl-clipboard-rs
      ;
  };
  services.cliphist.enable = true;
}
