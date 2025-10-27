{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;
    packages = builtins.attrValues {
      inherit
        (pkgs)
        noto-fonts-cjk-sans
        ;
      inherit
        (pkgs.nerd-fonts)
        jetbrains-mono
        ;
    };
  };
}
