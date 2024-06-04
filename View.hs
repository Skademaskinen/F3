{-# LANGUAGE OverloadedStrings #-}

module View where

import Miso
import Miso.String
import qualified Data.Map as M
import JavaScript.Object.Internal as JsObj

import Types
import Styles

-- subdomains to use for urls
subdomains :: [String]
subdomains = ["jupyter", "nextcloud", "api", "taoshi"]

-- view model, most of this is just haskell representation of html
viewModel :: Model -> View Action
viewModel model = div_ [ style_ outer_margins ] 
    [ 
        h1_ [ style_ centering ] [ text "Skademaskinen Webserver" ],
        hr_ [],
-------------------------------------------------------
        h2_ [ style_ centering ] [ text "Information" ],
        div_ [style_ (M.union rounded centering)] 
            [
                text "  This server has been rewritten for the third time! this time in Haskell using ",
                a_ [ href_ "https://github.com/dmjio/miso" ] [ text "Miso" ],
                text " On this site at the moment there should only be links to webservices running\nWritten by Mast3r_waf1z"
            ],
-------------------------------------------------------
        hr_ [],
        h2_ [ style_ centering ] [ text "Services" ],
        div_ [ style_ (M.union rounded centering) ] 
            -- onClick (Redirect ("https://" ++ subdomain ++ ('.' : domain)))
            (Prelude.map (\subdomain -> button_ [ id_ (pack subdomain), style_ button ] [ text (pack subdomain)]) 
                subdomains),
-------------------------------------------------------
        hr_ [],
        h2_ [ style_ centering ] [text "README.md"],
        div_ [style_ (M.union rounded centering) ] [ text (pack (toReadme model)) ],
-------------------------------------------------------
        -- TODO: use redirect action properly instead of jank
        rawHtml (pack (Prelude.concat (Prelude.map (\subdomain -> "<script>document.getElementById('"++ subdomain ++"').onclick = _ => window.location.href = \"https://"++ subdomain ++ ('.' : (toDomain model)) ++"\"</script>") subdomains)))
    ]
