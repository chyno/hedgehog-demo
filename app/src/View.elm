module View exposing (headersView, Msg, Model, ActiveTab, initdata)


import Html.Events exposing (onInput, onClick)
import Html exposing (p,
 Html, Attribute,
 div, input, text, 
 h1, hr,br, img, h3, 
 strong, span, button)

import Html.Attributes exposing (..)

tabClassString : Model -> ActiveTab -> String
tabClassString model tab =
  if model.activeTab == tab then
    "tab active"
  else
    "tab"  
    
type ActiveTab =  CreateAccount | Login | LoggedIn

type alias Model =
  {
    message: String,
    activeTab: ActiveTab
  }


type Msg
    =  DoLogout 
       | DoLogIn  
       | DoCreateAccount

initdata : Model
initdata = 
    { 
      message = "Looged in",
      activeTab = LoggedIn  
    }

headersView : Model -> Html Msg
headersView model =
  div [ id "root" ]
    [ div [ class "app" ]
        [ div [ class "tabs" ]
            [ div [ class "headers" ]
                [ div [ class 
                (tabClassString model CreateAccount)
                  ]
                    [ text "Create Account" ]
                , div [ class (tabClassString model Login) ]
                    [ text "Log In" ]
                ]
            , (createAccountView model)
            ]
        , div [ class "message unauthenticated" ]
            [ div [ class "pill red" ]
                [ text "unauthenticated" ]
            , h1 []
                [ text "You're Not Signed In" ]
            , p []
                [ text "You are currently unauthenticated / signed out." ]
            , p []
                [ text "Go ahead and create an account just like you would a centralized service." ]
            ]
        ]
    ]


createAccountView: Model -> Html Msg
createAccountView model = 
     div [ class "content" ]
                [ div [ class "form" ]
                    [ div [ class "fields" ]
                        [ input [ placeholder "Username" ]
                            []
                        , input [ placeholder "Password", type_ "password" ]
                            []
                        , div []
                            [ input [ placeholder "Confirm Password", type_ "password" ]
                                []
                            , p [ class "error" ]
                                []
                            ]
                        ]
                    , div [ class "buttons" ]
                        [ div [ class "button fullWidth" ]
                            [ text "Create My Account" ]
                        , div [ class "link" ]
                            [ span []
                                [ text "I already have an account." ]
                            ]
                        ]
                    ]
                ]

loginView : Model -> Html Msg
loginView model =
 div [ class "content" ]
                [ div [ class "form" ]
                    [ div [ class "fields" ]
                        [ input [ placeholder "Username" ]
                            []
                        , div []
                            [ input [ placeholder "Password", type_ "password" ]
                                []
                            , p [ class "error" ]
                                []
                            ]
                        ]
                    , div [ class "buttons" ]
                        [ div [ class "button fullWidth",  onClick DoLogIn ]
                            [ text "Log In" ]
                        , div [ class "link", onClick DoCreateAccount ]
                            [ span []
                                [ text "Create Account" ]
                            ]
                        ]
                    ]
                ]