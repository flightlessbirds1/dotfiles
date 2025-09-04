{lib, ...}: {
  services.tlp = {
    enable = true;
    settings = {
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "power";

      # Kill turbo on battery; allow on AC
      CPU_BOOST_ON_BAT = 0;
      CPU_BOOST_ON_AC = 0;

      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 80;

      # PCIe ASPM + runtime PM = big wins with minimal downsides
      PCIE_ASPM_POLICY = "powersupersave";
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_ON_AC = "auto";
      USB_AUTOSUSPEND = 1;
      # Wi-Fi PM helps a bit on battery
      WIFI_PWR_ON_BAT = "on";
      WIFI_PWR_ON_AC = "off";
      SATA_LINKPWR_ON_BAT = "min_power";
      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      AHCI_RUNTIME_PM_ON_BAT = "auto";
      AHCI_RUNTIME_PM_ON_AC = "auto";
      PLATFORM_PROFILE_ON_BAT = "quiet";
      PLATFORM_PROFILE_ON_AC = "quiet";
    };
  };

  services.power-profiles-daemon.enable = lib.mkForce false;

  services.thermald.enable = false;

  boot.kernelParams = [
    "amd_pstate=active"
  ];

  powerManagement = {
    enable = true;
    powertop.enable = false;
  };

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "suspend";
    lidSwitchExternalPower = "suspend";
    powerKey = "suspend";
    suspendKey = "suspend";
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=3600
    SuspendState=mem
  '';
}
