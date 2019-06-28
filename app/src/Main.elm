port module Main exposing (main)


import Browser
import Html.Events exposing (onInput, onClick)
import Html exposing (p,
 Html, Attribute,
 div, input, text, 
 h1, hr,br, img, h3, 
 strong, span, button)
import Html.Attributes exposing (..)
import Json.Encode as E


init : String ->  ( Model, Cmd Msg )
init  flag =  (initdata, Cmd.none)  


tabClassString : Model -> ActivePage -> String
tabClassString model tab =
  if model.activeTab == tab then
    "tab active"
  else
    "tab"  
    
type ActivePage =  CreateAccountTab  | LoginTab  | LoggedInPage 

type Msg = AP ActivePage  
            |  SuccessLogin LoginResult
            |  UpdateUserName String
            |  UpdatePassword String
            | StartLogin

type alias Model =
  {
    userInfo : UserInfo,
    loginResult: LoginResult,
    activeTab: ActivePage
  }

type alias LoginResult =
  {
    isLoggedIn : Bool,
    address: String,
    message: String
  }

type alias UserInfo =
  {
    userName : String,
    password: String
  }
     
initdata : Model
initdata = 
    { 
    loginResult = {
      isLoggedIn = False,
      address = "-",
      message = ""
    },
      userInfo = {
          userName = "no user",
          password = "no password"
      },
    activeTab = LoginTab  
    }

headersView : Model -> Html Msg
headersView model =
  div [ id "root" ]
    [ div [ class "app" ]
        [ div [ class "tabs" ]
            [ div [ class "headers" ]
                [ div [ class 
                (tabClassString model CreateAccountTab),
                onClick (AP CreateAccountTab)
                  ]
                    [ text "Create Account" ]
                , div [ class (tabClassString model LoginTab),
                        onClick (AP LoginTab)
                    ]
                    [ text "Log In" ]
                ]
            ,
             case model.activeTab of
                CreateAccountTab ->
                   (createAccountView model)
                LoginTab  ->
                   (loginView model)
                LoggedInPage -> 
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
                    , div [ class "buttons", onClick (AP LoginTab) ]
                        [ div [ class "button fullWidth" ]
                            [ text "Create My Account" ]
                        , div [ class "link",  onClick (AP LoginTab) ]
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
                        [ input [ placeholder "Username",  onInput UpdateUserName, value model.userInfo.userName ]
                            []
                        , div []
                            [ input [ placeholder "Password", type_ "password", onInput UpdatePassword, value model.userInfo.password  ]
                                []
                            , p [ class "error" ]
                                []
                            ]
                        ]
                    , div [ class "buttons" ]
                        [ div [ class "button fullWidth",  onClick StartLogin ]
                            [ text "Log In" ]
                        , div [ class "link", onClick (AP CreateAccountTab) ]
                            [ span []
                                [ text "Create Account" ]
                            ]
                        ]
                    ]
                ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
 case msg of
    AP x  ->
       updatePage x  model
    SuccessLogin data ->
        case data.isLoggedIn of
            True ->
                ({ model | loginResult = data, activeTab = LoggedInPage  }, Cmd.none)
            False ->
                ({ model | loginResult = data   }, Cmd.none)
    UpdatePassword pswd -> 
         let
            li =  model.userInfo
        in
            ({ model | userInfo = { li|  password = pswd} }, Cmd.none)
    UpdateUserName usrname -> 
        let
            li =  model.userInfo
        in
            ({ model | userInfo = { li | userName = usrname} }, Cmd.none)
    StartLogin ->
       (model, loginUser  model.userInfo)

    
updatePage : ActivePage -> Model -> ( Model, Cmd Msg )
updatePage msg model =
 case msg of
    LoginTab ->
        ({ model | activeTab = LoginTab }, Cmd.none)
    LoggedInPage ->
        ({ model | activeTab = LoggedInPage }, Cmd.none)
    CreateAccountTab ->
        ({ model | activeTab = CreateAccountTab }, Cmd.none)
   

subscriptions : Model -> Sub Msg
subscriptions model =
    loginResult SuccessLogin

 

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
                [ text model.loginResult.address ]
            , div [ class "button", onClick  (AP LoginTab ) ]
                [ text "Log Out"  ]
            ]

view : Model -> Html Msg
view model =
    let
        vw = case model.activeTab of
                CreateAccountTab ->
                  headersView model
                LoginTab  ->
                  headersView model
                LoggedInPage -> 
                    signedInView model
    in
  div [ id "root" ]
      [ div [ class "app" ]
        [vw],
        div [][text model.loginResult.message] 
      ]
      
main = 
  Browser.element
  { view = view
    , init = init
    , update = update
    , subscriptions = subscriptions
  }

port loginUser : UserInfo -> Cmd msg
port loginResult : (LoginResult -> msg) -> Sub msg