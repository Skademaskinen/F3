{-# LANGUAGE OverloadedStrings #-}

module Styles where

import Miso.String
import qualified Data.Map as M

-- Styles to be reused everywhere
global_style :: M.Map MisoString MisoString
global_style = (M.fromList
    [
        ("background-color", "black"),
        ("color", "white")
    ])
centering :: M.Map MisoString MisoString
centering = (M.fromList 
    [
        ("text-align", "center")
    ])

outer_margins :: M.Map MisoString MisoString
outer_margins = (M.fromList 
    [
        ("margin-left", "10%"),
        ("margin-right", "10%")
    ])

rounded :: M.Map MisoString MisoString
rounded = (M.fromList 
    [
        ("background-color", "#cccccc"),
        ("border", "1px solid #cccccc"),
        ("border-radius", "5px"),
        ("padding", "5px"),
        ("white-space", "pre-wrap")
    ])

button :: M.Map MisoString MisoString
button = (M.fromList
    [
        ("border 1px solid", "#cccccc"),
        ("border-radius", "5px"),
        ("padding", "1px")

    ])


