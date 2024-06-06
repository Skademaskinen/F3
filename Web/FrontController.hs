module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Main
import Web.Controller.Info

instance FrontController WebApplication where
    controllers = 
        [
            startPage MainAction,
            parseRoute @InfoController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
