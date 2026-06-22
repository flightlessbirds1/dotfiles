{
  services = {
    displayManager = {
      sddm = {
        enable = true;
        enableHidpi = true;
        wayland = {
          enable = true;
        };
      };
    };
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
  };

  programs = {
    kdeconnect.enable = true;
    dconf.enable = true;
  };
}
