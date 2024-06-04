module Types where

import Miso.String
import System.IO 
import Control.Monad

-- Possible actions to be taken on the site
data Action = NoAction | Redirect String | Initialize 
    deriving Show

-- The model used, placeholder for now
data Model = Model [Model] | Domain String | Readme String | Default
    deriving Show

defaultModel :: IO Model
defaultModel = do
    -- for some reason reading files at compile time is not supported...
    --handle <- openFile "README.md" ReadMode
    --readme <- hGetContents handle
    --hClose handle
    
    let readme = "Placeholder"

    return (Model [Domain "skade.dev", Readme readme])

instance Eq Model where 
    Model xs == Model ys = Prelude.all (\(x,y) -> x == y) (Prelude.zip xs ys)
    Domain x == Domain y = x == y
    Readme x == Readme y = x == y
    _ == _ = False

getModel :: Model -> String -> Model 
getModel (Model []) _ = Default
getModel (Domain s) "domain" = Domain s
getModel (Readme s) "readme" = Readme s
getModel (Model (x:xs)) query | (getModel x query) == Default = getModel (Model xs) query
                              | otherwise = getModel x query
getModel _ _ = Default

toDomain :: Model -> String
toDomain (Domain s) = s
toDomain (Model xs) = toDomain (getModel (Model xs) "domain")
toDomain _ = "error"

toReadme :: Model -> String 
toReadme (Readme s) = s 
toReadme (Model xs) = toReadme (getModel (Model xs) "readme")
toReadme _ = "error, no readme found in model"
