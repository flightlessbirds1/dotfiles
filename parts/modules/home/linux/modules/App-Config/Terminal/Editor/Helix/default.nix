{ pkgs, ... }:
{
  home.sessionVariables.EDITOR = "hx";

  home.packages = builtins.attrValues {
    inherit (pkgs)
      nil
      jdt-language-server
      ;
  };

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
          auto-format = false;
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
