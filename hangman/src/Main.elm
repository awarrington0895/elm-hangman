module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


---- MODEL ----


type alias Model =
    { phrase : String }


init : ( Model, Cmd Msg )
init =
    ( { phrase = "Here is my special phrase!" }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [] 
    [ phraseHtml model.phrase
    , guessButtons
    ]


phraseHtml : String -> Html Msg
phraseHtml phrase =
    phrase
        |> String.split ""
        |> List.map (\char -> 
                if char == " " then
                    " "
                else
                    "_"
            )
        |> List.map (\char -> span [ class "phraseChar" ] [ text char ])
        |> div []



guessButtons : Html Msg
guessButtons = 
    "abcdefghijklmnopqrstuvwxyz"
        |> String.split ""
        |> List.map (\char -> button [] [ text char ])
        |> div []



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
