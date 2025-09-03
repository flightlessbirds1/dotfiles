{
  programs.nixvim = {
    globals.mapleader = " ";
    keymaps = [
      # bufferline
      {
        key = "<Tab>";
        action = "<cmd>BufferLineCycleNext<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<S-Tab>";
        action = "<cmd>BufferLineCyclePrev<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>x";
        action = "<cmd>bd<CR>";
        mode = "n";
        options.silent = true;
      }
      # lazygit
      {
        action = "<cmd>LazyGit<CR>";
        key = "<leader>l";
        mode = "n";
        options.silent = true;
      }
      # lsp
      {
        key = "<leader>f";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
        mode = "n";
        options.silent = true;
      }
      # neo-tree
      {
        action = "<cmd>Neotree toggle<CR>";
        key = "<leader>e";
        mode = "n";
        options.silent = true;
      }
      # nvim
      {
        key = "<leader>w";
        action = "<cmd>w<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>q";
        action = "<cmd>q<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>wq";
        action = "<cmd>wq<CR>";
        mode = "n";
        options.silent = true;
      }
      # yazi
      {
        action = "<cmd>Yazi<CR>";
        key = "<leader>y";
        mode = "n";
        options.silent = true;
      }
    ];
  };
}
