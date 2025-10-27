{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      git
      git-credential-manager
      ;
  };
}
