{pkgs, ...}: {
  programs.corectrl.enable = true;
  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      lm_sensors
      ;
  };
}
