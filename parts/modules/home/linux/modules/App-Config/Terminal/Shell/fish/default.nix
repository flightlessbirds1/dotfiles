{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting
      set -gx EDITOR hx
      set -gx YAZI_ADAPTER ueberzug
      eval "$(direnv hook fish)"
    '';
    functions = {
      yazi = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
    };
  };
  home.shell.enableShellIntegration = true;
}
