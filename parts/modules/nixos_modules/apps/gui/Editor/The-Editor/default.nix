{
  inputs,
  system,
  ...
}: {
  environment.systemPackages = [
    inputs.the-editor.packages.${system}.default
  ];
}
