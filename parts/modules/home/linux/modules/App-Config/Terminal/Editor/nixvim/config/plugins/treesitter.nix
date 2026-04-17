{ pkgs, ... }:
{
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
      bash
      python
      javascript
      typescript
      tsx
      rust
      c
      go
      java
      haskell
      elm
      typst
      html
      css
      json
      yaml
      toml
      lua
      regex
    ];
  };
}
