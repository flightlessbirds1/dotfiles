{
  inputs,
  pkgs,
  lib,
  config,
  flake,
  ...
}:
{
  dconf.enable = true;
  xsession.enable = true;
}
