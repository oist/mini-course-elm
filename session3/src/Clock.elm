module Clock exposing (Model, Msg(..), init, main, subscriptions, update, view)

{-

   Taken from  https://guide.elm-lang.org/effects/time.html

   Exercises:

   * Add a button to pause the clock, turning the Time.every subscription off.
   * Make the digital clock look nicer.
   * Use elm/svg to make an analog clock with a red second hand!
-}

import Browser
import Element as El
import Html exposing (Html)
import Task
import Time exposing (Posix, Zone)



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { zone : Zone
    , time : Posix
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Time.utc (Time.millisToPosix 0)
    , Task.perform AdjustTimeZone Time.here
    )



-- UPDATE


type Msg
    = Tick Posix
    | AdjustTimeZone Zone


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | time = newTime }
            , Cmd.none
            )

        AdjustTimeZone newZone ->
            ( { model | zone = newZone }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 1000 Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        hour =
            String.fromInt (Time.toHour model.zone model.time)

        minute =
            String.fromInt (Time.toMinute model.zone model.time)

        second =
            String.fromInt (Time.toSecond model.zone model.time)
    in
    El.text (hour ++ ":" ++ minute ++ ":" ++ second)
        |> El.el [ El.centerX, El.centerY ]
        |> El.layout []
