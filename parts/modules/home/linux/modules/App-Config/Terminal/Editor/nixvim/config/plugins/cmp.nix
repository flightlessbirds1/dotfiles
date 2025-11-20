{
  programs.nixvim = {
    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;

        settings = {
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';

          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "buffer";}
            {name = "path";}
          ];

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require('luasnip').expand_or_jumpable() then
                  require('luasnip').expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require('luasnip').jumpable(-1) then
                  require('luasnip').jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
          };

          window = {
            completion = {
              border = "rounded";
              winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
            };
            documentation = {
              border = "rounded";
            };
          };

          formatting = {
            fields = ["kind" "abbr" "menu"];
            format = ''
              function(entry, vim_item)
                local kind_icons = {
                  Text = "󰉿",
                  Method = "󰆧",
                  Function = "󰊕",
                  Constructor = "",
                  Field = "󰜢",
                  Variable = "󰀫",
                  Class = "󰠱",
                  Interface = "",
                  Module = "",
                  Property = "󰜢",
                  Unit = "󰑭",
                  Value = "󰎠",
                  Enum = "",
                  Keyword = "󰌋",
                  Snippet = "",
                  Color = "󰏆",
                  File = "󰈙",
                  Reference = "󰈇",
                  Folder = "󰉋",
                  EnumMember = "",
                  Constant = "󰏿",
                  Struct = "󰙅",
                  Event = "",
                  Operator = "󰆕",
                  TypeParameter = "",
                }
                vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                vim_item.menu = ({
                  nvim_lsp = "[LSP]",
                  luasnip = "[Snippet]",
                  buffer = "[Buffer]",
                  path = "[Path]",
                })[entry.source.name]
                return vim_item
              end
            '';
          };

          experimental = {
            ghost_text = true;
          };
        };
      };

      luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp_luasnip.enable = true;
    };
  };
}
