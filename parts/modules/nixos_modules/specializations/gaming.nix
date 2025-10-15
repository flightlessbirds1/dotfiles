{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  options.specializations.gaming = {
    enable = lib.mkEnableOption "Enable gaming specialization with optimized kernel and wine";
  };

  config = lib.mkIf config.specializations.gaming.enable {
    specialisation.gaming = {
      inheritParentConfig = true;

      configuration = {
        boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

        boot.kernelParams = [
          "split_lock_detect=off"
          "preempt=full"
        ];

        boot.kernel.sysctl = {
          "vm.max_map_count" = 2147483642;
          "vm.swappiness" = 10;
          "kernel.sched_autogroup_enabled" = 0;
          "kernel.sched_child_runs_first" = 1;
        };

        environment.systemPackages = with pkgs; [
          wine-staging
          wine64
          winetricks
          dxvk
          vkd3d
          vkd3d-proton
          gamemode
          gamescope
          mangohud
          goverlay
          protonup-qt
          lutris
          heroic
          bottles
          protontricks
        ];

        programs.gamemode = {
          enable = true;
          settings = {
            general = {
              renice = 10;
              ioprio = 0;
            };
            gpu = {
              apply_gpu_optimisations = "accept-responsibility";
              gpu_device = 0;
              amd_performance_level = "high";
            };
          };
        };

        programs.steam = {
          gamescopeSession.enable = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };

        services.ratbagd.enable = true;

        systemd.settings.Manager = {
          DefaultCPUAccounting = "yes";
          DefaultIOAccounting = "yes";
          DefaultMemoryAccounting = "yes";
        };

        environment.sessionVariables = {
          AMD_VULKAN_ICD = "RADV";
          VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
        };
      };
    };
  };
}
