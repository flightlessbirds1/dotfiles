{pkgs, ...}: {
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      groups = [
        "wheel"
      ];
      keepEnv = true;
      persist = true; # Optional, only require password verification a single time
    }
  ];

  environment.systemPackages = with pkgs; [
    doas-sudo-shim
  ];
}
