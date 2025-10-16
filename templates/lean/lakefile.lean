import Lake
open Lake DSL

package «example» where
  -- add package configuration options here

lean_lib «Example» where
  require "leanprover-community" / "mathlib" @ "git#308445d7985027f538e281e18df29ca16ede2ba3"
  -- add library configuration options here
  --

@[default_target]
lean_exe «testing» where
  root := `Main
  -- Enables the use of the Lean interpreter by the executable (e.g.,
  -- `runFrontend`) at the expense of increased binary size on Linux.
  -- Remove this line if you do not need such functionality.
  supportInterpreter := true
