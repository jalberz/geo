module Skeleton exposing (skeleton)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


(=>) = (,)

-- MODEL


-- The full application state of our todo app.
--type alias Model =
--    { page : String
--    }

--type alias Entry =
--    { description : String
--    , completed : Bool
--    , editing : Bool
--    , id : Int
--    }


--emptyModel : Model
--emptyModel =
--  { page = "home"
--  , ents = Nothing
--  }


--newEntry : String -> Int -> Entry
--newEntry desc id =
--  { description = desc
--  , completed = False
--  , editing = False
--  , id = id
--  }


--init : Maybe Model -> ( Model, Cmd Msg )
--init savedModel =
--  Maybe.withDefault emptyModel savedModel ! []



-- UPDATE


{-| Users of our app can trigger messages by clicking and typing. These
messages are fed into the `update` function as they occur, letting us react
to them.
-}
--type Msg
--    = NoOp
--    | ChangeVisibility String
--    | GetEnts
--    | ShowEnts (Maybe Ents)

--type domain
--    = Bio 
--    | Clean
--    | Consumer
--    | General
--    | Health
--    | Med
--    | Phys
--    | IT

--type referrer
--    = Brown
--    | Columbia
--    | Cornell
--    | Dartmouth
--    | Harvard
--    | Hopkins
--    | MIT
--    | Penn
--    | Princeton
--    | Stanford
--    | WashU
--    | UChicago
--    | Yale

--entsUrl = "./ents.json"

--type alias Ent = {
--  name : String
--  , domain : String
--  , linkedin : String
--  , referrer : String
--  , notes : String
--}

--getEnts : Cmd Skeleton.Msg
--getEnts = Task.perform FetchFail ShowEnts (Http.get decoderColl entsUrl)

---- The updated Job decoder
--decoder : Decoder Ent
--decoder =
--  Decode.object5 Ent
--    ("name" := Decode.string)
--    ("domain" := Decode.string)
--    ("linkedin" := Decode.string)
--    ("referrer" := Decode.string)
--    ("notes" := Decode.string)

--type alias Ents  = List Ent

--decoderColl : Decoder Jobs
--decoderColl =
--  Decode.object1 identity
--    ("ents" := Decode.list decoder)


---- How we update our Model on a given Msg?
--update : Msg -> Model -> ( Model, Cmd Msg )
--update msg model =
--  case msg of
--    ChangeVisibility page ->
--      { model | page = page }
--        ! []
--    GetEnts -> 
--        ({ model | jobs = Nothing }, getEnts)
--    FetchFail ->
--        (model, Cmd.none)
--    ShowEnts ->
--        ({ model | jobs = maybeJobs }, Cmd.none)
--    NoOp -> model ! []

skeleton tabName content =
  div []
    (header tabName :: content ++ [footer])



-- HEADER


header name =
  div [ id "tabs" ]
    [ a [ href "/"
        , style
            [ "position" => "absolute"
            , "left" => "1em"
            , "top" => "1em"
            ]
        ]
        [ img [ src "./black-white-logo.PNG", style [ "width" => "24px" ] ] []
        ]
    , ul [] (List.map (tab name) ["log-in"])
    ]


tab currentName name =
  li []
    [ a [ classList [ "tab" => True, "current" => (currentName == name) ]
        ]
        [ text name ]
    ]



-- FOOTER


footer =
  div [class "footer"]
    [ text "All code is written in Elm and is inspired by the following site:  "
    , a [ class "grey-link", href "https://github.com/elm-lang/elm-lang.org/" ] [ text "Check it out" ]
    ]
