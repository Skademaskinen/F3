module Update where


import Miso
import Miso.String
import JavaScript.Object.Internal as JsObj

import Types

-- update model
updateModel :: Action -> String -> Effect Action String
-- default is doing nothing
updateModel (Default) m = noEff m
-- on redirects, change the window location variable in the following monad
updateModel (Redirect url) m = m <# do 
    obj <- create
    consoleLog (pack url)
    set (pack "window.location.href = ") url obj >> pure Default


