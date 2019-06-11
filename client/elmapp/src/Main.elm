module Main exposing (main)

import Browser
import Html exposing (Html)

update msg _ = msg

view model =
  Html.text model

main =
    Browser.sandbox { init = "Hello, World from Elm!", update = update, view = view }
