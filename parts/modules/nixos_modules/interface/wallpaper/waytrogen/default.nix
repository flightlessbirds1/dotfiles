{pkgs, ...}: {
  environment.systemPackages = with pkgs; [waytrogen];
}
