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
    ];
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      configurationLimit = 10;
      extraConfig = "
acpi /ssdt-csc3551.aml
";
    };
  };
}
