{pkgs, ...}: {
  environment.systemPackages = with pkgs; [nushell];
  users.defaultUserShell = pkgs.nushell;
  environment.shells = with pkgs; [
    nushell
  ];
}
