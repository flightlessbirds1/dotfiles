{ pkgs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      nushell
      ;
  };
  environment.shells = builtins.attrValues {
    inherit (pkgs)
      nushell
      ;
  };
}
