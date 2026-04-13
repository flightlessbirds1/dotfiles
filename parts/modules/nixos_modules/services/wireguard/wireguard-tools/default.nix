{ pkgs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      wireguard-tools
      proton-vpn
      ;
  };
}
