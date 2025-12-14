{
  pkgs,
  lib,
  config,
  ...
}:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      addons = builtins.attrValues {
        inherit (pkgs)
          fcitx5-rime
          fcitx5-gtk
          ;
      };
      settings = import ./settings.nix { };
      quickPhrase = {
        # Greek lowercase
        "alpha" = "α";
        "beta" = "β";
        "gamma" = "γ";
        "delta" = "δ";
        "epsilon" = "ε";
        "zeta" = "ζ";
        "eta" = "η";
        "theta" = "θ";
        "iota" = "ι";
        "kappa" = "κ";
        "lambda" = "λ";
        "mu" = "μ";
        "nu" = "ν";
        "xi" = "ξ";
        "omicron" = "ο";
        "pi" = "π";
        "rho" = "ρ";
        "sigma" = "σ";
        "tau" = "τ";
        "upsilon" = "υ";
        "phi" = "φ";
        "chi" = "χ";
        "psi" = "ψ";
        "omega" = "ω";

        # Greek uppercase
        "Alpha" = "Α";
        "Beta" = "Β";
        "Gamma" = "Γ";
        "Delta" = "Δ";
        "Epsilon" = "Ε";
        "Zeta" = "Ζ";
        "Eta" = "Η";
        "Theta" = "Θ";
        "Iota" = "Ι";
        "Kappa" = "Κ";
        "Lambda" = "Λ";
        "Mu" = "Μ";
        "Nu" = "Ν";
        "Xi" = "Ξ";
        "Omicron" = "Ο";
        "Pi" = "Π";
        "Rho" = "Ρ";
        "Sigma" = "Σ";
        "Tau" = "Τ";
        "Upsilon" = "Υ";
        "Phi" = "Φ";
        "Chi" = "Χ";
        "Psi" = "Ψ";
        "Omega" = "Ω";

        # Logic symbols
        "not" = "¬";
        "and" = "∧";
        "or" = "∨";
        "impl" = "→";
        "biimpl" = "↔";
        "xor" = "⊕";
        "forall" = "∀";
        "exists" = "∃";
        "entails" = "⊨";
        "notentails" = "⊭";
        "proves" = "⊢";
        "notproves" = "⊬";
        "therefore" = "∴";
        "because" = "∵";
        "eqdef" = "≝";
        "definedas" = "≔";
        "equiv" = "≡";
        "neq" = "≠";
        "lt" = "＜";
        "gt" = "＞";
        "leq" = "≤";
        "geq" = "≥";
        "in" = "∈";
        "notin" = "∉";
        "subset" = "⊂";
        "superset" = "⊃";
        "subseteq" = "⊆";
        "superseteq" = "⊇";
        "union" = "∪";
        "intersect" = "∩";
        "emptyset" = "∅";
        "nabla" = "∇";
        "partial" = "∂";
        "infty" = "∞";

        # Modal logic
        "possibly" = "◇";
        "necessarily" = "□";

        # Misc math
        "angle" = "∠";
        "perp" = "⊥";
        "parallel" = "∥";
        "approx" = "≈";
        "propto" = "∝";
        "cdot" = "⋅";
        "times" = "×";
        "div" = "÷";
        "pm" = "±";
        "mp" = "∓";
        "sqrt" = "√";
        "cbrt" = "∛";
        "fourthrt" = "∜";

        # Arrows
        "larr" = "←";
        "rarr" = "→";
        "uarr" = "↑";
        "darr" = "↓";
        "harr" = "↔";
        "iff" = "⇔";
        "implies" = "⇒";
        "leftRightArrow" = "⇄";

        # Misc symbols
        "degree" = "°";
        "ell" = "ℓ";
        "Re" = "ℜ";
        "Im" = "ℑ";
        "aleph" = "ℵ";
        "hbar" = "ℏ";
        "wp" = "℘";

        # Chemistry-specific
        "rightarrow" = "→";
        "leftrightarrow" = "⇌";
        "equilibrium" = "⇌";
        "reaction" = "→";
        "doublearrow" = "⇋";
        "revreaction" = "⟷";
        "heat" = "Δ";
        "precipitate" = "↓";
        "gas" = "↑";
        "dot" = "·"; # For hydrates
        "angstrom" = "Å";
        "plusminus" = "±";
        "radical" = "√";

        # Arrows for mechanisms
        "hookright" = "↪";
        "hookleft" = "↩";
        "curvedarrow" = "⤸";
        "dblharpoon" = "⇌";
        "harpoonright" = "⇀";
        "harpoonleft" = "↽";
        "fishhook" = "⥤"; # electron pushing

        # Bonds (approximate)
        "singlebond" = "─";
        "doublebond" = "═";
        "triplebond" = "≡";
        "rightdash" = "╌";
        "leftdash" = "╍";

        # Charges
        "plus" = "⁺";
        "minus" = "⁻";
        "2plus" = "²⁺";
        "2minus" = "²⁻";
        "3plus" = "³⁺";
        "3minus" = "³⁻";

        # State symbols
        "s" = "(s)";
        "l" = "(l)";
        "g" = "(g)";
        "aq" = "(aq)";

        # Constants and units
        "Na" = "Nₐ"; # Avogadro's number
        "kB" = "kᴮ"; # Boltzmann constant
        "Rconst" = "ℛ"; # Universal gas constant
        "mol" = "mol";
        "M" = "mol/L"; # Molarity
        "ppm" = "ppm";
        "ppb" = "ppb";

        # Isotopes (examples)
        "C13" = "¹³C";
        "H2" = "²H";
        "O18" = "¹⁸O";
        "U235" = "²³⁵U";

        # Misc
        "e-" = "e⁻";
        "p+" = "p⁺";
        "n0" = "n⁰";
        "dotdot" = "⁑"; # Lone pair symbol (unofficial)
        "emdash" = "—";
        "endash" = "–";
      };
    };
  };
}
