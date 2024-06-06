module Web.View.Main.Main where
import Web.View.Prelude

import Web.View.Styles

--- Types and constants
-------------------------
data MainView = MainView

--- Builders
-------------------------
link_image :: String -> String -> String -> Html 
link_image label image url = [hsx|
    <div class="inline_container">
        <a href={url}>
            <img src={image} width="100" height="100">
        </a>
        <br>
        {label}
    </div>
|]

render_subdomain_button :: Text -> Html
render_subdomain_button subdomain = [hsx|
    <button style={button} id={subdomain} onclick="go_to(this.id)">{subdomain}</button>
|]

--- sections
-------------------------
sourcesSection :: Html
sourcesSection = [hsx|
    <hr>
    <h2 style={centering}>Sources</h2>
    <div style={centering++rounding}>
        This website is written using the following software:<br>
        {link_image "IHP" "https://ihp.digitallyinduced.com/ihp.svg" "https://ihp.digitallyinduced.com/"}
        {link_image "Haskell" "https://wiki.haskell.org/wikiupload/4/4a/HaskellLogoStyPreview-1.png" "https://haskell.org"}
        {link_image "Nix" "https://raw.githubusercontent.com/NixOS/nixos-artwork/53ea652ec7d8af5d21fd2b79b6c49cb39078ddfb/logo/nix-snowflake-colours.svg" "https://nixos.org"}
        {link_image "Neovim" "https://upload.wikimedia.org/wikipedia/commons/3/3a/Neovim-mark.svg" "https://neovim.io"}
        <br>
        Source code: <a href="https://github.com/Skademaskinen/F3">
            <img src="/github.svg" height="20">
        </a>
    </div>
|]

infoSection :: Html
infoSection = [hsx|
    <hr>
    <h2 style={centering}>Information</h2>
    <div style={rounding++centering}>
        This is the frontend v3 of Skademaskinen, using IHP, Haskell and Nix. At the moment only links to software hosted is present.<br>
        Written by Mast3r_waf1z
    </div>
|]

servicesSection :: [Text] -> Html
servicesSection subdomains = [hsx|
    <hr>
    <h2 style={centering}>Services</h2>
    <div style={rounding++centering}>
        This section contains links to services hosted on this server <br>
        <script>
            function go_to(id){
                console.log(id)
                window.location.href = "https://"+id+"."+window.location.hostname
            }
        </script>
        {forEach subdomains render_subdomain_button}
    </div>
|]

--- Main
-------------------------
instance View MainView where
    html MainView = [hsx|
        <h1 style={centering}>Skademaskinen Webserver</h1>
        <div style={centering}>
            <img src={assetPath"/icon.png"} style="border-radius:50%">
        </div>
        {infoSection}
        {servicesSection ["nextcloud", "jupyter", "matrix", "api", "taoshi"]}
        {sourcesSection}
    |]
