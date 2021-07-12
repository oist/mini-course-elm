module Book exposing (..)

{-
   Taken from https://guide.elm-lang.org/effects/http.html

   Exercise: Install the package krisajenkins/remotedata, change the model to
       type alias Model =
         { book : WebData }
    and update the module to accomodate the change.
-}

import Browser
import Element as El
import Html exposing (Html)
import Http



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type Model
    = Failure
    | Loading
    | Success String


init : () -> ( Model, Cmd Msg )
init _ =
    ( Loading
    , Http.get
        { url = "https://elm-lang.org/assets/public-opinion.txt"
        , expect = Http.expectString GotText
        }
    )



-- UPDATE


type Msg
    = GotText (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        GotText result ->
            case result of
                Ok fullText ->
                    ( Success fullText, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    (case model of
        Failure ->
            El.text "I was unable to load your book."

        Loading ->
            El.text "Loading..."

        Success fullText ->
            El.text fullText
    )
        |> El.layout []
