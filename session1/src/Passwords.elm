module Passwords exposing (..)

{-
   Exercises: Try to add the following features to the viewValidation helper function:

   * Check that the password is longer than 8 characters.
   * Make sure the password contains upper case, lower case, and numeric characters.

   Use the functions from the String module for these exercises! (https://package.elm-lang.org)

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
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
    Html.div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewValidation model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    Html.input [ Attr.type_ t, Attr.placeholder p, Attr.value v, Html.Events.onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if model.password == model.passwordAgain then
        Html.div [ Attr.style "color" "green" ] [ Html.text "OK" ]

    else
        Html.div [ Attr.style "color" "red" ] [ Html.text "Passwords do not match!" ]
