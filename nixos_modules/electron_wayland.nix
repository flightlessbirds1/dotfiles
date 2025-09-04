{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
