module Main exposing (main)


import Browser
import Html.Events exposing (onInput, onClick)
import Html exposing (p,
 Html, Attribute,
 div, input, text, 
 h1, hr,br, img, h3, 
 strong, span, button)

import Html.Attributes exposing (..)


init : String ->  ( Model, Cmd Msg )
init  flag =  (initdata, Cmd.none)  


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
                (tabClassString model CreateAccount),
                onClick DoCreateAccount
                  ]
                    [ text "Create Account" ]
                , div [ class (tabClassString model Login),
                        onClick DoLogIn
                    ]
                    [ text "Log In" ]
                ]
            ,
             case model.activeTab of
                CreateAccount ->
                   (createAccountView model)
                Login  ->
                   (loginView model)
                LoggedIn -> 
                     (loginView model)
            
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
                        , div [ class "link",  onClick DoLogIn ]
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
