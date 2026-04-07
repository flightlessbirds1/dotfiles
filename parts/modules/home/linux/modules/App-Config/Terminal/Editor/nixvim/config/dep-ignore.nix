{
  programs.nixvim = {
    extraConfigLuaPre = ''
      local original_notify = vim.notify
      vim.notify = function(msg, level, opts)
        if msg and type(msg) == "string" and (
          msg:match("lspconfig.*deprecated") or
          msg:match("deprecated.*lspconfig")
        ) then
          return
        end
        original_notify(msg, level, opts)
      end

      vim.deprecate = function() end
    '';

    extraConfigLua = ''
      vim.api.nvim_create_user_command('Q', 'qall', { bang = true })
      vim.api.nvim_create_user_command('Qa', 'qall', { bang = true })
      vim.api.nvim_create_user_command('QA', 'qall', { bang = true })
      vim.api.nvim_create_user_command('Qall', 'qall', { bang = true })

      vim.keymap.set('n', '<leader>q', '<cmd>qall<CR>', { silent = true })
      vim.keymap.set('n', '<leader>Q', '<cmd>qall!<CR>', { silent = true })

      vim.keymap.set('n', 'ZZ', '<cmd>wqall<CR>', { silent = true })
      vim.keymap.set('n', 'ZQ', '<cmd>qall!<CR>', { silent = true })

      vim.cmd([[
        cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == 'q' ? 'qall' : 'q'
        cnoreabbrev <expr> wq getcmdtype() == ":" && getcmdline() == 'wq' ? 'wqall' : 'wq'
      ]])
    '';
  };
}
