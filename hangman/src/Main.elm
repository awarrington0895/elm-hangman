module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Set exposing (Set)



---- MODEL ----


type alias Model =
    { phrase : String
    , guesses : Set String
    }


init : ( Model, Cmd Msg )
init =
    ( { phrase = "Here is my special phrase", guesses = Set.empty }, Cmd.none )



---- UPDATE ----


type Msg
    = Guess String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Guess guess ->
            ( { model | guesses = Set.insert guess model.guesses }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ phraseHtml model
        , guessButtons
        , incorrectGuesses model
        ]


phraseHtml : Model -> Html Msg
phraseHtml model =
    model.phrase
        |> String.split ""
        |> List.map
            (\char ->
                if char == " " then
                    " "

                else if (Set.member char model.guesses) then
                    char

                else
                    "_"
            )
        |> List.map (\char -> span [ class "phraseChar" ] [ text char ])
        |> div [ class "phrase" ]


guessButtons : Html Msg
guessButtons =
    "abcdefghijklmnopqrstuvwxyz"
        |> String.split ""
        |> List.map
            (\char ->
                button
                    [ class "guess-button btn btn-primary"
                    , onClick <| Guess char
                    ]
                    [ text char ]
            )
        |> div []



phraseSet : String -> Set String
phraseSet phrase =
    phrase
        |> String.split ""
        |> Set.fromList


incorrectGuesses : Model -> Html Msg
incorrectGuesses model =
    model.guesses
        |> Set.toList
        |> List.filter (\guess -> not <| Set.member guess (phraseSet model.phrase))
        |> List.map (\char -> span [] [ text char ])
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
