module Main exposing (main)
import Browser
import Html exposing (Html)

update msg _ = msg

view model =
  Html.text model

main =
    Browser.sandbox { init = "mmm elm build lets see if it compiles..", update = update, view = view }
