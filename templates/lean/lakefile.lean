import Lake
open Lake DSL

package «example» where
  -- add package configuration options here

lean_lib «Example» where
  require "leanprover-community" / "mathlib" @ "git#f897ebcf72cd16f89ab4577d0c826cd14afaafc7"
  -- add library configuration options here
  --

@[default_target]
lean_exe «testing» where
  root := `Main
  -- Enables the use of the Lean interpreter by the executable (e.g.,
  -- `runFrontend`) at the expense of increased binary size on Linux.
  -- Remove this line if you do not need such functionality.
  supportInterpreter := true
