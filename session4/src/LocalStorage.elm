port module LocalStorage exposing (..)

{-
   Taken from https://github.com/elm-community/js-integration-examples

   From session4, compile with

   elm make src/LocalStorage.elm --output=localStorage.js

   and open localStorage.html in a browser

   Exercice: Add two buttons "Save" and "Reset".
   Modify the program so that the name only gets saved in storage when pressing "Save".
   Pressing "Reset" should get the value in storage and replace the one in the textfield.
   You will need to add the "fetchStorage" and "receiveStorage" ports and modify the Javascript code.
   Refer to the code in the websocket project.

-}

import Browser
import Element as El
import Element.Input as Input
import Html exposing (Html)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)



-- MAIN


main : Program Value Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = updateWithStorage
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { name : String
    }


init : Value -> ( Model, Cmd Msg )
init flags =
    ( case Decode.decodeValue decoder flags of
        -- Here we use "flags" to load information in from localStorage. The
        -- data comes in as a JS value, so we define a `decoder` at the bottom
        -- of this file to turn it into an Elm value.
        -- Check out localStorage.html to see the corresponding code on the JS side.
        Ok model ->
            model

        Err _ ->
            { name = "" }
    , Cmd.none
    )



-- UPDATE


type Msg
    = NameChanged String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NameChanged name ->
            ( { model | name = name }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    El.column [ El.centerX, El.padding 30 ]
        [ Input.text []
            { onChange = NameChanged
            , text = model.name
            , placeholder = Nothing
            , label =
                El.text "What is your name?"
                    |> Input.labelLeft []
            }
        ]
        |> El.layout []



-- PORTS


port setStorage : Encode.Value -> Cmd msg



-- We want to `setStorage` on every update, so this function adds
-- the setStorage command on each step of the update function.
--
-- Check out localStorage.html to see how this is handled on the JS side.


updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
updateWithStorage msg oldModel =
    let
        ( newModel, cmds ) =
            update msg oldModel
    in
    ( newModel
    , Cmd.batch [ setStorage (encode newModel), cmds ]
    )



-- JSON ENCODER/DECODER


encode : Model -> Value
encode model =
    Encode.object
        [ ( "name", Encode.string model.name )
        ]


decoder : Decoder Model
decoder =
    Decode.map Model
        (Decode.field "name" Decode.string)
