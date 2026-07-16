{
  programs.nixvim = {
    plugins = {
      nui.enable = true;
      notify.enable = true;
      noice.enable = true;
    };

    extraConfigLua = ''
      -- ── Nvim-Notify Setup ──────────────────────────────────────────────────
      require("notify").setup({
        stages = "fade",
        timeout = 1000,
        max_width = 60,
        max_height = 10,
        icons = {
          ERROR = "✘",
          WARN = "⚠",
          INFO = "🛈",
          DEBUG = "⚙",
          TRACE = "✏",
        },
        render = "wrapped-compact",
      })
      vim.notify = require("notify")
      do
        local original_notify = vim.notify
        vim.notify = function(msg, ...)
          if type(msg) == 'string' then
            msg = msg:gsub('\0', '\n')
          end
          return original_notify(msg, ...)
        end
      end
      vim.keymap.set(
        { "n", "i", "v", "t", "c" },
        "<A-q>",
        function() require("notify").dismiss({ silent = true, pending = false }) end,
        { desc = "Dismiss all visible notifications" }
      )
      -- ── Noice Setup ───────────────────────────────────────────────────────
      require("noice").setup({
        notify = { enabled = true },
        lsp = { progress = { enabled = true } },
        routes = {
          { filter = { event = "msg_show", min_height = 10 }, view = "split" },
          { filter = { event = "msg_show", kind = "emsg" }, view = "notify", opts = { level = "error", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "echoerr" }, view = "notify", opts = { level = "error", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "lua_error" }, view = "notify", opts = { level = "error", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "rpc_error" }, view = "notify", opts = { level = "error", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "wmsg" }, view = "notify", opts = { level = "warn", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "" }, view = "notify", opts = { level = "info", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "echo" }, view = "notify", opts = { level = "info", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "echomsg" }, view = "notify", opts = { level = "info", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "confirm" }, view = "notify", opts = { level = "info", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "confirm_sub" }, view = "notify", opts = { level = "info", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "number_prompt" }, view = "notify", opts = { level = "info", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "return_prompt" }, view = "notify", opts = { level = "info", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "list_cmd" }, view = "notify", opts = { level = "info", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "quickfix" }, view = "notify", opts = { level = "info", timeout = 1000 } },
          { filter = { event = "msg_show", kind = "search_count" }, view = "notify", opts = { level = "info", timeout = 1000 } },
        },
      })
    '';
  };
}
