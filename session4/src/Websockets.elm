port module Websockets exposing (..)

{-
   Taken from https://guide.elm-lang.org/interop/ports.html

   From session4, compile with

   elm make src/Websockets.elm --output=websockets.js

   and open websockets.html in a browser

-}

import Browser
import Element as El
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Events
import Json.Decode as Decode exposing (Decoder)



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- PORTS


port sendMessage : String -> Cmd msg


port messageReceiver : (String -> msg) -> Sub msg



-- MODEL


type alias Model =
    { draft : String
    , messages : List String
    }


init : () -> ( Model, Cmd Msg )
init () =
    ( { draft = "", messages = [] }
    , Cmd.none
    )



-- UPDATE


type Msg
    = DraftChanged String
    | Send
    | Recv String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DraftChanged draft ->
            ( { model | draft = draft }
            , Cmd.none
            )

        -- Use the `sendMessage` port when someone presses ENTER or clicks
        -- the "Send" button. Check out websockets.html to see the corresponding
        -- JS where this is piped into a WebSocket.
        Send ->
            ( { model | draft = "" }
            , sendMessage model.draft
            )

        Recv message ->
            ( { model | messages = model.messages ++ [ message ] }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    -- Subscribe to the `messageReceiver` port to hear about messages coming in
    -- from JS. Check out the websockets.html file to see how this is hooked up to a
    -- WebSocket.
    messageReceiver Recv



-- VIEW


view : Model -> Html Msg
view model =
    [ El.text "Echo Chat" |> El.el [ Font.size 20, Font.bold ]
    , model.messages |> List.map El.text |> El.column [ El.spacing 5 ]
    , Input.text [ Html.Events.on "keydown" (ifIsEnter Send) |> El.htmlAttribute ]
        { onChange = DraftChanged
        , text = model.draft
        , placeholder = Nothing
        , label =
            Input.button [ Border.width 1, Border.rounded 5 ]
                { onPress = Just Send, label = El.text "Send" |> El.el [ El.padding 5 ] }
                |> Input.labelRight []
        }
    ]
        |> El.column [ El.spacing 20, El.padding 30 ]
        |> El.layout []



-- DETECT ENTER


ifIsEnter : msg -> Decoder msg
ifIsEnter msg =
    Decode.field "key" Decode.string
        |> Decode.andThen
            (\key ->
                if key == "Enter" then
                    Decode.succeed msg

                else
                    Decode.fail "some other key"
            )
