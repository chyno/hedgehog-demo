module Main exposing (main)
import Browser
import Html exposing (p,
 Html, Attribute,
 div, input, text, 
 h1, hr,br, img, h3, 
 strong, span, button)

import Html.Attributes exposing (..)


type alias Model =
  {
    message: String
  }

initdata : Model
initdata = 
    { 
      message = "Looged in"
      
    }

init : String ->  ( Model, Cmd Msg )
init  flag =  (initdata, Cmd.none)  

type Msg
    = Noop

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

signedInView : Model -> Html Msg
signedInView model = 
  div [ id "root" ]
    [ div [ class "app" ]
        [ div [ class "message" ]
            [ div [ class "pill green" ]
                [ text "authenticated" ]
            , h1 []
                [ text "You're Signed In!" ]
            , p []
                [ text "You just created an account using Hedgehog! Now, if you log out you will be able to sign back in with the same credentials." ]
            , p []
                [ text "Your wallet address is:" ]
            , p [ class "address" ]
                [ text "0x3cce80e16f4d5634b237f5c1c338864af4d73674" ]
            , div [ class "button" ]
                [ text "Log Out" ]
            ]
        ]
    ]

view : Model -> Html Msg
view model =
  signedInView model

main = 
  Browser.element
  { view = view
    , init = init
    , update = update
    , subscriptions = subscriptions
  }
