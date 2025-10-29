{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      grim
      slurp
      wl-clipboard-rs
      wayfreeze
      ;
  };
  services.cliphist.enable = true;
}
