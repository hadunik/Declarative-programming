inc:: Int -> Int
inc x | x >= 0 = x+1 
      |otherwise = -1

dec:: Int -> Int
dec x | x > 0 = x - 1 
      | x == 0 = 0 
      | otherwise = -1

pls:: Int -> Int -> Int
pls x y | y > 0 = pls (inc x) (dec y) 
        | otherwise = x

mns:: Int -> Int -> Int
mns x y | y > 0 = mns (dec x) (dec y) 
        | otherwise = x

mlt:: Int -> Int -> Int
mlt x y = mlt' x y 0

mlt'::Int -> Int -> Int -> Int
mlt' x y sum| y > 0 = mlt' x (dec y) (sum + x) 
            | otherwise = sum
--начало задания 2
min2:: Int -> Int -> Int
min2 x y = min1 x y x y 

min1::Int -> Int -> Int -> Int -> Int
min1 x y x1 y1 |x1 == 0 = x 
               |y1 == 0 = y 
               |otherwise = min1 x y (dec x1) (dec y1)

max2:: Int -> Int -> Int
max2 x y = max1 x y x y 

max1::Int -> Int -> Int -> Int -> Int
max1 x y x1 y1 |x1 == 0 = y 
               |y1 == 0 = x 
               |otherwise = max1 x y (dec x1) (dec y1)
--задание 3 и 5
mod1:: Int-> Int -> (Int,Int)
mod1 x y | x >= 0 && y > 0 =  mod2 x y 0 0
         |otherwise        = (-1,-1)

mod2:: Int -> Int -> Int -> Int -> (Int,Int)
mod2 m k n r | m == (k*n + r) = (n, r) 
             | r < k = mod2 m k n (inc r) 
             | otherwise = mod2 m k (inc n) 0
--задание 4 и 5
divf1:: Int-> Int-> Int
divf1 x y |x >= y     = 1 + divf1 (x-y) y  
          |otherwise  = 0

modf1:: Int-> Int-> Int 
modf1 x y |x > y     = modf1 (x-y) y  
          |otherwise  = (y - x)
--задание 6
pr::Int -> Int -> Int
pr x y = predicat x y 0
predicat::Int -> Int -> Int -> Int
predicat x y acc |x - y*acc == 0   = acc
                 |otherwise        = predicat x y (inc acc)
--задание 7
kol_del::Int -> Int
kol_del x = kol_del1 x 1 0

kol_del1::Int -> Int -> Int -> Int
kol_del1 x n acc|n == x          = (inc acc)
                |modf1 x n == 0  = sum_del1 x (inc n) (inc acc)
                |otherwise       = sum_del1 x (inc n) acc
--задание 8
sum_del::Int -> Int
sum_del x = sum_del1 x 1 0

sum_del1::Int -> Int -> Int -> Int
sum_del1 x n acc|n == x          = acc + n
                |modf1 x n == 0  = sum_del1 x (inc n) (acc + n)
                |otherwise       = sum_del1 x (inc n) acc

--задание 9 1-простое и 0 - составное
prime::Int->Int
prime x = prost x 2 0

prost::Int-> Int -> Int ->Int 
prost x n acc |acc /= 0         = 0
              |x == 1     = error("digit >= 2") 
              |n >= (x-1)       = 1
              |modf1 x n == 0   = prost x (inc n) n
              |otherwise        = prost x (inc n) 0


--задание 10
pnd::Int -> Int
pnd x = kol_prost x 2 0

kol_prost:: Int -> Int -> Int -> Int
kol_prost x n acc |(x + 1) == n     = acc
                  |modf1 x n == 0   = kol_prost x (inc n) (acc + (prime n))
                  |otherwise        = kol_prost x (inc n) acc

--задание 11
nod::Int -> Int -> Int
nod x y = nod1 x y (max2 x y)

nod1:: Int -> Int -> Int -> Int
nod1 x y n | (modf1 x n == 0 && modf1 y n == 0)  = n
           | n == 0                              = -1
           | otherwise                           = nod1 x y (dec n)

--задание 12

nok::Int -> Int -> Int
nok x y = nok1 x y (max2 x y)

nok1:: Int -> Int -> Int -> Int
nok1 x y n | (modf1 n x == 0 && modf1 n y == 0)  = n
           | otherwise                           = nok1 x y (inc n)

--задание 13
m::(Int->Int->Int)->Int->Int->Int
m g t x | g t x ==0 = t
        | otherwise = m g (t+1) x

minimiz::(Int->Int->Int)->Int->Int
minimiz g x = m g 0 x

function::Int -> Int -> Int
function t x = 4*t - 2*x 

--main=print(minimiz (function) 24)
--main = print (zip [2..100] $ map pnd [2..100])
--main = print (zip [2..100] $ map pnd [2..100])
