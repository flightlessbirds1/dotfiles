{ pkgs, pkgs-stable, ... }:
let
  fileViewers = fileType: {
    mime = "application/" + fileType;
    run = "ouch";
  };
in
{
  imports = [
    ./extraPackages.nix
    ./keymap.nix
  ];

  programs.yazi = {
    enable = true;
    package = pkgs-stable.yazi;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    initLua = ''
      require("full-border"):setup()
    '';
    settings = {
      plugin.prepend_previewers = (
        map fileViewers [
          "*zip"
          "x-tar"
          "x-bzip2"
          "x-7z-compressed"
          "x-rar"
          "vnd.rar"
          "x-xz"
          "xz"
          "x-zstd"
          "zstd"
          "java-archive"
        ]
      );
      mgr.show_hidden = false;
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
      opener = {
        pdf = [
          {
            run = ''zathura "$@"'';
            block = true;
            orphan = false;
          }
        ];
        nvim = [
          {
            run = ''nvim "$@"'';
            block = true;
            orphan = false;
          }
        ];
      };
      open = {
        prepend_rules = [
          {
            name = "*.pdf";
            use = "pdf";
          }
          {
            name = "*.lean";
            use = "nvim";
          }
        ];
        append_rules = [
          {
            name = "*";
            use = ''mimeo "$1"'';
            desc = "Open";
          }
        ];
      };
    };
    plugins = {
      inherit (pkgs.yaziPlugins)
        mediainfo
        chmod
        starship
        lazygit
        ouch
        bypass
        restore
        full-border
        ;
    };
  };
}
