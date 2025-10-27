{
  config,
  pkgs,
  ...
}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      nix-your-shell
      ;
  };
  home.file."${config.xdg.configHome}/nushell/nix-your-shell.nu".source =
    pkgs.nix-your-shell.generate-config "nu";
  programs.nushell = {
    enable = true;
    configFile.text = ''
      source nix-your-shell.nu
      sleep 7ms
      $env.config = {
        show_banner: false
        keybindings: [
          {
            name: delete_word_left
            modifier: control
            keycode: char_h
            mode: [emacs, vi_insert, vi_normal]
            event: { edit: cutwordleft }
          }
        ]
      }
    '';
    environmentVariables =
      builtins.mapAttrs (
        _name: value: builtins.toString value
      )
      config.home.sessionVariables;
  };
}
