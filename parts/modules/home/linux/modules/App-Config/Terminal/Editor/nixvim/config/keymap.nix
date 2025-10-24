{
  programs.nixvim = {
    globals.mapleader = " ";
    keymaps = [
      {
        key = "gh";
        action = "^";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "gl";
        action = "$";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "gs";
        action = "0";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "ge";
        action = "G";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "gt";
        action = "H";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "gc";
        action = "M";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "gb";
        action = "L";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "gk";
        action = "gk";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "gj";
        action = "gj";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "x";
        action = "V";
        mode = "n";
        options.silent = true;
      }
      {
        key = "x";
        action = "j";
        mode = "v";
        options.silent = true;
      }
      {
        key = "X";
        action = "k";
        mode = "v";
        options.silent = true;
      }
      {
        key = "<A-x>";
        action = "<Esc>V";
        mode = "v";
        options.silent = true;
      }
      {
        key = "w";
        action = "ve";
        mode = "n";
        options.silent = true;
      }
      {
        key = "w";
        action = "<Esc>wve";
        mode = "v";
        options.silent = true;
      }
      {
        key = "b";
        action = "<cmd>lua vim.cmd('normal! hvb')<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "b";
        action = "<Esc><cmd>lua vim.cmd('normal! hvb')<CR>";
        mode = "v";
        options.silent = true;
      }
      {
        key = "e";
        action = "ve";
        mode = "n";
        options.silent = true;
      }
      {
        key = "e";
        action = "<Esc>eve";
        mode = "v";
        options.silent = true;
      }
      {
        key = "W";
        action = "vE";
        mode = "n";
        options.silent = true;
      }
      {
        key = "W";
        action = "<Esc>WvE";
        mode = "v";
        options.silent = true;
      }
      {
        key = "B";
        action = "BvE";
        mode = "n";
        options.silent = true;
      }
      {
        key = "B";
        action = "<Esc>BvE";
        mode = "v";
        options.silent = true;
      }
      {
        key = "m";
        action = "v%";
        mode = "n";
        options.silent = true;
      }
      {
        key = "m";
        action = "%";
        mode = "v";
        options.silent = true;
      }
      {
        key = "%";
        action = "ggVG";
        mode = "n";
        options.silent = true;
      }
      {
        key = ";";
        action = "<Esc>";
        mode = "v";
        options.silent = true;
      }
      {
        key = "<A-;>";
        action = "o";
        mode = "v";
        options.silent = true;
      }
      {
        key = ",";
        action = "<Esc>";
        mode = "v";
        options.silent = true;
      }
      {
        key = "C";
        action = "yyp";
        mode = "n";
        options.silent = true;
      }
      {
        key = "C";
        action = "y`>p";
        mode = "v";
        options.silent = true;
      }
      {
        key = "<A-C>";
        action = "yyP";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<A-C>";
        action = "y`<P";
        mode = "v";
        options.silent = true;
      }
      {
        key = "s";
        action = ":s/";
        mode = "v";
        options.silent = false;
      }
      {
        key = "<A-s>";
        action = "<Esc>";
        mode = "v";
        options.silent = true;
      }
      {
        key = "~";
        action = "~";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "`";
        action = "gu";
        mode = "v";
        options.silent = true;
      }
      {
        key = "<A-`>";
        action = "gU";
        mode = "v";
        options.silent = true;
      }
      {
        key = ">";
        action = ">>";
        mode = "n";
        options.silent = true;
      }
      {
        key = ">";
        action = ">gv";
        mode = "v";
        options.silent = true;
      }
      {
        key = "<lt>";
        action = "<<";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<lt>";
        action = "<gv";
        mode = "v";
        options.silent = true;
      }
      {
        key = "<leader>f";
        action = "<cmd>Telescope find_files<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>F";
        action = "<cmd>Telescope find_files cwd=%:p:h<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>b";
        action = "<cmd>Telescope buffers<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>c";
        action = "<cmd>bd<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>k";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>r";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>a";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "<leader>s";
        action = "<cmd>Telescope lsp_document_symbols<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>S";
        action = "<cmd>Telescope lsp_workspace_symbols<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>d";
        action = "<cmd>Telescope diagnostics<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>/";
        action = "<cmd>Telescope live_grep<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>?";
        action = "<cmd>Telescope commands<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>w";
        action = "<cmd>w<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>e";
        action = "<cmd>Neotree toggle<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>g";
        action = "<cmd>LazyGit<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>y";
        action = "<cmd>Yazi<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<leader>p";
        action = "\"+p";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "<leader>P";
        action = "\"+P";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "<leader>Y";
        action = "\"+y";
        mode = "v";
        options.silent = true;
      }
      {
        key = "<leader>R";
        action = "\"+p";
        mode = "v";
        options.silent = true;
      }
      {
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "gr";
        action = "<cmd>Telescope lsp_references<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "gi";
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "gy";
        action = "<cmd>lua vim.lsp.buf.type_definition()<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "gD";
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "]D";
        action = "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "[D";
        action = "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "]b";
        action = "<cmd>bnext<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "[b";
        action = "<cmd>bprevious<CR>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<C-h>";
        action = "<C-w>h";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<C-j>";
        action = "<C-w>j";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<C-k>";
        action = "<C-w>k";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<C-l>";
        action = "<C-w>l";
        mode = "n";
        options.silent = true;
      }
      {
        key = "U";
        action = "<C-r>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<A-J>";
        action = "gJ";
        mode = ["n" "v"];
        options.silent = true;
      }
      {
        key = "<C-a>";
        action = "<C-a>";
        mode = "n";
        options.silent = true;
      }
      {
        key = "<C-x>";
        action = "<C-x>";
        mode = "n";
        options.silent = true;
      }
    ];
  };
}
