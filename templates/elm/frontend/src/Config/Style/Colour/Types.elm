module Config.Style.Colour.Types exposing
    ( SyntaxColors
    , Theme
    )

import Element exposing (Color)


type alias Theme =
    { textLightGrey : Color
    , textDarkGrey : Color
    , textLightOrange : Color
    , textDarkOrange : Color
    , textDeepDarkOrange : Color
    , backgroundLightGrey : Color
    , backgroundDarkGrey : Color
    , backgroundDeepDarkGrey : Color
    , backgroundSpreadsheet : Color
    , backgroundSpreadsheetDark : Color
    , shadow : Color
    , barGreen : Color
    , barRed : Color
    , debugColour : Color
    , transparent : Color
    }


type alias SyntaxColors =
    { punctuation : Color
    , key : Color
    , string : Color
    , keyword : Color
    , operator : Color
    , background : Color
    , text : Color
    }
