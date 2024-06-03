module Types where

import Miso.String

-- Possible actions to be taken on the site
data Action = Default | Redirect String deriving Show

-- The model used, placeholder for now
type Domain = MisoString


