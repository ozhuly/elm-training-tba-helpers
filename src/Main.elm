module Main exposing (..)

import Browser
import Html
import Html.Attributes exposing (style)
import Html.Events exposing (onClick, onInput)
import Json.Decode
import Robot
import Time


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


type alias Model =
    {}


type Msg = 

init: Model 
init = {}

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none    

view : Model -> Html Msg
view model =
    
            