{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      git
      git-lfs
      git-credential-manager
      ;
  };
}
