{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

import Miso
import Miso.String
import qualified Data.Map as M
import System.Environment
import JavaScript.Object.Internal as JsObj

-- Possible actions to be taken on the site
data Action = Default | Redirect String deriving Show

-- The model used, placeholder for now
type Domain = MisoString

-- subdomains to use for urls
subdomains :: [String]
subdomains = ["jupyter", "nextcloud", "api", "taoshi"]

-- Styles to be reused everywhere
global_style = (M.fromList
    [
        ("background-color", "black"),
        ("color", "white")
    ])

centering = (M.fromList 
    [
        ("text-align", "center")
    ])

outer_margins = (M.fromList 
    [
        ("margin-left", "10%"),
        ("margin-right", "10%")
    ])

rounded = (M.fromList 
    [
        ("background-color", "#cccccc"),
        ("border", "1px solid #cccccc"),
        ("border-radius", "5px"),
        ("padding", "5px"),
        ("white-space", "pre-wrap")
    ])

button = (M.fromList
    [
        ("border 1px solid", "#cccccc"),
        ("border-radius", "5px"),
        ("padding", "1px")

    ])

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

-- update model
updateModel :: Action -> String -> Effect Action String
-- default is doing nothing
updateModel (Default) m = noEff m
-- on redirects, change the window location variable in the following monad
updateModel (Redirect url) m = m <# do 
    obj <- create
    consoleLog (pack url)
    set (pack "window.location.href = ") url obj >> pure Default

-- view model, most of this is just haskell representation of html
viewModel :: String -> View Action
viewModel domain = div_ [ style_ outer_margins ] 
    [ 
        h1_ [ style_ centering ] [ text "Skademaskinen Webserver" ],
        hr_ [],
        h2_ [ style_ centering ] [ text "Information" ],
        div_ [style_ (M.union rounded centering)] 
            [
                text "  This server has been rewritten for the third time! this time in Haskell using ",
                a_ [ href_ "https://github.com/dmjio/miso" ] [ text "Miso" ],
                text " On this site at the moment there should only be links to webservices running\nWritten by Mast3r_waf1z"
            ],
        hr_ [],
        h2_ [ style_ centering ] [ text "Services" ],
        div_ [ style_ (M.union rounded centering) ] 
            -- onClick (Redirect ("https://" ++ subdomain ++ ('.' : domain)))
            (Prelude.map (\subdomain -> button_ [ id_ (pack subdomain), style_ button ] [ text (pack subdomain)]) 
                subdomains),
        -- TODO: use redirect action properly instead of jank
        rawHtml (pack (Prelude.concat (Prelude.map (\subdomain -> "<script>document.getElementById('"++ subdomain ++"').onclick = _ => window.location.href = \"https://"++ subdomain ++ ('.' : domain) ++"\"</script>") subdomains)))
    ]
