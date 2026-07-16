{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = with pkgs; [
      delta
    ];

    plugins = {
      indent-blankline.enable = true;
      neoscroll.enable = true;
      todo-comments.enable = true;
    };

    extraConfigLua = ''
      -- ── Vim Options ───────────────────────────────────────────────────────
      vim.opt.swapfile = false
      vim.opt.undofile = true
      vim.opt.fillchars = { eob = " " }
      vim.opt.clipboard = "unnamedplus"
      vim.opt.laststatus = 3

      -- Environment variables
      vim.env.BAT_THEME = "TwoDark"

      -- ── Highlights for Indent Blankline ───────────────────────────────────
      vim.api.nvim_set_hl(0, "IblIndent1", { fg = "#51303a" })
      vim.api.nvim_set_hl(0, "IblIndent2", { fg = "#51402a" })
      vim.api.nvim_set_hl(0, "IblIndent3", { fg = "#304830" })
      vim.api.nvim_set_hl(0, "IblIndent4", { fg = "#284848" })
      vim.api.nvim_set_hl(0, "IblIndent5", { fg = "#283848" })
      vim.api.nvim_set_hl(0, "IblIndent6", { fg = "#3a2851" })


      -- Indent Blankline (ibl)
      require("ibl").setup({
        indent = {
          char = "▏",
          highlight = {
            "IblIndent1",
            "IblIndent2",
            "IblIndent3",
            "IblIndent4",
            "IblIndent5",
            "IblIndent6",
          },
        },
      })

      require("neoscroll").setup({})

      require("todo-comments").setup({})
      require("telescope").setup({
        extensions = {
          undo = {
            use_delta = true,
          },
        },
      })

      require("telescope").load_extension("undo")

      vim.keymap.set("n", "<A-u>", "<cmd>Telescope undo<CR>", { desc = "Undo history (telescope)", silent = true })
    '';
  };
}
