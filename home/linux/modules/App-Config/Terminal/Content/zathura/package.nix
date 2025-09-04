{pkgs, ...}:
pkgs.zathura.override (prev: {
  zathura_core = prev.zathura_core.overrideAttrs {
    patches = [
      ./no-titlebar.patch
    ];
  };
})
