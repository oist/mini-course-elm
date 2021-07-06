module Buttons exposing (Model, Msg(..), init, main, update, view)

{-

   Taken from https://guide.elm-lang.org/architecture/buttons.html

   Exercise: Make reset button fancy

-}

import Browser
import Element as El exposing (Color, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)



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
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Reset ->
            0



-- VIEW


darkBlue : Color
darkBlue =
    El.fromRgb255 { red = 8, green = 78, blue = 126, alpha = 1 }


white : Color
white =
    El.fromRgb255 { red = 255, green = 255, blue = 255, alpha = 1 }


fancyButton : String -> Msg -> Element Msg
fancyButton text msg =
    Input.button
        [ Background.color darkBlue
        , Border.rounded 10
        , Font.color white
        , El.width (El.px 40)
        , El.height (El.px 40)
        ]
        { label = El.text text |> El.el [ El.centerX, El.centerY ]
        , onPress = Just msg
        }


fancyText : String -> Element msg
fancyText text =
    El.text text
        |> El.el [ El.centerX, El.centerY, El.moveDown 1.0 ]
        |> El.el
            [ El.width (El.px 40)
            , El.height (El.px 40)
            , Font.color darkBlue
            , Font.bold
            , Font.family [ Font.sansSerif, Font.typeface "Helvetica" ]
            , Border.width 2
            , Border.color darkBlue
            , Border.rounded 10
            ]


view : Model -> Html Msg
view model =
    [ fancyButton "-" Decrement
    , fancyText (String.fromInt model)
    , fancyButton "+" Increment
    , Input.button [] { label = El.text "Reset", onPress = Just Reset }
    ]
        |> El.column [ El.centerX, El.centerY, El.padding 20, Font.size 20, El.spacing 5 ]
        |> El.layout []
