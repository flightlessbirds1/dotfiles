{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      ente-auth
      ;
  };
}
