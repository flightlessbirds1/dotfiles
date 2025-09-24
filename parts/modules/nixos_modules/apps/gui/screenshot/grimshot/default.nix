{pkgs, ...}: {
  environment.systemPackages = with pkgs; [sway-contrib.grimshot];
}
