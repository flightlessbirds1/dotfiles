{pkgs, ...}: {
  programs.zathura = {
    enable = true;
    package = import ./package.nix {
      inherit
        pkgs
        ;
    };
  };
}
