module Config where

import IHP.Prelude
import IHP.Environment
import IHP.EnvVar
import IHP.FrameworkConfig

config :: ConfigBuilder
config = do
    port <- env @Int "SKADEMASKINEN_FRONTEND_PORT"
    option(AppPort port)
    -- See https://ihp.digitallyinduced.com/Guide/config.html
    -- for what you can do here
    pure ()
