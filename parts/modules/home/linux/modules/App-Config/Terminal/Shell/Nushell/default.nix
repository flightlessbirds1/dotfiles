{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;

    configFile.text = lib.readFile ./nu/nushell.nu;

    environmentVariables = lib.filterAttrs (name: _: name != "TERM") config.home.sessionVariables;
  };
}
