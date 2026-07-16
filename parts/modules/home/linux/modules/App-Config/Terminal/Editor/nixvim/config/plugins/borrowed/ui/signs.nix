{
  programs.nixvim = {
    plugins = {
      gitsigns.enable = true;
    };

    extraConfigLua = ''
      -- ── Gitsigns Setup ────────────────────────────────────────────────────
      require('gitsigns').setup({})
    '';
  };
}
