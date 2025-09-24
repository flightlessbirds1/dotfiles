{pkgs, ...}: {
  programs.zathura = {
    enable = true;
    package = import ./package {
      inherit
        pkgs
        ;
    };
  };
}
