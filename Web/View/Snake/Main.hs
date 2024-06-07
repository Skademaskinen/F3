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
            </div>
        </div>
        <script>
            function newFruit(){
                var coords = [Math.floor(Math.random()*20), Math.floor(Math.random()*20)]
                if(tiles[coords[1]][coords[0]].style.backgroundColor != "black"){
                    return newFruit()
                }
                fruits.push(coords)
                tiles[coords[1]][coords[0]].style.backgroundColor = "yellow"
                return coords
            }

            async function launchGame(){
                var running = true
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
                        direction = next_direction
                        if(tiles[y][x].style.backgroundColor == "red"){
                            running = false
                        }
                        tiles[y][x].style.backgroundColor = "red"
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
                    var speedtd = document.createElement("td")
                    speedtd.innerHTML = speed
                    var fruitstd = document.createElement("td")
                    fruitstd.innerHTML = fruit_count
                    tr.appendChild(timetd)
                    tr.appendChild(scoretd)
                    tr.appendChild(speedtd)
                    tr.appendChild(fruitstd)
                    scoreboard.appendChild(tr)
                }
            }

            var tiles = []
            var fruits = []
            var tail = []
            var fruit_count = 1
            var speed = 25
            var score = 0
            var direction = "N"
            var next_direction = "N"
            var x = 5
            var y = 5

            var row = []
            for(var index = 0; index <= 20*20; index++){
                if(row.length == 20){
                    tiles.push(row)
                    row = []
                }
                row.push(document.getElementById("tile-"+index))
            }
            var started = false

            document.addEventListener('keydown', event => {
                switch(event.keyCode){
                    case 13:
                        if(!started){
                            tiles.forEach(row => row.forEach(tile => tile.style.backgroundColor = "black"))
                            var speed_input = document.getElementById("speed")
                            var fruits_input = document.getElementById("fruits")
                            if(speed_input.value != ""){
                                speed = parseFloat(speed_input.value)
                            }
                            if(fruits_input.value != ""){
                                fruit_count = parseInt(fruits_input.value)
                            }
                            started = !started
                            score = 0
                            for(var i = 0; i < fruit_count; i++){
                                newFruit()
                            }
                            direction = "D"
                            launchGame()
                        }
                        break
                    case 87:
                    case 38:
                        if(direction != "S")
                            next_direction = "W"
                        break
                    case 65:
                    case 37:
                        if(direction != "D")
                            next_direction = "A"
                        break
                    case 83:
                    case 40:
                        if(direction != "W")
                            next_direction = "S"
                        break
                    case 68:
                    case 39:
                        if(direction != "A")
                            next_direction = "D"
                        break
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
                    <th style="width:100px">Speed</th>
                    <th style="width:100px">Fruits</th>
                </tr>
            </table>
        </div>
    |]
