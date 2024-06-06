module Web.View.Info.Main where
import Web.View.Prelude

import Web.View.Styles

data InfoView = MainInfoView

instance View InfoView where
    html MainInfoView = [hsx|
        Skademaskinen Info
    |]
