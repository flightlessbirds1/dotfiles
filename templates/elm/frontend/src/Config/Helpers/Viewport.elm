module Config.Helpers.Viewport exposing
    ( Msg
    , resetViewport
    )

import Browser.Dom as Dom exposing (setViewport)
import Task exposing (attempt)


type Msg
    = NoOp


resetViewport : Cmd Msg
resetViewport =
    Task.attempt (\_ -> NoOp) (Dom.setViewportOf "scroll-container" 0 0)
