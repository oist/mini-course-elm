module Dice exposing (..)

{-
      Taken from https://guide.elm-lang.org/effects/random.html

   Exercises: Here are a few ideas to make the example code on this page a bit more interesting!

   * Create a weighted die with Random.weighted.
   * Add a second die and have them both roll at the same time.
   * Instead of showing a die face as a character, use elm/svg to draw it yourself.
   * Have the dice flip around randomly before they settle on a final value.

-}

import Browser
import Element as El
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Random



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


type alias Model =
    { dieFace : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 1
    , Cmd.none
    )



-- UPDATE


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace (Random.int 1 6)
            )

        NewFace newFace ->
            ( Model newFace
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    El.column [ El.centerX, El.centerY, El.spacing 10 ]
        [ El.text (String.slice (model.dieFace - 1) model.dieFace "⚀⚁⚂⚃⚄⚅")
            |> El.el [ El.centerX, Font.size 40 ]
        , Input.button [ Border.width 1, Border.rounded 5 ]
            { onPress = Just Roll, label = El.text "Roll" |> El.el [ El.padding 10 ] }
        ]
        |> El.layout []
