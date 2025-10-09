module Config.Style.Glow exposing
    ( glowDeepDarkGrey
    , glowDeepDarkGreyNavbar
    , glowDeepDarkOrange
    )

import Config.Style.Colour.Helpers exposing (ThemeColor(..), colourTheme, getThemeColor)
import Element exposing (Attr)
import Element.Border as D exposing (glow)


glowDeepDarkGrey : Attr decorative msg
glowDeepDarkGrey =
    D.glow (getThemeColor Shadow) 4


glowDeepDarkOrange : Attr decorative msg
glowDeepDarkOrange =
    D.glow (getThemeColor TextDeepDarkOrange) 4


glowDeepDarkGreyNavbar : Attr decorative msg
glowDeepDarkGreyNavbar =
    D.glow (getThemeColor Shadow) 10
