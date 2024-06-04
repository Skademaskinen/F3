module Utils where

import Data.Char

capitalize :: String -> String 
capitalize (x:xs) = (toUpper x) : xs
