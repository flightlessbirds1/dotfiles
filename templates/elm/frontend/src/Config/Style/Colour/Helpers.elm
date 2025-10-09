module Config.Style.Colour.Helpers exposing
    ( ThemeColor(..)
    , colourTheme
    , getThemeColor
    , syntaxTheme
    )

import Config.Style.Colour.Types
    exposing
        ( SyntaxColors
        , Theme
        )
import Element as E
    exposing
        ( Color
        , rgb255
        , rgba
        )
import Element.Font as F exposing (color)


colourTheme : Theme
colourTheme =
    { textLightGrey = rgb255 212 212 212
    , textDarkGrey = rgb255 126 126 126
    , textLightOrange = rgb255 204 102 0
    , textDarkOrange = rgb255 120 60 0
    , textDeepDarkOrange = rgb255 60 30 0
    , backgroundLightGrey = rgb255 40 40 40
    , backgroundDarkGrey = rgb255 30 30 30
    , backgroundDeepDarkGrey = rgb255 20 20 20
    , backgroundSpreadsheet = rgb255 36 36 36
    , backgroundSpreadsheetDark = rgb255 26 26 26
    , shadow = rgb255 10 10 10
    , barGreen = rgb255 0 102 0
    , barRed = rgb255 102 0 0
    , debugColour = rgb255 227 28 121
    , transparent = rgba 1 1 1 0
    }


syntaxTheme : SyntaxColors
syntaxTheme =
    { punctuation = rgb255 202 158 230
    , key = rgb255 138 173 244
    , string = rgb255 166 218 149
    , keyword = rgb255 245 169 127
    , operator = rgb255 178 185 194
    , background = rgb255 36 39 58
    , text = rgb255 202 211 245
    }


type ThemeColor
    = TextLightGrey
    | TextDarkGrey
    | TextLightOrange
    | TextDarkOrange
    | TextDeepDarkOrange
    | BackgroundLightGrey
    | BackgroundDarkGrey
    | BackgroundDeepDarkGrey
    | BackgroundSpreadsheet
    | BackgroundSpreadsheetDark
    | Shadow
    | BarGreen
    | BarRed
    | DebugColour
    | Transparent


getThemeColor : ThemeColor -> Color
getThemeColor color =
    case color of
        TextLightGrey ->
            colourTheme.textLightGrey

        TextDarkGrey ->
            colourTheme.textDarkGrey

        TextLightOrange ->
            colourTheme.textLightOrange

        TextDarkOrange ->
            colourTheme.textDarkOrange

        TextDeepDarkOrange ->
            colourTheme.textDeepDarkOrange

        BackgroundLightGrey ->
            colourTheme.backgroundLightGrey

        BackgroundDarkGrey ->
            colourTheme.backgroundDarkGrey

        BackgroundDeepDarkGrey ->
            colourTheme.backgroundDeepDarkGrey

        BackgroundSpreadsheet ->
            colourTheme.backgroundSpreadsheet

        BackgroundSpreadsheetDark ->
            colourTheme.backgroundSpreadsheetDark

        Shadow ->
            colourTheme.shadow

        BarGreen ->
            colourTheme.barGreen

        BarRed ->
            colourTheme.barRed

        DebugColour ->
            colourTheme.debugColour

        Transparent ->
            colourTheme.transparent
