f :: Double -> Double -> Double -> Double
f a b eps = if b - a > eps then do 
	if f1 a * f1 ((a+b)/2) < 0
    then f a (f2 a b) eps 
    else do if (f1 b > 0 && f1 (f2 a b) < 0)||(f1 b < 0 && f1 (f2 a b) > 0)
        then f (f2 a b) b eps
        else f2 a b
    else f2 a b
f1 :: Double -> Double
f1 x = 2 ** x - x ** 2

f2::Double -> Double -> Double
f2 a b = (a + b)/2

f3:: Double -> Double -> Double
f3 a b = b - a

main = print(f 0 4 0.5)