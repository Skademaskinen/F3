module Web.View.Snake.Main where
import Web.View.Prelude

import Web.View.Styles
import Utils

data SnakeView = MainSnakeView

mainStyle :: String
mainStyle = "background-color: #444444; border-radius: 10px;"

instance View SnakeView where
    html MainSnakeView = [hsx|
        <div style={rounding ++ centering}>
            <h3>Danger Noodle!</h3>
            <div style={mainStyle}>
                Test
            </div>
        </div>
    |]
