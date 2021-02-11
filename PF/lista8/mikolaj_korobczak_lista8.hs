--Mikołaj Korobczak
--Zadanie 1
f xs
    | xs == [] = []
    | otherwise = [x | x <- tail xs, mod x (head xs) /= 0]


primes = map head (iterate f [2..])
--Zadanie 2
primes' :: [Integer]
primes' = 2:[p | p <- [3..], all (\ q -> mod p q /= 0) (takeWhile (\ q -> q^2 <= p) primes')]
--Zadanie 3
permi, perms:: [a] -> [[a]]

permi [] = [[]]
permi (hd:tl) = concatMap (insert hd) (permi tl) where 
    insert :: a -> [a] -> [[a]] 
    insert x [] = [[x]]
    insert x (hd:tl) = (x:hd:tl) : map (\el -> hd:el) (insert x tl)

perms [] = [[]]
perms xs = [a:r | (a, l) <- select xs, r <- perms l] where
    select :: [a] -> [(a,[a])]
    select = select' id where
        select' _ [] = []
        select' acc (hd:tl) = (hd, acc tl) : select' (acc . (hd:)) tl

--Zadanie 4
sublists :: [a] -> [[a]]
sublists [] = [[]]
sublists (hd:tl) = let rest = sublists tl in
    rest ++ [hd:x | x <- rest]


--Zadanie 5
qsortBy _ [] = []
qsortBy r (h:t) =
    (qsortBy r [x | x <- t, r x h]) ++ [h] ++ (qsortBy r [x | x <- t, r h x])

--Zadanie 6
(><) :: [a] -> [b] -> [(a,b)]
(><) [] _ = []
(><) _ [] = []
(><) l1 l2 = 
    [(l1 !! (fst x), l2 !! (snd x)) | x <- (f l1 l2)] where
        f :: [a] -> [b] -> [(Int, Int)]
        f xs ys = [x | n <- takeWhile (\n -> not (null (drop (n-1) xs))) [1..], x <- prod (take n xs) (take n ys), (fst x) + (snd x) == n-1] where
            prod :: [a] -> [b] -> [(Int, Int)]
            prod xs ys = [(x, y) | x <- [0..(length xs)-1], y <- [0..(length ys)-1]]


--Zadanie 7
data Tree a = Node (Tree a) a (Tree a) | Leaf deriving (Eq, Show)
data Set a = Fin (Tree a) | Cofin (Tree a) deriving (Eq, Show)

setFromList :: Ord a => [a] -> Set a
setEmpty, setFull :: Ord a => Set a
setUnion, setIntersection :: Ord a => Set a -> Set a -> Set a
setComplement :: Ord a => Set a -> Set a
setMember :: Ord a => a -> Set a -> Bool

treeFromList :: Ord a => [a] -> Tree a
treeFromList [] = Leaf
treeFromList (hd:tl) = Node (treeFromList [x | x <- tl, x < hd]) hd (treeFromList [x | x <- tl, x > hd])

setFromList xs = Fin (treeFromList xs)


setEmpty = Fin Leaf
setFull = Cofin Leaf

setMember x (Fin t) =
  treeMember x t where
  treeMember :: Ord a => a -> Tree a -> Bool
  treeMember _ Leaf = False
  treeMember x (Node l y r)
    | y == x = True
    | y < x = treeMember x l
    | y > x = treeMember x r

setMember x (Cofin t) = not (setMember x (Fin t))

setComplement (Fin t) = Cofin t
setComplement (Cofin t) = Fin t

treeToList :: Ord a => Tree a -> [a]
treeToList Leaf = []
treeToList (Node l x r) = (treeToList l) ++ [x] ++ (treeToList r)

setUnion (Fin t1) (Fin t2) = setFromList (treeToList t1 ++ treeToList t2)
setUnion (Fin t1) (Cofin t2) = Cofin (treeFromList [x | x <- treeToList t2, all (\y -> x /= y) (treeToList t1)])
setUnion (Cofin t1) (Fin t2) = setUnion (Fin t2) (Cofin t1)
setUnion (Cofin t1) (Cofin t2) = Cofin (treeFromList [x | x <- treeToList t1, any (\y -> x == y) (treeToList t2)])

setIntersection (Fin t1) (Fin t2) = setFromList [x | x <- treeToList t1, any (\y -> y == x) (treeToList t2)]
setIntersection (Fin t1) (Cofin t2) = setFromList [x | x <- treeToList t1, all (\y -> x /= y) (treeToList t2)]
setIntersection (Cofin t1) (Fin t2) = setIntersection (Fin t2) (Cofin t1)
setIntersection (Cofin t1) (Cofin t2) = let Fin(t1) = setUnion (Fin t1) (Fin t2) in
  Cofin(t1)
