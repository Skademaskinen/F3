{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

import Miso
import System.Environment
import JavaScript.Object.Internal as JsObj

import Styles
import Update
import View
import Types
import Utils

main :: IO ()
-- Record wildcards is used here because the line below is very scuffed
--main = startApp (App "Skademaskinen Haskell Server" updateModel viewModel [] defaultEvents Default Nothing Off)
main = do startApp App {..}
    where 
        initialAction = Default 
        model = "skade.dev"
        update = updateModel
        view = viewModel
        events = defaultEvents
        subs = []
        mountPoint = Nothing 
        logLevel = Off

