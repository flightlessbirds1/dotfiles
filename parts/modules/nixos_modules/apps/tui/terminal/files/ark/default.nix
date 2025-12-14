{ pkgs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs.kdePackages)
      ark
      ;
  };
}
