{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting
      nix-your-shell fish | source
    '';
  };
}
