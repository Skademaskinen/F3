module Web.Controller.Static where
import Web.Controller.Prelude
import Web.View.Static.Main

instance Controller StaticController where
    action mainAction = render MainView
