{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.dual_modules.modules.gnome;
in {
  environment.sessionVariables.NIXOS_OZONE_WL = lib.mkIf cfg.enable "1";
}
