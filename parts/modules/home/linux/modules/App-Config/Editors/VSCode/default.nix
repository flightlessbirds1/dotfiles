{
  inputs,
  pkgs,
  config,
  ...
}:
let
  extensions = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        rust-lang.rust-analyzer
        bbenoist.nix
        haskell.haskell
        svelte.svelte-vscode
        golang.go
        reditorsupport.r
        extensions.open-vsx.leanprover.lean4
        extensions.open-vsx.rej.purplevoid
        extensions.open-vsx.myriad-dreamin.tinymist
      ];
      userSettings = {
        "workbench.colorTheme" = "Void";
        "window.titleBarStyle" = "custom";
        "window.customTitleBarVisibility" = "windowed";
        "window.enableMenuBarMnemonics" = false;
      };
    };
  };
}
