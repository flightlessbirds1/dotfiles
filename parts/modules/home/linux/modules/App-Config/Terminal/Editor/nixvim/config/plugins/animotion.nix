{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "AniMotion";
        src = pkgs.fetchFromGitHub {
          owner = "luiscassih";
          repo = "AniMotion.nvim";
          rev = "92504a0f2c6c3e2245cef71668e7badf8052eb03";
          hash = "sha256-Ro+Nic4v2oR60p/rE3vm0iDCNU+EtkSKAiTHkp19WB8=";
        };
      })
    ];
    extraConfigLua = ''
      require("AniMotion").setup({
        mode = "animotion",
        clear_keys = { "<C-c>" },
        color = "Visual",
        map_visual = true,
      })
    '';
  };
}
