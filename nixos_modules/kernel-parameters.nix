{...}: {
  boot.kernelParams = [
    "amdgpu.dc=1"
    "amdgpu.gpu_recovery=1"
    "intel_pstate=active"
    "intel_idle.max_cstate=2"
    "mitigations=off"
    "transparent_hugepage=madvise"
    "quiet"
    "loglevel=3"
    "usbcore.autosuspend=-1"
  ];
}
