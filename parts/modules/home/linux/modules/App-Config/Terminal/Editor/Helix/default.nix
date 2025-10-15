{pkgs, ...}: {
  home.sessionVariables.EDITOR = "hx";

  home.packages = with pkgs; [
    clang-tools
    nil
    python3Packages.python-lsp-server
    python3Packages.ruff
    python3Packages.black

    nodePackages.typescript
    nodePackages.typescript-language-server
    svelte-language-server
    nodePackages.prettier
    nodePackages.yaml-language-server
    nodePackages.vscode-langservers-extracted

    shfmt

    rust-analyzer
    rustfmt

    haskellPackages.haskell-language-server

    tinymist
    typstfmt

    yamlfmt
  ];

  programs.helix = {
    enable = true;
    package = pkgs.helix;

    settings = {
      editor = {
        auto-format = true;
        auto-save = true;
        line-number = "absolute";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
      theme = "base16_transparent";
    };

    languages = {
      language = [
        {
          name = "nix";
          language-servers = [
            "nil"
          ];
          auto-format = true;
          formatter = {
            command = "alejandra";
          };
        }
        {
          name = "python";
          language-servers = [
            "ruff"
            "pylsp"
          ];
          auto-format = true;
          formatter = {
            command = "black";
            args = [
              "-q"
              "-"
            ];
          };
        }
        {
          name = "bash";
          language-servers = [];
          auto-format = true;
          formatter = {
            command = "shfmt";
          };
        }
        {
          name = "rust";
          language-servers = [
            "rust-analyzer"
          ];
          auto-format = true;
          formatter = {
            command = "rustfmt";
            args = [
              "--emit"
              "stdout"
            ];
          };
        }
        {
          name = "haskell";
          language-servers = [
            "hls"
          ];
          auto-format = true;
          formatter = {
            command = "stylish-haskell";
          };
        }
        {
          name = "typst";
          language-servers = [
            "tinymist"
          ];
          auto-format = true;
          formatter = {
            command = "typstfmt";
          };
        }
        {
          name = "yaml";
          language-servers = [
            "yaml-language-server"
          ];
          auto-format = true;
          formatter = {
            command = "yamlfmt";
            args = [
              "-in"
            ];
          };
        }
        {
          name = "css";
          language-servers = [
            "vscode-css-language-server"
          ];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--stdin-filepath"
              "dummy.css"
            ];
          };
        }
        {
          name = "scss";
          language-servers = [
            "vscode-css-language-server"
          ];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--stdin-filepath"
              "dummy.scss"
            ];
          };
        }
        {
          name = "svelte";
          language-servers = [
            "svelteserver"
          ];
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--stdin-filepath"
              "dummy.svelte"
            ];
          };
        }
      ];

      language-server = {
        ruff = {
          command = "ruff";
          args = [
            "server"
          ];
        };
        pylsp = {
          command = "pylsp";
        };
        "rust-analyzer" = {
          command = "rust-analyzer";
        };
        hls = {
          command = "haskell-language-server-wrapper";
          args = [
            "--lsp"
          ];
        };
        nil = {
          command = "nil";
        };
        tinymist = {
          command = "tinymist";
        };
        "yaml-language-server" = {
          command = "yaml-language-server";
          args = [
            "--stdio"
          ];
        };
        "vscode-css-language-server" = {
          command = "vscode-css-language-server";
          args = [
            "--stdio"
          ];
        };
        svelteserver = {
          command = "svelteserver";
        };
      };
    };
  };
}
