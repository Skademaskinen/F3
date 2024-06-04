module Update where


import Miso
import Miso.String
import JavaScript.Object.Internal as JsObj

import Types

-- update model
updateModel :: Action -> Model -> Effect Action Model
-- default is doing nothing
updateModel (NoAction) m = noEff m
-- on redirects, change the window location variable in the following monad
updateModel (Redirect url) m = m <# do 
    obj <- create
    consoleLog (pack url)
    set (pack "window.location.href = ") url obj >> pure NoAction
updateModel (Initialize) m = m <# do 
    body <- getBody
    set (pack "style") "background-color: black; color: white; font-family: sans-serif;" (Object body) >> pure NoAction


