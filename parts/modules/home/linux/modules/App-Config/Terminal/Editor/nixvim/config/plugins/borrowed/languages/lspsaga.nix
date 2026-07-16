{
  programs.nixvim = {
    plugins.lspsaga.enable = true;
    extraConfigLua = ''
      -- Guard function for LSP-dependent keymaps.
      _G.lspsaga_guard = function(capability, cmd, desc)
        for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          if c.server_capabilities[capability] then
            vim.cmd(cmd)
            return
          end
        end
        vim.notify(
          desc .. ' is not supported by the current LSP server.',
          vim.log.levels.WARN
        )
      end

      -- Setup Lspsaga
      require('lspsaga').setup({
        ui = {
          border = 'rounded',
          code_action = '💡',
        },
        lightbulb = {
          enable = true,
          sign = false,
          virtual_text = true,
        },
        diagnostic = {
          show_code_action = true,
          max_width = 0.7,
          max_height = 0.6,
          text_hl_follow = true,
          border_follow = true,
          keys = {
            exec_action = 'o',
            quit = 'q',
            toggle_or_jump = '<CR>',
            quit_in_show = { 'q', '<ESC>' },
          },
        },
        finder = {
          max_height = 0.5,
          left_width = 0.4,
          default = 'ref+def+impl',
          layout = 'float',
          keys = {
            toggle_or_open = 'o',
            vsplit = 's',
            split = 'i',
            tabe = 't',
            quit = 'q',
          },
        },
        hover = {
          max_width = 0.9,
          max_height = 0.8,
          open_link = 'gx',
        },
        rename = {
          auto_save = false,
          keys = {
            quit = '<C-k>',
            exec = '<CR>',
            select = 'x',
          },
        },
        code_action = {
          num_shortcut = true,
          show_server_name = false,
          extend_gitsigns = false,
          keys = {
            quit = 'q',
            exec = '<CR>',
          },
        },
        outline = {
          win_position = 'right',
          win_width = 30,
          auto_preview = true,
          close_after_jump = false,
          show_detail = true,
          keys = {
            toggle_or_jump = 'o',
            quit = 'q',
            jump = 'e',
          },
        },
        symbol_in_winbar = {
          enable = true,
          separator = ' › ',
          show_file = true,
          folder_level = 1,
          color_mode = true,
          delay = 300,
        },
        scroll_preview = {
          scroll_down = '<C-f>',
          scroll_up   = '<C-b>',
        },
        callhierarchy = {
          layout = 'float',
          keys = {
            edit = 'e',
            vsplit = 's',
            split = 'i',
            tabe = 't',
            quit = 'q',
            shuttle = '[w',
            toggle_or_req = 'u',
          },
        },
        implement = {
          enable = true,
          sign = true,
          virtual_text = true,
        },
        beacon = {
          enable = true,
          frequency = 7,
        },
      })

      -- ── Keymaps ───────────────────────────────────────────────────────────
      -- Translated from Nix arrays into native Lua keymaps

      local map = vim.keymap.set

      map("n", "K", function() lspsaga_guard('hoverProvider', 'Lspsaga hover_doc', 'K (hover documentation)') end, { desc = "LSP hover documentation", silent = true })
      map("n", "<A-f>", function() lspsaga_guard('referencesProvider', 'Lspsaga finder', 'Alt+F (finder)') end, { desc = "LSP finder (refs / defs / impls)", silent = true })
      map("n", "gp", function() lspsaga_guard('definitionProvider', 'Lspsaga peek_definition', 'gp (peek definition)') end, { desc = "Peek definition", silent = true })
      map("n", "gd", function() lspsaga_guard('definitionProvider', 'Lspsaga goto_definition', 'gd (go to definition)') end, { desc = "Go to definition", silent = true })
      map("n", "gP", function() lspsaga_guard('typeDefinitionProvider', 'Lspsaga peek_type_definition', 'gP (peek type definition)') end, { desc = "Peek type definition", silent = true })
      map("n", "gT", function() lspsaga_guard('typeDefinitionProvider', 'Lspsaga goto_type_definition', 'gT (go to type definition)') end, { desc = "Go to type definition", silent = true })
      map("n", "<A-r>", function() lspsaga_guard('renameProvider', 'Lspsaga rename', 'Alt+R (rename)') end, { desc = "LSP rename", silent = true })

      -- Code action works in both Normal and Visual mode
      map({ "n", "v" }, "<A-a>", function() lspsaga_guard('codeActionProvider', 'Lspsaga code_action', 'Alt+A (code action)') end, { desc = "LSP code action", silent = true })

      map("n", "<A-e>", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Show line diagnostics", silent = true })
      map("n", "<A-E>", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { desc = "Show cursor diagnostics", silent = true })
      map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next diagnostic", silent = true })
      map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Previous diagnostic", silent = true })

      map("n", "<A-O>", function() lspsaga_guard('documentSymbolProvider', 'Lspsaga outline', 'Alt+Shift+O (outline)') end, { desc = "Toggle symbol outline", silent = true })
      map("n", "<A-i>", function() lspsaga_guard('callHierarchyProvider', 'Lspsaga incoming_calls', 'Alt+I (incoming calls)') end, { desc = "Incoming call hierarchy", silent = true })
      map("n", "<A-o>", function() lspsaga_guard('callHierarchyProvider', 'Lspsaga outgoing_calls', 'Alt+O (outgoing calls)') end, { desc = "Outgoing call hierarchy", silent = true })
      map("n", "gi", function() lspsaga_guard('implementationProvider', 'Lspsaga finder imp', 'gi (show implementations)') end, { desc = "Show implementations", silent = true })

      -- Terminal works in Normal and Terminal mode
      map({ "n", "t" }, "<A-t>", "<cmd>Lspsaga term_toggle<CR>", { desc = "Toggle floating terminal", silent = true })
    '';
  };
}
