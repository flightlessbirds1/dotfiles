{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.conform-nvim.enable = true;
    extraPackages = with pkgs; [
      nixfmt
      haskellPackages.fourmolu
      typstyle
      clang-tools
      elmPackages.elm-format
      rustfmt
      oxlint
    ];

    extraConfigLua = ''
      -- ── Conform.nvim Setup ────────────────────────────────────────────────
      require("conform").setup({
        format_on_save = {
          lsp_format = "fallback",
          timeout_ms = 500,
        },
        formatters_by_ft = {
          nix = { "nixfmt" },
          haskell = { "fourmolu" },
          typst = { "typstyle" },
          c = { "clang_format" },
          elm = { "elm_format" },
          rust = { "rustfmt" },
          typescript = { "oxfmt" },
          typescriptreact = { "oxfmt" },
        },
      })

      -- ── Trailing Whitespace Autocmd ───────────────────────────────────────
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          local buf = vim.fn.bufnr()
          local last = vim.fn.line("$")
          -- Remove extra trailing blank lines, keeping at most one
          while last > 1 and vim.fn.getline(last) == "" and vim.fn.getline(last - 1) == "" do
            vim.fn.deletebufline(buf, last)
            last = last - 1
          end
          -- Ensure exactly one trailing newline
          if vim.fn.getline(last) ~= "" then
            vim.fn.append(last, "")
          end
        end,
      })
    '';
  };
}
