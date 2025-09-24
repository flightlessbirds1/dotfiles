{pkgs, ...}: {
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
      inherit (pkgs.yaziPlugins) chmod;
      inherit (pkgs.yaziPlugins) lazygit;
      inherit (pkgs.yaziPlugins) starship;
      inherit (pkgs.yaziPlugins) mediainfo;
      inherit (pkgs.yaziPlugins) full-border;
    };
  };
}
