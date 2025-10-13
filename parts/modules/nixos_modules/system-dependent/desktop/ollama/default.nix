{
  inputs,
  pkgs,
  ...
}: {
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    package = inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.ollama;
  };
  systemd.services.ollama.environment = {
    HSA_OVERRIDE_GFX_VERSION = "10.3.0";
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with inputs.nixpkgs-stable.legacyPackages.${pkgs.system}.rocmPackages; [
      clr.icd
      clr
      rocm-runtime
    ];
  };
  services.open-webui.enable = true;
}
