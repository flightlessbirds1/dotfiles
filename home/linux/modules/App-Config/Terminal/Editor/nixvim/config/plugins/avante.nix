{
  programs.nixvim.plugins.avante = {
    enable = true;
    settings = {
      claude = {
        model = "claude-3-5-sonnet-latest";
      };
    };
  };
}
