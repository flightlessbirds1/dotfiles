{pkgs, ...}: {
  # https://emulation.gametechwiki.com/index.php/Main_Page
  # Forks for retroarch tend to be behind
  home.packages =
    builtins.attrValues {
      inherit
        (pkgs)
        # Nintendo
        mesen # NES
        # ares # Accurate N64 - Supports many other systems: https://ares-emu.net/
        # simple64 # Easy to use N64
        # mgba # GBA
        # dolphin-emu # GameCube/Wii
        # melonDS # DS
        # cemu # WiiU
        # azahar # 3DS - unreleased: https://azahar-emu.org/
        # lime3ds # 3DS
        ryujinx-greemdev # Switch
        # suyu # Switch
        # Sony
        # duckstation # PS1
        # mednaffe # PS1
        # pcsx2 # PS2
        # rpcs3 # PS3
        # obliteration # PS4 - https://github.com/obhq/obliteration
        # shadps4 # PS4 - https://github.com/shadps4-emu/shadps4-game-compatibility/issues?q=sort%3Aupdated-desc+is%3Aopen+label%3Astatus-playable
        # rpcsx # PS4/PS5 - https://github.com/RPCSX/rpcsx
        # Microsoft
        # xemu # Xbox
        # xenia # X360 - https://github.com/xenia-project/xenia
        # windurango # XOne - https://github.com/WinDurango/WinDurango
        # XWine1 # XOne- https://x.com/XWineOne
        ;
    }
    ++ [
      (pkgs.retroarch.withCores (
        _cores:
          builtins.attrValues {
            inherit
              (pkgs.libretro)
              # Nintendo
              mesen # NES - Fork! Not Mesen2
              snes9x # SNES
              mupen64plus # N64 - Fork!
              mgba # GBA - Fork!
              dolphin # GameCube/Wii - Fork!
              melonds # DS - Fork!
              citra # 3DS - Fork!

              # Sony
              swanstation # PS1 - Fork!
              beetle-psx-hw # PS1 - Fork!
              pcsx2 # PS2 - Fork!
              ;
          }
      ))
    ];
}
