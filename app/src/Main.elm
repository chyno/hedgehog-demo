module Main exposing (main)


import Browser
import View exposing(headersView, Model, ActiveTab, Msg, initdata)
import Html.Events exposing (onInput, onClick)
import Html exposing (p,
 Html, Attribute,
 div, input, text, 
 h1, hr,br, img, h3, 
 strong, span, button)

import Html.Attributes exposing (..)





init : String ->  ( Model, Cmd Msg )
init  flag =  (initdata, Cmd.none)  



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
   case msg of
    DoLogout ->
        ({ model | activeTab = Login }, Cmd.none)
    DoLogIn ->
        ({ model | activeTab = LoggedIn }, Cmd.none)
    DoCreateAccount ->
        ({ model | activeTab = CreateAccount }, Cmd.none)
    
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

 


createAccountView: Model -> Html Msg
createAccountView model =
 div [][text "create account"]


            

signedInView : Model -> Html Msg
signedInView model = 
  div [ class "message" ]
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
            , div [ class "button", onClick DoLogout  ]
                [ text "Log Out"  ]
            ]

view : Model -> Html Msg
view model =
  div [ id "root" ]
      [ div [ class "app" ]
        [ 
            case model.activeTab of
                CreateAccount ->
                  headersView model
                Login  ->
                  headersView model
                LoggedIn -> 
                    signedInView model
                  ] 
      ]
      
main = 
  Browser.element
  { view = view
    , init = init
    , update = update
    , subscriptions = subscriptions
  }
