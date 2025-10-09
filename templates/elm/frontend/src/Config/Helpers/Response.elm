module Config.Helpers.Response exposing
    ( contentContainer
    , pageList
    , pageListCenter
    , pageListFormat
    , topLevelContainer
    )

import Config.Style.Colour.Helpers exposing (colourTheme)
import Element as E
    exposing
        ( Attribute
        , Device
        , DeviceClass(..)
        , Element
        , Orientation(..)
        , alignTop
        , centerX
        , centerY
        , el
        , fill
        , height
        , maximum
        , minimum
        , padding
        , paddingXY
        , scrollbarY
        , spacing
        , width
        )
import Element.Background as B exposing (color)
import Html.Attributes exposing (style)


topLevelContainer : Element msg -> Element msg
topLevelContainer =
    el
        [ width fill
        , height fill
        , B.color colourTheme.backgroundLightGrey
        ]


pageListCenter : Device -> List (Attribute msg)
pageListCenter device =
    [ centerY
    ]
        ++ pageListFormat device


pageList : Device -> List (Attribute msg)
pageList device =
    [ alignTop
    ]
        ++ pageListFormat device


pageListFormat : Device -> List (Attribute msg)
pageListFormat device =
    let
        pageListAttr =
            [ centerX
            , width fill
            , height fill
            , scrollbarY
            ]
    in
    pageListAttr
        ++ (case ( device.class, device.orientation ) of
                ( Phone, Portrait ) ->
                    [ spacing 0
                    , paddingXY 10 30
                    ]

                ( Tablet, Portrait ) ->
                    [ spacing 0
                    , paddingXY 10 30
                    ]

                _ ->
                    [ spacing 20
                    , paddingXY 30 30
                    ]
           )


contentContainer : Element msg -> Element msg
contentContainer =
    el
        [ width (fill |> minimum 100)
        , width (fill |> maximum 875)
        , padding 10
        , centerX
        ]
