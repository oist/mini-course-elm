module Navigation exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation as Nav exposing (Key)
import Element as El exposing (Element)
import Element.Font as Font
import Html exposing (Html)
import Url exposing (Url)



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { key : Key
    , url : Url
    }


init : () -> Url -> Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked UrlRequest
    | UrlChanged Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "URL Interceptor"
    , body =
        [ [ El.text "The current URL is: "
          , El.text (Url.toString model.url) |> El.el [ Font.bold ]
          ]
            |> El.paragraph []
        , El.column [ El.spacing 5, Font.underline ]
            [ viewLink "/home"
            , viewLink "/mini-course"
            , viewLink "/reviews/mini-courses-are-great"
            , viewLink "/reviews/mini-courses-are-fantastic"
            , viewLink "/reviews/mini-course-elm-is-the-best"
            , viewLink "https://groups.oist.jp/grad/skill-pills"
            ]
        ]
            |> El.column [ El.spacing 30, El.padding 20 ]
            |> El.layout []
            |> (\layout -> [ layout ])
    }


viewLink : String -> Element Msg
viewLink path =
    El.link [] { url = path, label = El.text path }
