module Web.View.Info.Main where
import Web.View.Prelude

import Web.View.Styles

data InfoView = MainInfoView

data Tree a = Node a (Tree a) (Tree a) | Empty deriving Show

instance Functor Tree where 
    fmap f (Node a n1 n2) = Node (f a) (fmap f n1) (fmap f n2)
    fmap f (Empty) = Empty

instance Applicative Tree where
    pure x = Node x Empty Empty
    _ <*> Empty = Empty
    Empty <*> x = Empty
    (Node f _ _) <*> (Node x n1 n2) = Node (f x) (pure f <*> n1) (pure f <*> n2)

instance Monad Tree where
    return = pure
    Empty >>= f = Empty
    (Node x _ _) >>= f = f x

testTree :: Tree Int -> Tree Int
testTree tree = do
    x <- tree
    return (x+1)

instance View InfoView where
    html MainInfoView = [hsx|
        <h1 style={centering}>Skademaskinen Info:</h1>
        <br>
        <div style={rounding++centering}>
            So this website is written in haskell, this means that i can pretty easily vomit out some funny haskell code like:<br>
            <div style={codeBlock}>
                data Tree a = Node a (Tree a) (Tree a) | Empty deriving Show
            </div>
            And get the output of this code directly on the site here, idk what i would use it for, but it seemed like a fun challenge :P<br>
            <div style={codeBlock}>
                {Node 1 Empty Empty}
            </div>
            Or something like:
            <div style={codeBlock}>
                instance Functor Tree where...
            </div>
            And apply it to something...
            <div style={codeBlock}>
                [in ] fmap (+1) (Node 1 (Node 2 Empty Empty) Empty)<br>
                [out] {fmap (+1) (Node 1 (Node 2 Empty Empty) Empty)}
            </div>
            Or a monad?
            <div style={codeBlock}>
                [in ] testTree (Node 1 (Node 2 Empty Empty) Empty)<br>
                [out] {testTree (Node 1 (Node 2 Empty Empty) Empty)}
            </div>
            This is a very bad example of a monad... i should probably rewrite that...
        </div>
    |]
