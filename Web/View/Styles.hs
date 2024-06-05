module Web.View.Styles where 
import Web.View.Prelude

centering = "text-align:center;" :: Text

global = "background-color: black;" ++
    "color: white;" :: Text

inline = "display: inline-grid;" :: Text

inline_container = inline ++
    "border:1px solid black;" ++
    "border-radius:5px;" ++
    "padding:1px;" ++
    "margin:4px;" :: Text

rounding = "background-color:#222222;" ++
    "border:1px solid #222222;" ++
    "border-radius:5px;" ++
    "padding:5px;" ++
    "white-space:pre-wrap;" :: Text

button = "border:1px solid #444444;" ++
    "border-radius:5px;" ++
    "padding:1px;" ++
    "min-width:100px;" :: Text
