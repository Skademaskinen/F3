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
                <p>... Some client-side jank, a mix of haskell and javascript<br>
                {grid}
            </div>
        </div>
        <script>
            async function launchGame(){
                var running = true
                try{
                    while(running){
                        // change current index
                        tiles[y][x].style.backgroundColor = "black"
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
                        tiles[y][x].style.backgroundColor = "white"
                        await sleep(100)
                    }
                }
                finally{
                    alert("Game over")
                    return
                }
            }

            var tiles = []
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
                if(!started){
                  started = !started
                  direction = "D"
                  launchGame()
                  return
                }
                else if(
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
            })
        </script>
    |]
