{inputs, system, ...}: {
  home.packages = [
    inputs.rofi-tools.packages.${system}.default
  ];
}
