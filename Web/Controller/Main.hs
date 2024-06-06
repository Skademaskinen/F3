module Web.Controller.Main where
import Web.Controller.Prelude
import Web.View.Main.Main
import Web.View.Info.Main

instance Controller StaticController where
    action mainAction = render MainView

