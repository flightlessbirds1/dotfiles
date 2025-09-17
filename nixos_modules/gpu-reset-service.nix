{pkgs, ...}: {
  systemd.services.gpu-reset = {
    description = "Reset AMD GPU before shutdown";
    before = ["shutdown.target" "reboot.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 1 > /sys/kernel/debug/dri/0/amdgpu_gpu_recovery || true'";
    };
    wantedBy = ["shutdown.target" "reboot.target"];
  };
}
