let
  kmap = key: action: mode: {
    inherit key action mode;
    options.silent = true;
  };
  normap = key: action: kmap key action [ "n" ];
  vismap = key: action: kmap key action [ "v" ];
  norvismap =
    key: action:
    kmap key action [
      "n"
      "v"
    ];

in
{
  programs.nixvim = {
    globals.mapleader = " ";
    keymaps = [
      (norvismap "gh" "0")
      (norvismap "gl" "$")
      (normap "<leader>f" "<cmd>Telescope find_files<CR>")
      (normap "<leader>F" "<cmd>Telescope find_files cwd=%:p:h<CR>")
      (normap "<leader>b" "<cmd>Telescope buffers<CR>")
      (normap "<leader>c" "<cmd>bd<CR>")
      (normap "<leader>k" "<cmd>lua vim.lsp.buf.hover()<CR>")
      (normap "<leader>r" "<cmd>lua vim.lsp.buf.rename()<CR>")
      (norvismap "<leader>a" "<cmd>lua vim.lsp.buf.code_action()<CR>")
      (normap "<leader>s" "<cmd>Telescope lsp_document_symbols<CR>")
      (normap "<leader>S" "<cmd>Telescope lsp_workspace_symbols<CR>")
      (normap "<leader>d" "<cmd>Telescope diagnostics<CR>")
      (normap "<leader>?" "<cmd>Telescope commands<CR>")
      (normap "<leader>e" "<cmd>Neotree toggle<CR>")
      (normap "<leader>g" "<cmd>LazyGit<CR>")
      (normap "<leader>y" "<cmd>Yazi<CR>")
      (norvismap "<leader>p" "\"+p")
      (norvismap "<leader>P" "\"+P")
      (vismap "<leader>Y" "\"+y")
      (vismap "<leader>R" "\"+p")
      (normap "gd" "<cmd>lua vim.lsp.buf.definition()<CR>")
      (normap "gr" "<cmd>Telescope lsp_references<CR>")
      (normap "gi" "<cmd>lua vim.lsp.buf.implementation()<CR>")
      (normap "gy" "<cmd>lua vim.lsp.buf.type_definition()<CR>")
      (normap "gD" "<cmd>lua vim.lsp.buf.declaration()<CR>")
      (normap "K" "<cmd>lua vim.lsp.buf.hover()<CR>")
      (normap "]d" "<cmd>lua vim.diagnostic.goto_next()<CR>")
      (normap "[d" "<cmd>lua vim.diagnostic.goto_prev()<CR>")
      (normap "]D" "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>")
      (normap "[D" "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>")
      (normap "]b" "<cmd>bnext<CR>")
      (normap "[b" "<cmd>bprevious<CR>")
      (normap "gw" "<cmd>HopWord<CR>")
      (normap "<C-h>" "<C-w>h")
      (normap "<C-j>" "<C-w>j")
      (normap "<C-k>" "<C-w>k")
      (normap "<C-l>" "<C-w>l")
      (normap "U" "<C-r>")
      (norvismap "<A-J>" "gJ")
      (normap "<C-a>" "<C-a>")
      (normap "<C-x>" "<C-x>")
    ];
  };
}
