{
  lib,
  pkgs,
  username,
  ...
}: let
  powerModeSwitcher = pkgs.writeTextFile {
    name = "power-mode";
    executable = true;
    destination = "/bin/power-mode";
    text = ''
      #!${pkgs.nushell}/bin/nu

      def main [mode?: string] {
        if $mode == null {
          print "Usage: power-mode [performance|balanced|powersave|status]"
          print ""
          print "  performance  - Maximum performance, louder fans, high power"
          print "  balanced     - Middle ground, moderate performance"
          print "  powersave    - Battery saving, quiet fans, low power"
          print "  status       - Show current mode"
          return
        }

        match $mode {
          "performance" | "perf" => {
            print "🚀 Switching to PERFORMANCE mode..."

            (sudo ${pkgs.tlp}/bin/tlp setcharge 0 100 BAT0
              | complete | ignore)

            (echo "performance"
              | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
              | complete | ignore)

            (echo "performance"
              | sudo tee /sys/firmware/acpi/platform_profile
              | complete | ignore)

            sudo ${pkgs.tlp}/bin/tlp ac

            print "✓ Performance mode active - Maximum power!"
          }

          "balanced" | "balance" => {
            print "⚖️  Switching to BALANCED mode..."

            (sudo ${pkgs.tlp}/bin/tlp setcharge 80 95 BAT0
              | complete | ignore)

            (echo "balance_performance"
              | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
              | complete | ignore)

            (echo "balanced"
              | sudo tee /sys/firmware/acpi/platform_profile
              | complete | ignore)

            # Use actual power source
            sudo ${pkgs.tlp}/bin/tlp start

            print "✓ Balanced mode active - Good mix of performance and efficiency"
          }

          "powersave" | "save" | "quiet" => {
            print "🔋 Switching to POWER SAVING mode..."

            (sudo ${pkgs.tlp}/bin/tlp setcharge 85 90 BAT0
              | complete | ignore)

            (echo "power"
              | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
              | complete | ignore)

            (echo "quiet"
              | sudo tee /sys/firmware/acpi/platform_profile
              | complete | ignore)

            sudo ${pkgs.tlp}/bin/tlp bat

            print "✓ Power saving mode active - Quiet and efficient"
          }

          "status" => {
            print "\n📊 Current Power Status:\n"

            print "TLP Mode:"
            (sudo ${pkgs.tlp}/bin/tlp-stat -s
              | lines
              | find "Mode"
              | each { |line| print $"  ($line)" })

            print "\nPlatform Profile:"
            let profile = (open /sys/firmware/acpi/platform_profile
              | complete)
            if $profile.exit_code == 0 {
              print $"  ($profile.stdout | str trim)"
            } else {
              print "  Not available"
            }

            print "\nCPU Energy Preference:"
            let cpu_pref = (open /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
              | complete)
            if $cpu_pref.exit_code == 0 {
              print $"  ($cpu_pref.stdout | str trim)"
            }
          }

          _ => {
            print $"❌ Unknown mode: ($mode)"
            print "Valid modes: performance, balanced, powersave, status"
          }
        }
      }
    '';
  };
in {
  services.tlp = {
    enable = true;
    settings = {
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";

      CPU_BOOST_ON_BAT = 0;
      CPU_BOOST_ON_AC = 1;

      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;

      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";

      PCIE_ASPM_POLICY = "powersupersave";
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_ON_AC = "on";
      USB_AUTOSUSPEND = 1;

      WIFI_PWR_ON_BAT = "on";
      WIFI_PWR_ON_AC = "off";

      SATA_LINKPWR_ON_BAT = "min_power";
      SATA_LINKPWR_ON_AC = "max_performance";
      AHCI_RUNTIME_PM_ON_BAT = "auto";
      AHCI_RUNTIME_PM_ON_AC = "on";

      PLATFORM_PROFILE_ON_BAT = "quiet";
      PLATFORM_PROFILE_ON_AC = "balanced";
    };
  };

  environment.systemPackages = [
    powerModeSwitcher
  ];

  security.doas = {
    enable = true;
    extraRules = [
      {
        users = ["${username}"];
        noPass = true;
        cmd = "${pkgs.tlp}/bin/tlp";
      }
      {
        users = ["${username}"];
        noPass = true;
        cmd = "${pkgs.tlp}/bin/tlp-stat";
      }
      {
        users = ["${username}"];
        noPass = true;
        cmd = "/run/current-system/sw/bin/tee";
      }
    ];
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

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchDocked = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandlePowerKey = "suspend";
    HandleSuspendKey = "suspend";
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=3600
    SuspendState=mem
  '';
}
