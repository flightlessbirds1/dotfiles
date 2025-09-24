{pkgs, ...}: {
  environment.systemPackages = with pkgs; [slurp];
}
