{pkgs, ...}: {
  services = {
    ollama = {
      enable = true;
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    ctranslate2 = pkgs.ctranslate2.overrideAttrs (oldAttrs: {
      cmakeFlags =
        (oldAttrs.cmakeFlags or [])
        ++ [
          "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
        ];

      preConfigure =
        (oldAttrs.preConfigure or "")
        + ''
          # Fix cmake version in third_party/cpu_features if it exists
          if [ -f third_party/cpu_features/CMakeLists.txt ]; then
            sed -i 's/cmake_minimum_required(VERSION [0-9.]*)/cmake_minimum_required(VERSION 3.5)/' third_party/cpu_features/CMakeLists.txt
          fi
        '';
    });
  };

  services.open-webui.enable = true;
}
