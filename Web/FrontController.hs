module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Main
import Web.Controller.Info
import Web.Controller.Snake

instance FrontController WebApplication where
    controllers = 
        [
            startPage MainAction,
            parseRoute @InfoController,
            parseRoute @SnakeController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
