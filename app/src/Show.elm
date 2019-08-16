module  Show exposing(..)

import Model exposing (..)
import Browser
import Html.Events exposing (onInput, onClick)
import Html exposing (p,
 Html, Attribute,
 div, input, text, 
 h1, hr,br, img, h3, 
 strong, span, button)
import Html.Attributes exposing (..)
import Json.Encode as E

showsView : Model -> Html Msg
showsView model = 
  div [ class "message" ]
            [ div [ class "pill green" ]
                [ text "authenticated" ]
            , h1 []
                [ text "These are your shows" ]
            ]
