{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { config, ... }:
    {
      treefmt = {
        programs = {
          nixfmt.enable = true;
        };
        projectRootFile = "flake.nix";
      };
      formatter = config.treefmt.build.wrapper;
    };
}
