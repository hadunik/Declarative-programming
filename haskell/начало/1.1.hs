temp:: Double -> Double 
temp x = x**2 - 2**x

f:: Double -> Double -> Double
f x1 x2 = (x1 + x2)/2

temp1:: Double -> Double -> Double -> Double
temp1 a b eps = if (temp a == 0) then a
    else if (temp b == 0) then b
    else if (temp a * temp (f a b)) < 0 then 
        solver a (f a b) eps 
    else 
        if (temp (f a b) * temp b) < 0 then 
            solver (f a b) b eps
        else 
            f a b
solver:: Double -> Double -> Double -> Double
solver x1 x2 eps = if (x2 - x1) > eps then 
        temp1 x1 x2 eps
    else 
        f x1 x2
 
main = print(solver 3 6 0.1)