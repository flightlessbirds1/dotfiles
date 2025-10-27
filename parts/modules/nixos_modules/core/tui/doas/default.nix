{pkgs, ...}: {
  # security.doas.enable = true;
  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults timestamp_timeout=-1
      Defaults timestamp_type=global
    '';
  };

  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      sudo
      ;
  };
}
