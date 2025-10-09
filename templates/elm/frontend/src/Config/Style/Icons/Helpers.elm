module Config.Style.Icons.Helpers exposing (buildSvg)

import Config.Style.Icons.Types as SvgTypes
    exposing
        ( InnerPart
        , OuterPart
        )
import Element as E
    exposing
        ( Element
        , el
        , html
        )
import Svg exposing (svg)



{- buildSvg consumes an inner record to construct most of an SVG, and an outer record to supply
   any potentially varying TypedSvg.Core.Attribute msgs and wrap it in an Element.el so it can be
   used by elm-ui. It provides a consistent interface for inserting SVGs into elm-ui code.
-}


buildSvg : SvgTypes.OuterPart msg -> SvgTypes.InnerPart msg -> Element msg
buildSvg outer inner =
    el
        outer.elementAttributes
    <|
        html <|
            Svg.svg
                (outer.svgAttributes ++ inner.svgAttributes)
                inner.svg
