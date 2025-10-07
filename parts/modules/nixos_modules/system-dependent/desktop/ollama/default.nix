{pkgs, ...}: {
  services = {
    ollama = {
      enable = true;
      acceleration = "rocm";
      rocmOverrideGfx = "10.3.0";
    };
  };

  systemd.services.ollama.environment = {
    HSA_OVERRIDE_GFX_VERSION = "10.3.0";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      rocmPackages.clr
      rocmPackages.rocm-runtime
    ];
  };

  services.open-webui.enable = true;
}
