module Web.View.Info.Main where
import Web.View.Prelude

import Web.View.Styles

data InfoView = MainInfoView

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

instance View InfoView where
    html MainInfoView = [hsx|
        <h1 style={centering}>Skademaskinen Info:</h1>
        <br>
        <div style={rounding++centering}>
            So this website is written in haskell, this means that i can pretty easily vomit out some funny haskell code like:<br>
            <div style={codeBlock}>
                data Tree a = Node [Tree a] | Leaf a deriving Show
            </div>
            And get the output of this code directly on the site here, idk what i would use it for, but it seemed like a fun challenge :P<br>
            <div style={codeBlock}>
                {Node [Leaf 1, Leaf 2, Node [Leaf 3, Leaf 4]]}
            </div>
            Or something like:
            <div style={codeBlock}>
                instance Functor Tree where...
            </div>
            And apply it to something...
            <div style={codeBlock}>
                [in ] fmap (+1) (Node [Leaf 1, Leaf 2, Node [Leaf 3, Leaf 4]])<br>
                [out] {fmap (+1) (Node [Leaf 1, Leaf 2, Node [Leaf 3, Leaf 4]])}
            </div>
            Or a monad?
            <div style={codeBlock}>
                allPairs t1 t2 = do<br>
                    x &lt;- t1<br>
                    y &lt;- t2<br>
                    return (x, y)
            </div>
            <div style={codeBlock}>
                [in ] allPairs (Node [Leaf 1, Leaf 2]) (Node [Leaf 3, Leaf 4)<br>
                [out] {allPairs (Node [Leaf 1, Leaf 2]) (Node [Leaf 3, Leaf 4])}
            </div>
        </div>
    |]
