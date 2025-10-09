module Config.Style.Icons.Types exposing
    ( InnerPart
    , OuterPart
    )

{-| The types used for SVG management.
-}

import Element exposing (Attribute)
import Shared exposing (Model)
import Svg exposing (svg)


{-| The outer record for the SVG builder. This is explained in ../Helpers/Svg.elm.
-}
type alias OuterPart msg =
    { elementAttributes : List (Element.Attribute msg)
    , sharedModel : Shared.Model
    , svgAttributes : List (Svg.Attribute msg)
    }


{-| The inner record for the SVG builder. This is explained in ../Helpers/Svg.elm.
-}
type alias InnerPart msg =
    { svgAttributes : List (Svg.Attribute msg)
    , svg : List (Svg.Svg msg)
    }
