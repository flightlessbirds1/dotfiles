{pkgs, ...}: {
  services = {
    ollama = {
      enable = true;
      acceleration = "rocm";
      rocmOverrideGfx = "10.3.0";
    };
  };
  services.open-webui.enable = true;
}
