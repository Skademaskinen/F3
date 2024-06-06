module Web.Controller.Snake where
import Web.Controller.Prelude
import Web.View.Snake.Main

instance Controller SnakeController where
    action (SnakeAction) = autoRefresh do 
        render MainSnakeView
