{inputs, ...}: {
  imports = [
    ./config/plugins/bufferline.nix
    ./config/plugins/conform.nix
    ./config/plugins/lazygit.nix
    ./config/plugins/lsp.nix
    ./config/plugins/neo_tree.nix
    ./config/plugins/treesitter.nix
    ./config/plugins/web_devicons.nix
    ./config/plugins/yazi.nix
    ./config/colorschemes.nix
    ./config/keymap.nix
    ./config/options.nix
    ./config/dep-ignore.nix
    inputs.nixvim.homeModules.nixvim
  ];
  programs.nixvim.enable = true;
}
