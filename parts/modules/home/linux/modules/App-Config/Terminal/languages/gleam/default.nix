{pkgs, ...}: {
  home.packages = with pkgs; [
    gleam
    exercism
  ];
}
