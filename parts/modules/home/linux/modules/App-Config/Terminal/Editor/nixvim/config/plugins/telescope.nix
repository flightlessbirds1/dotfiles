{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
    extensions.undo.enable = true;
  };
}
