// Catppuccin Latte

#let catppuccinLatteRosewater = rgb("#dc8a78")
#let catppuccinLatteFlamingo = rgb("#dd7878")
#let catppuccinLattePink = rgb("#ea76cb")
#let catppuccinLatteMauve = rgb("#8839ef")
#let catppuccinLatteRed = rgb("#d20f39")
#let catppuccinLatteMaroon = rgb("#e64553")
#let catppuccinLattePeach = rgb("#fe640b")
#let catppuccinLatteYellow = rgb("#df8e1d")
#let catppuccinLatteGreen = rgb("#40a02b")
#let catppuccinLatteTeal = rgb("#179299")
#let catppuccinLatteSky = rgb("#04a5e5")
#let catppuccinLatteSapphire = rgb("#209fb5")
#let catppuccinLatteBlue = rgb("#1e66f5")
#let catppuccinLatteLavender = rgb("#7287fd")
#let catppuccinLatteText = rgb("#4c4f69")
#let catppuccinLatteSubtext1 = rgb("#5c5f77")
#let catppuccinLatteSubtext0 = rgb("#6c6f85")
#let catppuccinLatteOverlay2 = rgb("#7c7f93")
#let catppuccinLatteOverlay1 = rgb("#8c8fa1")
#let catppuccinLatteOverlay0 = rgb("#9ca0b0")
#let catppuccinLatteSurface2 = rgb("#acb0be")
#let catppuccinLatteSurface1 = rgb("#bcc0cc")
#let catppuccinLatteSurface0 = rgb("#ccd0da")
#let catppuccinLatteBase = rgb("#eff1f5")
#let catppuccinLatteMantle = rgb("#e6e9ef")
#let catppuccinLatteCrust = rgb("#dce0e8")

// General:

#let project(author: (:), title: (), body) = {
  show figure.caption: it => it.body

  set quote(attribution: "content", block: true)

  set document(author: author.firstName + " " + author.lastName, title: title)

  set text(fill: catppuccinLatteText, font: ("New Computer Modern"), lang: "en")

  let title = {
    align(center)[
      #block[
        #text(size: 25pt, weight: "medium")[#title]
      ]
    ]
  }

  let name = {
    align(
      center,
    )[
      #block[
        #text(size: 12pt, weight: "regular")[#author.firstName #author.lastName]
      ]
    ]
  }

  title
  name
  body
}

