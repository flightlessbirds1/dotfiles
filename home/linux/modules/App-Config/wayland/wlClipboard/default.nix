{
  pkgs,
  ...
}:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      wl-clipboard
      ;
  };

  services.cliphist.enable = true;
}
