{pkgs, ...}: {
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard-rs
  ];
  services.cliphist.enable = true;
}
