{pkgs, ...}: {
  home.packages = with pkgs; [
    ff2mpv-rust
  ];
}
