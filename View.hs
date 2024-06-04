{-# LANGUAGE OverloadedStrings #-}

module View where

import Miso
import Miso.String
import qualified Data.Map as M
import JavaScript.Object.Internal as JsObj

import Types
import Styles
import Utils

-- subdomains to use for urls
subdomains :: [String]
subdomains = ["jupyter", "nextcloud", "api", "taoshi"]

-- Constructor for a little button to go to a source
source :: String -> String -> String -> View action
source label image url = div_ [ style_ inline ] 
    [
        a_ [ href_ (pack url) ] [ img_ [ src_ (pack image), width_ "100" ]],
        br_ [],
        text (pack label)
    ]

-- view model, most of this is just haskell representation of html
viewModel :: Model -> View Action
viewModel model = div_ [ style_ outer_margins ] 
    [ 
        h1_ [ style_ centering ] [ text "Skademaskinen Webserver" ],
        div_ [ style_ centering ] [ img_ [ src_ "../../../media/icon.png", width_ "100" ] ],
        hr_ [],
-------------------------------------------------------
        h2_ [ style_ centering ] [ text "Sources"],
        div_ [ style_ centering ] 
            [
                source "Miso" "https://em-content.zobj.net/thumbs/240/apple/325/steaming-bowl_1f35c.png" "https://github.com/dmjio/miso?tab=readme-ov-file#quick-start",
                source "Haskell" "https://camo.githubusercontent.com/40c7b80f684698e1cb5b1fc44c38bd0b9c60a079fa86d0e6f42fbfee5c676a47/68747470733a2f2f77696b692e6861736b656c6c2e6f72672f77696b6975706c6f61642f342f34612f4861736b656c6c4c6f676f537479507265766965772d312e706e67" "https://www.haskell.org/",
                source "Nix" "https://raw.githubusercontent.com/NixOS/nixos-artwork/53ea652ec7d8af5d21fd2b79b6c49cb39078ddfb/logo/nix-snowflake-colours.svg" "https://nixos.org/"
            ],
-------------------------------------------------------
        hr_ [],
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
            (Prelude.map (\subdomain -> button_ [ id_ (pack subdomain), style_ button ] [ text (pack (capitalize subdomain))]) subdomains),
-------------------------------------------------------
        -- hr_ [],
        -- h2_ [ style_ centering ] [text "README.md"],
        -- div_ [style_ (M.union rounded centering) ] [ text (pack (toReadme model)) ],
-------------------------------------------------------
        -- TODO: use redirect action properly instead of jank
        rawHtml (pack (Prelude.concat (Prelude.map (\subdomain -> "<script>document.getElementById('"++ subdomain ++"').onclick = _ => window.location.href = \"https://"++ subdomain ++ ('.' : (toDomain model)) ++"\"</script>") subdomains)))
        ]
