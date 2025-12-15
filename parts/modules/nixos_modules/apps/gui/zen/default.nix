{
  pkgs,
  inputs,
  system,
  ...
}:
{
  environment.systemPackages = builtins.attrValues {
    zen-browser = inputs.zen-browser.packages."${system}".default;
  };
}
