{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

import Miso
import Miso.String
import qualified Data.Map as M

type Model = String

data Action = Default deriving Show

header_style = style_ (M.fromList 
    [
        ("text-align", "center")
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
viewModel x = div_ [] 
    [ 
        h1_ [ header_style] [ text (ms x) ] 
    ]
