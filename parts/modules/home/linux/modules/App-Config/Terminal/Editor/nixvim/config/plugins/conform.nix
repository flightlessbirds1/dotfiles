{
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
        };
      };
    };

    keymaps = [
      {
        key = "<leader>fm";
        action = "<cmd>lua require('conform').format({ async = true, lsp_format = 'fallback' })<CR>";
        mode = ["n" "v"];
        options = {
          silent = true;
          desc = "Format buffer";
        };
      }
    ];
  };
}
