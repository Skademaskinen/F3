{-# LANGUAGE OverloadedStrings #-}
module Utils where

import Prelude
import GHC.Show
import Data.Char
import Data.String
import Control.Monad
import Control.Applicative

data Tree a = Node [Tree a] | Leaf a deriving Show

instance Functor Tree where 
    fmap f (Node ns) = Node (map (fmap f) ns)
    fmap f (Leaf a) = Leaf (f a)

instance Applicative Tree where
    pure = Leaf
    Leaf f <*> Leaf x = Leaf (f x)
    Leaf f <*> Node ns = Node (map (pure f <*>) ns)
    Node fs <*> n = Node (map (<*> n) fs)

instance Monad Tree where
    return = pure
    Leaf x >>= f = f x
    Node ns >>= f = Node (map (>>= f) ns)

allPairs :: Tree a -> Tree b -> Tree (a, b)
allPairs t1 t2 = do
    x <- t1
    y <- t2
    return (x, y)

capitalize :: String -> String
capitalize (x:xs) = (toUpper x) : xs
