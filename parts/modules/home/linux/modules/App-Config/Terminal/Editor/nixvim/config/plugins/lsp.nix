{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      elmls.enable = true;
      hls = {
        enable = true;
        installGhc = false;
      };
      nixd.enable = true;
      nushell.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
      tinymist.enable = true;
      leanls.enable = true;
      vale_ls = {
        enable = true;
        filetypes = [
          "markdown"
          "text"
          "typst"
        ];
      };
    };
  };
}
