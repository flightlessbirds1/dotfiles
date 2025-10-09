module Config.Style.Fonts exposing
    ( defaultFontSize
    , headerFontSizeBig
    , headerFontSizeMedium
    , paragraphSpacing
    , smallTextFontSize
    , spartanFont
    )

import Element
    exposing
        ( Attr
        , Attribute
        , spacing
        )
import Element.Font as F
    exposing
        ( size
        , typeface
        )


spartanFont : F.Font
spartanFont =
    F.typeface "League Spartan"


paragraphSpacing : Attribute msg
paragraphSpacing =
    spacing 0


headerFontSizeBig : Attr decorative msg
headerFontSizeBig =
    F.size 23


headerFontSizeMedium : Attr decorative msg
headerFontSizeMedium =
    F.size 20


defaultFontSize : Attr decorative msg
defaultFontSize =
    F.size 18


smallTextFontSize : Attr decorative msg
smallTextFontSize =
    F.size 16
