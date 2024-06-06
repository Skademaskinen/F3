module Web.View.Snake.Main where
import Web.View.Prelude

import Web.View.Styles
import Utils

data SnakeView = MainSnakeView

mainStyle :: String
mainStyle = "background-color: #444444; border-radius: 10px;line-height:0px; width:fit-content;display:inline-block; padding:20px;border: 1px solid white;"

tileStyle :: String
tileStyle = "width:15px;height:15px;background-color:black;margin:0px;display:inline-grid;"

tile :: Int -> Html
tile id = [hsx|
    <div style={tileStyle} id={"tile-" ++ (show id)}>
    </div>
|]

row :: Int -> Html
row offset = [hsx|
    {forEach [(offset*50)..49+(offset*50)] tile}
    <br>
|]

grid :: Html
grid = [hsx|
    {forEach [0..19] row}
|]

instance View SnakeView where
    html MainSnakeView = [hsx|
        <div style={centering}>
            <div style={mainStyle}>
                <h3>Danger Noodle!</h3><br>
                <p>... Some client-side jank, a mix of haskell and javascript</p><br><br>
                <div style="text-align:left; margin-left: 5%;line-height:normal">
                    Controls<br>
                    Start game: any of [W,A,S,D]<br>
                    Up: W<br>
                    Left: A<br>
                    Down: S<br>
                    Right: D<br>
                    <input style="width:100px" placeholder="Speed" id="speed">
                    <input style="width:100px" placeholder="Fruit count" id="fruits">
                </div>
                <div style="display:block ruby;">
                    Score: <p id="snake-score">0</p>
                </div>
                {grid}
            </div>
        </div>
        <script>
            function newFruit(){
                var coords = [Math.floor(Math.random()*50), Math.floor(Math.random()*20)]
                if(tiles[coords[1]][coords[0]].style.backgroundColor != "black"){
                    return newFruit()
                }
                fruits.push(coords)
                tiles[coords[1]][coords[0]].style.backgroundColor = "yellow"
                return coords
            }

            async function launchGame(){
                var running = true
                tiles.forEach(row => row.forEach(tile => tile.style.backgroundColor = "black"))
                try{
                    while(running){
                        tail.push([x, y])
                        switch(direction){
                            case "W":
                                y--
                                break
                            case "A":
                                x--
                                break
                            case "S":
                                y++
                                break
                            case "D":
                                x++
                                break
                            default:
                                running = false
                        }
                        if(tiles[y][x].style.backgroundColor == "white"){
                            running = false
                        }
                        tiles[y][x].style.backgroundColor = "white"
                        var new_fruits = []
                        var score_increase = false
                        fruits.forEach(([fruit_x, fruit_y]) => {
                            if(x == fruit_x && y == fruit_y){
                                console.log("Score increase!")
                                score_increase = true
                                score++
                                new_fruits.push(newFruit())

                            }
                            else{
                                new_fruits.push([fruit_x, fruit_y])
                            }
                        })
                        fruits = new_fruits
                        if(!score_increase){
                            var coords = tail.shift()
                            tiles[coords[1]][coords[0]].style.backgroundColor = "black"
                        }
                        document.getElementById("snake-score").innerHTML = score
                        await sleep(100-speed)
                    }
                }
                finally{
                    alert("Game over")
                    started = false
                    x = 5
                    y = 5
                    tail = []
                    fruits = []
                    var scoreboard = document.getElementById("scoreboard")
                    var date = new Date()
                    var tr = document.createElement("tr")
                    var time = ("" + date.getHours()) + ":" + date.getMinutes() + ":" + date.getSeconds()
                    var timetd = document.createElement("td")
                    timetd.innerHTML = time
                    var scoretd = document.createElement("td")
                    scoretd.innerHTML = score
                    tr.appendChild(timetd)
                    tr.appendChild(scoretd)
                    scoreboard.appendChild(tr)
                }
            }

            var tiles = []
            var fruits = []
            var tail = []
            var fruit_count = 5
            var speed = 25

            var score = 0
            var direction = "N"
            var x = 5
            var y = 5
            var row = []
            for(var index = 0; index <= 20*50; index++){
                if(row.length == 50){
                    tiles.push(row)
                    row = []
                }
                row.push(document.getElementById("tile-"+index))
            }
            var started = false
            var keycodes = {87:"W",65:"A",83:"S",68:"D"}

            document.addEventListener('keydown', event => {
                if(
                    (event.keyCode == 87 && direction == "S") ||
                    (event.keyCode == 65 && direction == "D") ||
                    (event.keyCode == 83 && direction == "W") ||
                    (event.keyCode == 68 && direction == "A")
                ){
                    return
                }
                if(keycodes[event.keyCode] == undefined){
                    return
                }
                direction = keycodes[event.keyCode]
                console.log(direction + " Pressed")
                if(!started){
                    console.log("starting game!")
                    var speed_input = document.getElementById("speed")
                    var fruits_input = document.getElementById("fruits")
                    if(speed_input.value != ""){
                        speed = parseInt(speed_input.value)
                    }
                    if(fruits_input.value != ""){
                        fruit_count = parseInt(fruits_input.value)
                    }
                    alert("Starting Game!")
                    started = !started
                    score = 0
                    launchGame()
                    for(var i = 0; i < fruit_count; i++){
                        newFruit()
                    }
                }

            })
        </script>
        <hr>
        <h2 style={centering}>Scores</h2>
        <div style={centering}>
            <table id="scoreboard" style="display:inline-block;border:1px solid white; padding:5px;">
                <tr>
                    <th style="width:100px">Timestamp</th>
                    <th style="width:100px">Score</th>
                </tr>
            </table>
        </div>
    |]
