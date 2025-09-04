{ config, pkgs, ... }:
{
  imports = [ ./shekl.nix ];
  home.packages = with pkgs; [ nix-your-shell ];

  home.file."${config.xdg.configHome}/nushell/nix-your-shell.nu".source =
    pkgs.nix-your-shell.generate-config "nu";

  programs.nushell = {
    enable = true;
    configFile.text = ''
      source nix-your-shell.nu
      sleep 7ms
      $env.config = { show_banner: false }
    '';
    environmentVariables = builtins.mapAttrs (
      name: value: builtins.toString value
    ) config.home.sessionVariables;
  };
}
