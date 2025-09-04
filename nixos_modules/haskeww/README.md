# Haskeww

## 🧭 Purpose

[Niri](https://github.com/YaLTeR/niri?tab=readme-ov-file) doesn't provide a bar by default, and I like having a lot customization power, so I build my own bar with [EWW](https://github.com/elkowar/eww):

![bar](../../../assets/bar.png)

Haskeww is a set of Haskell scripts for powering my EWW bar:

- `lockScreen`
- `manageBattery`
- `manageGPU`
- `manageTime`
- `manageWeather`
- `manageWorkspaces`
- `mySuspend`
- `updatePowerMenuState`

## 🏗️ Development

To develop Haskeww, `cd` to this directory on a system with [Nix](https://nixos.org/) and [direnv](https://direnv.net/) installed. Then if you haven't already developed the project, run `direnv allow`. You only need to allow direnv once, after that it will load the Nix devshell automatically when you enter the directory. The devshell is a local development environment which provides all tooling necessary for working on the project. Development can be done with `cabal` as usual. Since there are multiple scripts to open a REPL for a particular one use `cabal repl exe:<exeName>`, and to run a specific one use `cabal run exe:<exeName>`.
