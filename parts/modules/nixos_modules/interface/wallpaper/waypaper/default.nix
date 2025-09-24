{pkgs, ...}: {
  environment.systemPackages = with pkgs; [waypaper];
}
