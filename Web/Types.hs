module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = MainAction deriving (Eq, Show, Data)

data InfoController = InfoAction deriving (Eq, Show, Data)
