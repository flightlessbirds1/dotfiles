# Borrowed is code which is either inspired or taken from https://github.com/Myxogastria0808/nix-flakes-nixvim

{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  home.packages = [
    pkgs.ripgrep
    pkgs.fd
  ];

  programs.nixvim.enable = true;
}
