{ pkgs, ... }:
{
  home.sessionVariables.EDITOR = "hx";

  home.packages = builtins.attrValues {
    inherit (pkgs)
      nixd
      nixfmt
      jdt-language-server
      zulu25
      ;
  };

  programs.helix = {
    enable = true;
    package = pkgs.helix;

    settings = {
      editor = {
        auto-format = true;
        auto-save = true;
        line-number = "relative";
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
            "nixd"
          ];
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
        }
      ];

      language-server = {
        nil = {
          command = "nil";
        };
      };
    };
  };
}
