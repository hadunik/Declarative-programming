prog:: Double -> Double -> Double -> Double

prog b q 0 = b
prog b q n = b * q**n + prog b q (n-1)
