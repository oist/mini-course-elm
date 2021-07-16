module CustomElements exposing (..)

import Browser
import Element as El exposing (Element)
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { language : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { language = "sr-RS" }
    , Cmd.none
    )



-- UPDATE


type Msg
    = LanguageChanged String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LanguageChanged language ->
            ( { model | language = language }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    [ viewDate model.language 2021 6
    , Input.radio
        [ El.spacing 5, El.padding 20 ]
        { onChange = LanguageChanged
        , options =
            [ Input.option "sr-RS" (El.text "sr-RS")
            , Input.option "en-GB" (El.text "en-GB")
            , Input.option "en-US" (El.text "en-US")
            ]
        , selected = Just model.language
        , label = Input.labelLeft [] (El.text "Pick a language" |> El.el [ El.padding 5 ])
        }
    ]
        |> El.column [ El.padding 30 ]
        |> El.layout []



-- Use the Custom Element defined in customElements.html


viewDate : String -> Int -> Int -> Element msg
viewDate lang year month =
    Html.node "intl-date"
        [ Html.Attributes.attribute "lang" lang
        , Html.Attributes.attribute "year" (String.fromInt year)
        , Html.Attributes.attribute "month" (String.fromInt month)
        ]
        []
        |> El.html
