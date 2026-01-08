{
  config,
  lib,
  ...
}:
{
  programs.nushell = {
    enable = true;
    configFile.text = lib.readFile ./nu/nushell.nu;
    environmentVariables = lib.filterAttrs (name: _: name != "TERM") config.home.sessionVariables;

  };
}
