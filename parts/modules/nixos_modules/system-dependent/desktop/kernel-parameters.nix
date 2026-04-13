{
  boot.kernelParams = [
    "amdgpu.runpm=0"
    "amdgpu.dc=1"
    "preempt=full"
    # "amdgpu.gpu_recovery=0"
    # "amdgpu.dpm=0"
    "usbcore.autosuspend=-1"
  ];
  boot.blacklistedKernelModules = [ "iTCO_wdt" ];
}
