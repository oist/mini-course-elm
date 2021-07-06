module TextFields exposing (..)

{-

   Taken from https://guide.elm-lang.org/architecture/text_fields.html

   Exercise: show the length of the content in your view function. Use the `String.length` function!

-}

import Browser
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { content : String
    }


init : Model
init =
    { content = "" }



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }



-- VIEW


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.input [ Attr.placeholder "Text to reverse", Attr.value model.content, Html.Events.onInput Change ] []
        , Html.div [] [ Html.text (String.reverse model.content) ]
        ]
