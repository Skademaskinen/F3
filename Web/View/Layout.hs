module Web.View.Layout (defaultLayout, Html) where

import IHP.ViewPrelude
import IHP.Environment
import Generated.Types
import IHP.Controller.RequestContext
import Web.Types
import Web.Routes
import Application.Helper.View

import Web.View.Styles

defaultLayout :: Html -> Html
defaultLayout inner = [hsx|
<!DOCTYPE html>
<html lang="en">
    <head>
        {metaTags}

        {stylesheets}
        {scripts}

        <title>{pageTitleOrDefault "Skademaskinen"}</title>
    </head>
    <body style={global}>
        <div style={centering}>
            Navigation:
            |<a href="/">Home</a>
            |<a href="/Info">Info</a>
            |<br>
            <hr>
        </div>
        <div class="container mt-4">
            {renderFlashMessages}
            {inner}
        </div>
    </body>
</html>
|]

-- The 'assetPath' function used below appends a `?v=SOME_VERSION` to the static assets in production
-- This is useful to avoid users having old CSS and JS files in their browser cache once a new version is deployed
-- See https://ihp.digitallyinduced.com/Guide/assets.html for more details

stylesheets :: Html
stylesheets = [hsx|
        <link rel="stylesheet" href={assetPath "/vendor/bootstrap-5.2.1/bootstrap.min.css"}/>
        <link rel="stylesheet" href={assetPath "/vendor/flatpickr.min.css"}/>
        <link rel="stylesheet" href={assetPath "/app.css"}/>
    |]

scripts :: Html
scripts = [hsx|
        {when isDevelopment devScripts}
        <script src={assetPath "/ihp-auto-refresh.js"}></script>
        <script src={assetPath "/app.js"}></script>
    |]

devScripts :: Html
devScripts = [hsx|
        <script id="livereload-script" src={assetPath "/livereload.js"} data-ws={liveReloadWebsocketUrl}></script>
    |]

metaTags :: Html
metaTags = [hsx|
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta property="og:title" content="Skademaskinen"/>
    <meta property="og:type" content="website"/>
    <meta property="og:url" content="https://skade.dev"/>
    <meta property="og:description" content="Skademaskinen Frontend"/>
    {autoRefreshMeta}
|]
