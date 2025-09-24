{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  perSystem = {config, ...}: {
    treefmt = {
      programs = {
        alejandra.enable = true;
      };
      projectRootFile = "flake.nix";
    };
    formatter = config.treefmt.build.wrapper;
  };
}
