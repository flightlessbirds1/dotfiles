_: {
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
    consoleMode = "auto";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [
    "i2c-dev"
  ];
}
