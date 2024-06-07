module Web.View.Snake.Main where
import Web.View.Prelude

import Web.View.Styles
import Utils

data SnakeView = MainSnakeView

mainStyle :: String
mainStyle = "background-color: #444444; border-radius: 10px;line-height:0px; width:fit-content;display:inline-block; padding:20px;border: 1px solid white;"

tileStyle :: String
tileStyle = "width:25px;height:25px;background-color:black;margin:0px;display:inline-grid;"

tile :: Int -> Html
tile id = [hsx|
    <div style={tileStyle} id={"tile-" ++ (show id)}>
    </div>
|]

row :: Int -> Html
row offset = [hsx|
    {forEach [(offset*20)..19+(offset*20)] tile}
    <br>
|]

grid :: Html
grid = [hsx|
    {forEach [0..19] row}
|]

fire :: Int -> Html
fire _ = [hsx|
    <img src="/fire.gif" width="50%">
|]

instance View SnakeView where
    html MainSnakeView = [hsx|
        <div style={centering}>
            <div style={mainStyle}>
                <h3>Danger Noodle!</h3><br>
                <p>... Some client-side jank, a mix of haskell and javascript</p><br><br>
                <div style="text-align:left; margin-left: 5%;line-height:normal">
                    Controls<br>
                    Start game: enter<br>
                    Up: W or up<br>
                    Left: A or left<br>
                    Down: S or down<br>
                    Right: D or right<br>
                    <input style="width:100px" placeholder="Speed" id="speed">
                    <input style="width:100px" placeholder="Fruit count" id="fruits">
                </div>
                <div style="display:block ruby;">
                    Score: <p id="snake-score">0</p>
                </div>
                {grid}
                <script src={assetPath "/snake.js"}></script>
                <div style="line-height:normal">
                    <button onclick="keyEvent(37)">&lArr;</button>
                    <button onclick="keyEvent(38)">&uArr;</button>
                    <button onclick="keyEvent(39)">&rArr;</button>
                    <button onclick="keyEvent(40)">&dArr;</button>
                    <button onclick="keyEvent(13)">Start</button>
                </div>
            </div>
        </div>
        <hr>
        <h2 style={centering}>Scores</h2>
        <div style={centering}>
            <table id="scoreboard" style="display:inline-block;border:1px solid white; padding:5px;">
                <tr>
                    <th style="width:100px">Timestamp</th>
                    <th style="width:100px">Score</th>
                    <th style="width:100px">Speed</th>
                    <th style="width:100px">Fruits</th>
                </tr>
            </table>
            <div id="snakefire" style="position:fixed; width:100%; left:0; top:100%">
                {forEach [0..1] fire}
            </div>
        </div>
    |]
