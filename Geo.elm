port module Geo exposing (..)
{-
-}

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Keyed as Keyed
import Html.Lazy exposing (lazy, lazy2)
import Json.Decode as Json
import String
import Geolocation exposing (..)
import Time

import Skeleton

(=>) = (,)



main : Program (Maybe Model)
main =
  App.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> (changes locationSend)-- will need to provide function argument with type (Location -> msg)
    }

-- will need to go from Location -> Msg

locationSend : Location -> Msg
locationSend loc = ChangeLoc (Just loc)

-- MODEL

type alias Model = 
    { latitude : Float
    , longitude : Float
    , accuracy : Float
    , altitude : Maybe Altitude
    , movement : Mov
    , timestamp : Float
    }

type alias Mov =
    { speed : Float
    , degreesFromNorth : Float
    }

emptyModel : Model
emptyModel = 
    { latitude = 0
    , longitude = 0
    , accuracy = 0
    , altitude = Nothing
    , movement = emptyMove
    , timestamp = 0
    }

emptyMove : Mov
emptyMove =
    { speed = 0
    , degreesFromNorth = 0
    }

init : Maybe Model -> ( Model, Cmd Msg )
init savedModel = 
    Maybe.withDefault emptyModel savedModel ! []

type Msg 
    = NoOp
    | ChangeLoc (Maybe Location)
    | ShowChange


-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    ChangeLoc loc -> case loc of
        Nothing -> model ! []
        Just l -> { model 
                | latitude = l.latitude
                , longitude = l.longitude
                , accuracy = l.accuracy
                , altitude = Nothing
                , movement = moveTranslate (l.movement)
                , timestamp = Time.inSeconds(l.timestamp) } ! []
    --ShowChange ->
    --    ({ model | jobs = maybeJobs }, Cmd.none)
    NoOp -> model ! []
    _ -> Debug.crash "Unexpected case in update"


-- VIEW

view : Model -> Html Msg
view model = Skeleton.skeleton "home"
              [ locSection model
              ]

{-
type alias Location = 
    { latitude : Float
    , longitude : Float
    , accuracy : Float
    , altitude : Maybe Altitude
    , movement : Maybe Movement
    , timestamp : Time
    }
-}


stringMovement mov = "speed: " ++ (toString mov.speed) ++ " degrees from north: " ++ (toString mov.degreesFromNorth)

-- for translating between standard movement type and that of the general records in the model
-- moveTranslate : Movement -> String
moveTranslate mov = case mov of 
    Nothing -> { speed = 0, degreesFromNorth = 0 }
    Just m -> case m of
        Static -> { speed = 0, degreesFromNorth = 0 }
        Moving i -> { speed = i.speed, degreesFromNorth = i.degreesFromNorth }

stringAltitude : Maybe Altitude -> String
stringAltitude alt = case alt of
    Nothing -> "no altitude information available"
    Just a -> "value: " ++ (toString a.value) ++ " accuracy: " ++ (toString a.accuracy)

locSection model =
    section [ style [ "background-color" => "#444D4C", "color" => "white" ], size 20 28 ]
    [ text "Geolocation Information"
    , ul [] [ li [] [text ("latitude: " ++ (toString model.latitude)) ]
            , li [] [text ("longitude: " ++ (toString model.longitude)) ]
            , li [] [text ("accuracy: " ++ (toString model.accuracy)) ]
            , li [] [text ("altitude: " ++ (stringAltitude model.altitude)) ]
            , li [] [text ("speed: " ++ (stringMovement model.movement)) ]
            , li [] [text ("timestamp: " ++ (toString model.timestamp)) ]
            ]
    ]

size height padding =
  style
    [ "font-size" => (toString height ++ "px")
    , "padding" => (toString padding ++ "px")
    ]


