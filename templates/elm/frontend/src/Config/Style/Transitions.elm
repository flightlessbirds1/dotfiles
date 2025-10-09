module Config.Style.Transitions exposing (..)

import Config.Style.Colour.Helpers exposing (colourTheme)
import Config.Style.Glow
    exposing
        ( glowDeepDarkGrey
        , glowDeepDarkOrange
        )
import Element
    exposing
        ( Attribute
        , htmlAttribute
        , mouseOver
        )
import Element.Background as B exposing (color)
import Element.Border as D exposing (color)
import Element.Font as F exposing (color)
import Html.Attributes as H exposing (style)


transitionStyleSlow : Attribute msg
transitionStyleSlow =
    htmlAttribute <| style "transition" "all 0.4s ease-in-out"


transitionStyleMedium : Attribute msg
transitionStyleMedium =
    htmlAttribute <| style "transition" "all 0.2s ease-in-out"


transitionStyleFast : Attribute msg
transitionStyleFast =
    htmlAttribute <| style "transition" "all 0.1s ease-in-out"


specialNavbarTransition : Attribute msg
specialNavbarTransition =
    htmlAttribute <| style "transition" "opacity .4s"



-- This special transition is needed to avoid weird animation sequencing rather in Chrome-based browsers.


hoverFontLightOrange : Attribute msg
hoverFontLightOrange =
    mouseOver [ F.color colourTheme.textLightOrange ]


hoverFontDarkOrange : Attribute msg
hoverFontDarkOrange =
    mouseOver [ F.color colourTheme.textDarkOrange ]


hoverCircleButtonDarkOrange : Attribute msg
hoverCircleButtonDarkOrange =
    mouseOver
        [ D.color colourTheme.textDarkOrange
        , B.color colourTheme.textDarkOrange
        , glowDeepDarkOrange
        ]


hoverPageButtonDeepDarkOrange : Attribute msg
hoverPageButtonDeepDarkOrange =
    mouseOver
        [ B.color colourTheme.textDeepDarkOrange
        , F.color colourTheme.textLightOrange
        ]
