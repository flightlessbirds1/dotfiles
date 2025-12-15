{ hostname, ... }:
{
  imports = [
    (import ./aliases/aliases.nix "fish" hostname)
    (import ./aliases/aliases.nix "nushell" hostname)
  ];
}
