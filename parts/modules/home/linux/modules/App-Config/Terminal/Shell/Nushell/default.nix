{
  config,
  pkgs,
  ...
}:
{
  programs.nushell = {
    enable = true;
    configFile.text = ''
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
    environmentVariables = builtins.mapAttrs (
      _name: value: builtins.toString value
    ) config.home.sessionVariables;
    package = pkgs.nushell;
  };
}
