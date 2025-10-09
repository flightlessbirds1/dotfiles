{pkgs, ...}: {
  environment.systemPackages = with pkgs; [nushell];
  environment.shells = with pkgs; [
    nushell
  ];
}
