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
main = startApp App {..}
    where 
        initialAction = Default
        model = "Skademaskinen Haskell Webserver"
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
