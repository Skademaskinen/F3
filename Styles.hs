{-# LANGUAGE OverloadedStrings #-}

module Styles where

import Miso.String
import qualified Data.Map as M

-- Styles to be reused everywhere
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

inline :: M.Map MisoString MisoString
inline = (M.fromList 
    [
        ("display", "inline-grid")
    ])

inline_container :: M.Map MisoString MisoString
inline_container = M.union inline (M.fromList 
    [
        ("border", "1px solid black"),
        ("border-radius", "5px"),
        ("padding", "1px"),
        ("margin", "4px")
    ])

rounded :: M.Map MisoString MisoString
rounded = (M.fromList 
    [
        ("background-color", "#222222"),
        ("border", "1px solid #222222"),
        ("border-radius", "5px"),
        ("padding", "5px"),
        ("white-space", "pre-wrap")
    ])

button :: M.Map MisoString MisoString
button = (M.fromList
    [
        ("border 1px solid", "#444444"),
        ("border-radius", "5px"),
        ("padding", "1px"),
        ("min-width", "100px")

    ])


