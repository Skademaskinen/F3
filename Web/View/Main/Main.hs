module Web.View.Main.Main where
import Web.View.Prelude

import Web.View.Styles

--- Types and constants
-------------------------
data MainView = MainView

subdomains = ["nextcloud", "jupyter", "api", "taoshi"]

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

--- Main
-------------------------
instance View MainView where
    html MainView = [hsx|
        <h1 style={centering}>Skademaskinen Webserver</h1>
        <div style={centering}>
            <img src={assetPath"/icon.png"}>
        </div>
        <hr>
        <h2 style={centering}>Sources</h2>
        <div style={centering++rounding}>
            This website is written using the following software:<br>
            {link_image "IHP" "https://ihp.digitallyinduced.com/ihp.svg" "https://ihp.digitallyinduced.com/"}
            {link_image "Haskell" "https://wiki.haskell.org/wikiupload/4/4a/HaskellLogoStyPreview-1.png" "https://haskell.org"}
            {link_image "Nix" "https://raw.githubusercontent.com/NixOS/nixos-artwork/53ea652ec7d8af5d21fd2b79b6c49cb39078ddfb/logo/nix-snowflake-colours.svg" "https://nixos.org"}
        </div>
        <hr>
        <h2 style={centering}>Information</h2>
        <div style={rounding++centering}>
            This is the frontend v3 of Skademaskinen, using IHP, Haskell and Nix. At the moment only links to software hosted is present.<br>
            Written by Mast3r_waf1z
        </div>
        <hr>
        <h2 style={centering}>Services</h2>
        <div style={rounding++centering}>
            This section contains links to services hosted on this server <br>
            <script>
                function go_to(id){
                    console.log(id)
                    window.location.href = "https://"+id+".skade.dev"
                }
            </script>
            {forEach subdomains render_subdomain_button}
        </div>
    |]
