{
  flake.checker = import ./System-Checker.nix;
  flake.dependent-checker = import ./System-dependent-checker.nix;
}
