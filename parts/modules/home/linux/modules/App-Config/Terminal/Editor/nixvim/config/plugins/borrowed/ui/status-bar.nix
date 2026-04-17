{
  programs.nixvim = {
    plugins = {
      lualine.enable = true;
    };
    initLua = ''
      -- ── Lualine Setup ─────────────────────────────────────────────────────
      local notNeoTree = function()
        return vim.bo.filetype ~= 'neo-tree'
      end

      require("lualine").setup({
        options = {
          disabled_filetypes = {
            statusline = { "neo-tree" },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
              diff_color = {
                added = { fg = "#9ece6a" },
                modified = { fg = "#e0af68" },
                removed = { fg = "#f7768e" },
              },
              cond = notNeoTree,
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_lsp" },
              sections = { "error", "warn", "info" },
              always_visible = true,
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
              },
              diagnostics_color = {
                error = { fg = "#f7768e" },
                warn = { fg = "#e0af68" },
                info = { fg = "#7dcfff" },
              },
              cond = notNeoTree,
            },
          },
          lualine_y = {
            {
              "progress",
              cond = notNeoTree,
            },
          },
          lualine_z = {
            {
              "location",
              cond = notNeoTree,
            },
          },
        },
      })
    '';
  };
}
