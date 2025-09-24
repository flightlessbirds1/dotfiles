{pkgs, ...}: {
  programs.corectrl.enable = true;
  environment.systemPackages = with pkgs; [lm_sensors];
}
