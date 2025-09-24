_: {
  boot.kernelParams = [
    "amdgpu.runpm=0"
    "amdgpu.dc=1"
    # "amdgpu.gpu_recovery=0"
    # "amdgpu.dpm=0"
  ];
  boot.blacklistedKernelModules = ["iTCO_wdt"];
}
