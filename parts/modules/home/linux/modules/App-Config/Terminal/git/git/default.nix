{pkgs, ...}: {
  home.packages = with pkgs; [
    git
    git-credential-manager
  ];
}
