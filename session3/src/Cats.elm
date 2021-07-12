module Cats exposing (..)

{-
      Taken from https://guide.elm-lang.org/effects/json.html

   Exercises: Here are a few ideas to make the example code on this page a bit more interesting!

   * Create a weighted die with Random.weighted.
   * Add a second die and have them both roll at the same time.
   * Instead of showing a die face as a character, use elm/svg to draw it yourself.
   * Have the dice flip around randomly before they settle on a final value.

-}

import Browser
import Element as El exposing (Element)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Http
import Json.Decode as Decode exposing (Decoder)



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
    ( Loading, getRandomCatGif )



-- UPDATE


type Msg
    = MorePlease
    | GotGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        MorePlease ->
            ( Loading, getRandomCatGif )

        GotGif result ->
            case result of
                Ok url ->
                    ( Success url, Cmd.none )

                Err _ ->
                    ( Failure, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    El.column [ El.padding 30, El.spacing 30 ]
        [ El.text "Random Cats" |> El.el [ Font.size 30 ]
        , viewGif model
        ]
        |> El.layout []


viewGif : Model -> Element Msg
viewGif model =
    case model of
        Failure ->
            El.column [ El.spacing 10 ]
                [ El.text "I could not load a random cat for some reason. "
                , Input.button [ Border.width 1, Border.rounded 5 ]
                    { onPress = Just MorePlease
                    , label = El.text "Try Again!" |> El.el [ El.padding 10 ]
                    }
                ]

        Loading ->
            El.text "Loading..."

        Success url ->
            El.column [ El.spacing 10 ]
                [ Input.button [ Border.width 1, Border.rounded 5 ]
                    { onPress = Just MorePlease
                    , label = El.text "More Please!" |> El.el [ El.padding 10 ]
                    }
                , El.image [] { src = url, description = "Cat GIF" }
                ]



-- HTTP


getRandomCatGif : Cmd Msg
getRandomCatGif =
    Http.get
        { url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cat"
        , expect = Http.expectJson GotGif gifDecoder
        }


gifDecoder : Decoder String
gifDecoder =
    Decode.field "data" (Decode.field "image_url" Decode.string)
