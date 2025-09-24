{pkgs, ...}: {
  environment.systemPackages = with pkgs; [stylish-haskell];
}
