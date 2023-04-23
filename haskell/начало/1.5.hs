start::Integer -> Integer
start n = fib n 0 1

fib::Integer->Integer->Integer->Integer
fib n x1 x2 = if (n == 0)
              then x2
              else fib (n-1) x2 (x1+x2)

main = print(start 1000000)