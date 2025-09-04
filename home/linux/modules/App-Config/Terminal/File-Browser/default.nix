{
  lib,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    keymap.mgr.prepend_keymap = [
      {
        on = [
          "Q"
        ];
        run = "quit";
      }
      {
        on = [
          "q"
        ];
        run = "quit --no-cwd-file";
      }
    ];
    settings.mgr.show_hidden = true;
    plugins = {
      chmod = pkgs.yaziPlugins.chmod;
      lazygit = pkgs.yaziPlugins.lazygit;
      starship = pkgs.yaziPlugins.starship;
      mediainfo = pkgs.yaziPlugins.mediainfo;
      full-border = pkgs.yaziPlugins.full-border;
    };
  };
}
