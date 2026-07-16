{
  programs.nixvim = {
    plugins = {
      lspconfig.enable = true;
      lean.enable = true;
      # neotest.adapters.plenary.enable = true;
    };
    # Optional Language Servers
    # extraPackages = with pkgs; [
    # nil # nil_ls
    # marksman # marksman
    # bash-language-server # bashls
    # typescript-language-server # ts_ls
    # haskell-language-server # hls
    # ghc # hls (installGhc)
    # tinymist # tinymist
    # clang-tools # clangd
    # basedpyright # basedpyright
    # vscode-langservers-extracted # html, cssls, jsonls
    # jdt-language-server # jdtls
    # gopls # gopls
    # taplo # taplo
    # yaml-language-server # yamlls
    # elmPackages.elm-language-server # elmls
    # rust-analyzer # rust_analyzer
    # cargo # rust_analyzer (installCargo)
    # rustc # rust_analyzer (installRustc)
    # ];

    extraConfigLua = ''
      -- ── LSP Configuration ──────────────────────────────────────────────────
      local lspconfig = require('lspconfig')

      -- Array of servers that just need default initialization
      local default_servers = {
        'nil_ls', 'marksman', 'ts_ls', 'hls', 'tinymist',
        'clangd', 'basedpyright', 'html', 'cssls', 'jdtls',
        'gopls', 'taplo', 'jsonls', 'yamlls', 'elmls', 'rust_analyzer'
      }

      for _, lsp in ipairs(default_servers) do
        lspconfig[lsp].setup({})
      end

      -- Bash LSP with custom filetypes
      lspconfig.bashls.setup({
        filetypes = { "sh", "bash", "zsh" }
      })

      -- ── Lean.nvim Configuration ───────────────────────────────────────────
      require('lean').setup({
        mappings = true,
        infoview = {
          height = 10,
          orientation = "horizontal",
          horizontal_position = "bottom",
          indicators = "always",
        },
      })
    '';
  };
}
