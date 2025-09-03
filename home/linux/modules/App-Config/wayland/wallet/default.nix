{
  pkgs,
  ...
}:
{
  home.packages = builtins.attrValues {
    inherit (pkgs.kdePackages)
      kwallet-pam
      # kwalletmanager
      ;
  };
  programs.gpg = {
    enable = true;
  };
}

# use this to make annoying shit go away:
# gpg --pinentry-mode loopback --full-generate-key
