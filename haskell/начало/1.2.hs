f' :: Double -> Int -> Double
f' x n = f x n 1 0 1

f :: Double -> Int -> Int -> Double -> Double -> Double

f x n i acc l = if ((fromIntegral(i)/2) > fromIntegral(n)) then 
                   acc
              else if (l > 0) then
                       f x n (i+2) (acc + (x**fromIntegral(i))/fromIntegral(i)) (l - 2)
                   else
                       f x n (i+2) (acc - (x**fromIntegral(i))/fromIntegral(i)) (l + 2)


main = print(f' 0.4 50)