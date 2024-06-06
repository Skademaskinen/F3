module Web.Controller.Info where
import Web.Controller.Prelude
import Web.View.Main.Main
import Web.View.Info.Main

instance Controller InfoController where
    action (InfoAction) = render MainInfoView
