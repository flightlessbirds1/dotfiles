{
  programs.nixvim = {
    plugins = {
      gitsigns.enable = true;
    };

    initLua = ''
      -- ── Gitsigns Setup ────────────────────────────────────────────────────
      require('gitsigns').setup({})
    '';
  };
}
