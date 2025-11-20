{pkgs, ...}: {
  imports = [
    ./extraPackages.nix
    ./keymap.nix
  ];

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    initLua = ''
      require("full-border"):setup()
    '';
    settings = {
      plugin.prepend_previewers = [
        {
          mime = "application/*zip";
          run = "ouch";
        }
        {
          mime = "application/x-tar";
          run = "ouch";
        }
        {
          mime = "application/x-bzip2";
          run = "ouch";
        }
        {
          mime = "application/x-7z-compressed";
          run = "ouch";
        }
        {
          mime = "application/x-rar";
          run = "ouch";
        }
        {
          mime = "application/vnd.rar";
          run = "ouch";
        }
        {
          mime = "application/x-xz";
          run = "ouch";
        }
        {
          mime = "application/xz";
          run = "ouch";
        }
        {
          mime = "application/x-zstd";
          run = "ouch";
        }
        {
          mime = "application/zstd";
          run = "ouch";
        }
        {
          mime = "application/java-archive";
          run = "ouch";
        }
      ];
      mgr.show_hidden = false;
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
      opener = {
        nvim = [
          {
            run = ''nvim "$@"'';
            block = true;
            orphan = false;
          }
        ];
        pdf = [
          {
            run = ''zathura "$@"'';
            block = true;
            orphan = false;
          }
        ];
      };
      open = {
        prepend_rules = [
          {
            name = "*.lean";
            use = "nvim";
          }
          {
            name = "*.pdf";
            use = "pdf";
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
      inherit (pkgs.yaziPlugins) mediainfo chmod starship lazygit ouch bypass restore full-border;
    };
  };
}
