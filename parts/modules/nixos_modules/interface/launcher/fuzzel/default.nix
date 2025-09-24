{pkgs, ...}: {
  environment.systemPackages = with pkgs; [fuzzel papirus-icon-theme];
}
