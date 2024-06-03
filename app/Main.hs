{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

import Miso
import Miso.String
import qualified Data.Map as M

type Model = String

data Action = Default deriving Show

global_style = style_ (M.fromList
    [
        ("background-color", "black"),
        ("color", "white")
    ])

centering = style_ (M.fromList 
    [
        ("text-align", "center")
    ])

outer_margins = style_ (M.fromList 
    [
        ("margin-left", "10%"),
        ("margin-right", "10%")
    ])

main :: IO ()
-- Record wildcards is used here because the line below is very scuffed
--main = startApp (App "Skademaskinen Haskell Server" updateModel viewModel [] defaultEvents Default Nothing Off)
main = startApp App {..}
    where 
        initialAction = Default 
        model = "Skademaskinen Haskell-based Webserver"
        update = updateModel
        view = viewModel
        events = defaultEvents
        subs = []
        mountPoint = Nothing 
        logLevel = Off


updateModel :: Action -> Model -> Effect Action Model 
updateModel action m = noEff (m)

viewModel :: Model -> View Action
viewModel x = div_ [ outer_margins ] 
    [ 
        h1_ [ centering ] [ text (ms x) ],
        hr_ [],
        a_ [ href_ "https://jupyter.skade.dev" ] [ text "Jupyter" ]
    ]
