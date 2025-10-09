{
  pkgs,
  config,
  ...
}: {
  devShells = {
    default = pkgs.mkShell {
      packages = builtins.attrValues {
        inherit
          (pkgs)
          just
          nil
          typst
          tinymist
          typstyle
          yamlfmt
          nixfmt-rfc-style
          ;
        # inherit (pkgs.nodePackages)
        #   "@commitlint/config-conventional"
        #   ;
      };
    };
    shellHook = "${config.pre-commit.installationScript}";
  };
}
