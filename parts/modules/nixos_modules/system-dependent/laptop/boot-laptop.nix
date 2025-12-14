{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
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
}
