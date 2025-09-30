{pkgs, ...}: {
  home.packages = with pkgs; [
    btop
    proxychains-ng
  ];
}
