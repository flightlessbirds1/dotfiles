{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  options.specializations.compiling = {
    enable = lib.mkEnableOption "Enable compiling specialization with performance kernel";
  };

  config = lib.mkIf config.specializations.compiling.enable {
    specialisation.compiling = {
      inheritParentConfig = true;

      configuration = {
        boot.kernelPackages = pkgs.linuxPackages_zen;

        boot.kernelParams = [
          "mitigations=off"
          "nowatchdog"
          "transparent_hugepage=always"
        ];

        boot.kernel.sysctl = {
          "vm.swappiness" = 1;
          "kernel.nmi_watchdog" = 0;
          "fs.inotify.max_user_watches" = 524288;
          "fs.file-max" = 2097152;
        };

        environment.systemPackages = with pkgs; [
          ccache
          distcc
          sccache
          clang
          llvm
          lld
          mold
          cmake
          ninja
          pkg-config
          git-lfs
        ];

        programs.ccache.enable = true;

        nix.settings = {
          max-jobs = lib.mkForce "auto";
          cores = lib.mkForce 0;
          sandbox = true;
          auto-optimise-store = true;
          builders-use-substitutes = true;
        };

        systemd.services.nix-daemon.serviceConfig = {
          LimitNOFILE = lib.mkForce 1048576;
        };

        boot.tmp.useTmpfs = true;
        boot.tmp.tmpfsSize = "50%";

        zramSwap.memoryPercent = lib.mkForce 50;

        environment.variables = {
          MAKEFLAGS = "-j$NIX_BUILD_CORES";
          CARGO_BUILD_JOBS = "$NIX_BUILD_CORES";
        };
      };
    };
  };
}
