{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting
      nix-your-shell fish | source
      set -gx EDITOR hx
      set -gx YAZI_ADAPTER ueberzug
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
