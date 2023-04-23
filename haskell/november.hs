import Prelude hiding ((!!),init,reverse,cycle,(++),take,elem,tail)
tail :: [a] -> [a]
tail (_:xs) = xs

--задача 1
(!!)::[a] -> Int -> a
(!!) (x:xs) finder |finder == 0    = x
                   |finder < 0     = error ("no now")
                   |otherwise      = (!!) xs (finder -1)

--задача 2
init :: [a] -> [a]
init [] =  error "nelizya tak delat'"
init (x:xs) =  init' x xs
  where init' _ [] = []
        init' y (z:zs) = y : init' z zs

--задача 3
(++) :: [a] -> [a] -> [a]
[] ++ ys = ys
(x:xs) ++ ys = x: (xs ++ ys)

--задача 4
cycle :: [a] -> [a]
cycle xs = xs ++ cycle xs


len :: [a] -> Int
len []               =  0
len (x:xs)           =  1 + len xs

cycle' :: [a] -> [a]
cycle' xs |len (xs) > 100   = xs
          |otherwise        = cycle' (xs ++ xs)

--задача 5
take :: Int -> [a] -> [a]
take n _ | n <= 0 = []
take _ []         = []
take n (x:xs)     = x : take (n-1) xs

--задача 6
inits :: [a] -> [[a]]
inits xs = inits' xs 0 []
    where inits' xs t ys = if (t < len (xs)) then ( take t xs ) : inits' xs (t+1) ys else ( take t xs ) : ys 


tails:: [a] -> [[a]]
tails xs = tails' xs (len xs) []
    where tails' xs t ys = if (t > 0) then ( take t xs ) : tails' xs (t-1) ys else ( take t xs ) : ys 

--задача 7
elem :: Eq a => a -> [a] -> Bool
elem _ [] = False
elem find (x:xs) | find == x    = True
                 | xs == []     = False 
                 | otherwise    = elem find xs

--задача 8
nub :: Eq a => [a] -> [a]
nub (x:xs) = nub' (x:xs) []
    where nub' (y:ys) qs | ys == []              = if (elem y qs == False) then y:qs else qs
                         | elem y qs == False    = nub' ys (y:qs)  
                         | otherwise             = nub' ys qs

--задача 9
updElmBy :: Eq a => [a] -> Int -> a -> [a]
updElmBy [] _ _ = error("no,no,no")
updElmBy xs index chr = if (index < 0 || index >= (len (xs)) ) then error ("no,no,no") else updElmBy1 xs index chr []
    where updElmBy1 (x:xs) index chr ys   | index == 0           = (chr:ys) ++ xs
                                          | otherwise            = x : updElmBy1 xs (index-1) chr ys

--задача 10
tr :: Eq a => [a] -> Int -> Int -> [a]
tr xs index_i index_j = tr' xs index_i (xs !! index_i) index_j (xs !! index_j) 0
    where tr' xs i char_i j char_j cnt | cnt == 0     = tr' (updElmBy xs i (char_j)) i char_i j char_j (cnt+1)
                                       | otherwise    = updElmBy xs j (char_i)


--задача 13
sum1:: [Integer] -> Integer
sum1 xs = foldr (\x y -> x^3 + y) 0 xs

--задача 14
sum2:: [Integer] -> Integer
sum2 xs = foldl (\x y -> x^3 + y) 0 xs

--задача 15
fact:: Int -> Int
fact n = foldr (*) 1 [1..n]

expT:: Double -> Int -> Double
expT t n = foldr (\x y -> (t ** (fromIntegral x)) / (fromIntegral (fact x)) + y) 1.0 [1..n]

--задача 16
howmany :: Eq a => a -> [a] -> Int
howmany chr (xs) = foldr (\x y -> if(chr == x) then y + 1 else y + 0)  0 xs

--задача 17 
pochitat:: Char -> Int
pochitat x | (x == 'a'|| x == 'e'|| x == 'i'|| x == 'o'|| x== 'u')   = 1
           | (x == 't'|| x == 'n'|| x == 'r'|| x == 's'|| x== 'h')   = 2
           | otherwise                                               = 0

howmany_g_b_letters :: [Char] -> (Int,Int)
howmany_g_b_letters xs = foldl (\(y1,y2) x -> if (pochitat x == 1) then (y1+1,y2+0) else if (pochitat x == 2) then (y1+0,y2+1) else (y1+0,y2+0)) (0,0) xs

--задача 18
intersperse::a -> [a] -> [a]
intersperse chr xs = tail $ foldl (\y x -> y ++ [chr] ++ [x]) [] xs

--задача 19

cycleshift:: [a] -> [a]
cycleshift (x:xs) = xs ++ [x]

rotate::[a] -> [[a]]
rotate (xs) = foldl (\y (ys) -> (cycleshift ys) : y) [] (new_arr xs [] (len xs))
    where new_arr as bs t | t>0       = new_arr (cycleshift as) (as:bs) (t-1)
                          | otherwise = bs

rotate'::[a] -> [[a]]
rotate' (xs) = foldr (\(ys) y -> ys : y) [] (new_arr' xs [] (len xs))
    where new_arr' as bs t | t>0       = new_arr' (cycleshift as) (as:bs) (t-1)
                           | otherwise  = bs

main = print( nub [1,2,2,2,4] )
