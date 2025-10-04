{
  flake,
  lib,
  ...
}: let
  inherit (flake.config.aesthetics.themes.${flake.config.aesthetics.currentTheme}) colors;
  makeColor = c: "#" + c;
  makeStyle = bg: fg: "bg:" + bg + " fg:" + fg + " bold";
  surround = fg: text:
    "[](fg:"
    + makeColor colors.base
    + " bg:"
    + fg
    + ")"
    + "[█](fg:"
    + fg
    + ")"
    + text
    + "[█](fg:"
    + fg
    + ")";
in {
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = false;
      character = let
        makeChar = bg: c:
          surround (makeColor bg) ("[" + c + "](" + makeStyle (makeColor bg) (makeColor colors.crust) + ")");
      in {
        error_symbol = makeChar colors.maroon "⊥";
        format = "$symbol";
        success_symbol = makeChar colors.teal "λ";
      };
      cmd_duration = {
        format = surround (makeColor colors.mauve) "[ $duration]($style)";
        min_time = 0;
        show_milliseconds = true;
        style = makeStyle (makeColor colors.mauve) (makeColor colors.crust);
      };
      directory = {
        format = surround (makeColor colors.blue) "[󰉋 $path]($style)[$read_only]($read_only_style)";
        read_only = "  ";
        read_only_style = makeStyle (makeColor colors.blue) (makeColor colors.crust);
        style = makeStyle (makeColor colors.blue) (makeColor colors.crust);
        truncation_length = 1;
        truncate_to_repo = false;
      };
      git_branch = {
        format = surround (makeColor colors.peach) "[$symbol $branch]($style)";
        style = makeStyle (makeColor colors.peach) (makeColor colors.crust);
        symbol = "";
      };
      git_status = {
        format = "[ \\[$all_status$ahead_behind\\]]($style)";
        style = makeStyle (makeColor colors.yellow) (makeColor colors.crust);
      };
      hostname = {
        format = surround (makeColor colors.sapphire) "[$ssh_symbol$hostname]($style)";
        ssh_symbol = "󰖟 ";
        style = makeStyle (makeColor colors.sapphire) (makeColor colors.crust);
      };
      format = lib.concatStrings [
        "$hostname"
        "$shell"
        "$directory"
        "$git_branch"
        "$cmd_duration"
        "$character "
      ];
    };
  };
}
