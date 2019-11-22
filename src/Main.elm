module Main exposing (..)

import Browser
import Html
import Html.Attributes exposing (style)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as JD
import Time


main : Program () Model Msg
main =
    Browser.element
        { init = always ( init, Cmd.none )
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }



-- errorToString : Http.Error -> String
-- errorToString err =
--     case err of
--         Timeout ->
--             "Timeout exceeded"
--         NetworkError ->
--             "Network error"
--         BadStatus resp ->
--             parseError resp.body
--                 |> Maybe.withDefault (String.fromInt resp.status.code ++ " " ++ resp.status.message)
--         BadPayload text resp ->
--             "Unexpected response from api: " ++ text
--         BadUrl url ->
--             "Malformed url: " ++ url


type alias Model =
    { teamNum : String, teamCountry : String }


type Msg
    = Input String
    | GotInfo (Result Http.Error String)


init : Model
init =
    { teamNum = "", teamCountry = "" }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input team ->
            ( { model | teamNum = team }
            , Http.request
                { method = "POST"
                , headers =
                    [ Http.header "X-TBA-Auth-Key" "qh1YyHDj6kfTWFxTLeHRk8T73Vh2RUtXB0guDYw9oLMGFYqlcJ786hVAcGwAha5r"
                    , Http.header "Access-Control-Allow-Origin" "*"
                    ]
                , url = "https://www.thebluealliance.com/api/v3/team/frc" ++ team
                , body = Http.emptyBody
                , expect = Http.expectJson GotInfo <| JD.field "country" JD.string
                , timeout = Nothing
                , tracker = Nothing
                }
            )

        GotInfo info ->
            let
                _ =
                    Debug.toString Err
            in
            case info of
                Ok value ->
                    ( { model | teamCountry = Result.withDefault "" <| JD.decodeString (JD.field "country" JD.string) value }, Cmd.none )

                Err error ->
                    ( { model | teamCountry = "error" }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.input [ onInput Input ] []
        , Html.div [] [ Html.text model.teamCountry ]
        ]
