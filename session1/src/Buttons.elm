module Buttons exposing (Model, Msg(..), init, main, update, view)

{-

   Taken from https://guide.elm-lang.org/architecture/buttons.html

   Exercise: Add a button to reset the counter to zero:

   1) Add a Reset variant to the Msg type
   2) Add a Reset branch in the update function
   3) Add a button in the view function.

   If that goes well, try adding another button to increment by steps of 10.

-}

import Browser
import Html exposing (Html)
import Html.Events



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    Int


init : Model
init =
    0



-- UPDATE


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.button [ Html.Events.onClick Decrement ] [ Html.text "-" ]
        , Html.div [] [ Html.text (String.fromInt model) ]
        , Html.button [ Html.Events.onClick Increment ] [ Html.text "+" ]
        ]
