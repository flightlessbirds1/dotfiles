{
  pkgs,
  config,
  ...
}: {
  haskellProjects.default = {
    devShell = {
      enable = true;

      tools = hp: {
        inherit
          (hp)
          cabal-fmt
          haskell-language-server
          ;

        inherit
          (pkgs)
          dhall
          dhall-json
          dhall-lsp-server
          helix-gpt
          age
          just
          nil
          nixd
          sops
          ssh-to-age
          nixfmt-rfc-style
          libz
          ngrep
          stripe-cli
          vscode-langservers-extracted
          zlib
          ;

        inherit
          (pkgs.haskellPackages)
          nixfmt
          ;
      };

      hlsCheck.enable = true;
      mkShellArgs.shellHook = "${config.pre-commit.installationScript}";
    };
  };
}
