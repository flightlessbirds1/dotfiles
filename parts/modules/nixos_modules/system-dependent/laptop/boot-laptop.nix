{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      # AMD CPU power management
      "amd_pstate=active"
      # Better thermal management
      "processor.max_cstate=5"
      # Reduce power consumption
      "pcie_aspm=force"
      # Enable better CPU scheduler
      "sched_autogroup_enabled=1"
      # Memory management optimizations
      "transparent_hugepage=madvise"
      "vm.swappiness=10"
      # Avoid annoying USB suspend issues
      "usbcore.autosuspend=-1"
    ];
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      devices = [
        "nodev"
      ];
      efiSupport = true;
      configurationLimit = 10;

      gfxmodeEfi = "1024x768";
      fontSize = 24;
      extraConfig = ''
        acpi /ssdt-csc3551.aml
      '';
    };
  };
  systemd.services.unbind-elan = {
    description = "Unbind ELAN9008 i2c device";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-udev-settle.service" ];
    script = ''
      if [ -e /sys/bus/i2c/drivers/i2c_hid_acpi/i2c-ELAN9008:00 ]; then
        echo "i2c-ELAN9008:00" > /sys/bus/i2c/drivers/i2c_hid_acpi/unbind
      fi
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
