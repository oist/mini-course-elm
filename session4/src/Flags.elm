module Flags exposing (..)

{-
   Taken from https://guide.elm-lang.org/interop/flags.html

   From session4, compile with

   elm make src/Flags.elm --output=flags.js

   and open flags.html in a browser

   Exercise: update Clock.elm from session 3 to avoid the initial lag

-}

import Browser
import Element as El
import Html exposing (Html)



-- MAIN


main : Program Int Model msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { currentTime : Int }


init : Int -> ( Model, Cmd msg )
init currentTime =
    ( { currentTime = currentTime }
    , Cmd.none
    )



-- UPDATE


update : msg -> Model -> ( Model, Cmd msg )
update _ model =
    ( model, Cmd.none )



-- VIEW


view : Model -> Html msg
view model =
    El.text (String.fromInt model.currentTime)
        |> El.layout []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub msg
subscriptions _ =
    Sub.none
