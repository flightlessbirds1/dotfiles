{
  programs.nixvim = {
    plugins.lean = {
      enable = true;
      autoLoad = true;
      settings.mappings = false;
      settings.lsp = {
        init_options = {
          inlayHints = false;
        };
      };
    };

    extraConfigLua = ''
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "leanls" and client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_buf_set_option(args.buf, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
          end
        end,
      })
    '';
  };
}
