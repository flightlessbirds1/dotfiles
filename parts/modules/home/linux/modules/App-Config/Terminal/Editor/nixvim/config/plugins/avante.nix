{
  programs.nixvim.plugins.avante = {
    enable = true;
    settings = {
      providers.claude = {
        model = "claude-3-5-sonnet-latest";
      };
      # auto_suggestions_provider = "copilot";
    };
  };
}
