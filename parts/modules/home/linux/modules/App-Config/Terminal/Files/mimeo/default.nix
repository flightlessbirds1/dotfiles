{pkgs, ...}: {
  home.packages = with pkgs; [
    mimeo
  ];
}
