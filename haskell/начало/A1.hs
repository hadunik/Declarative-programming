
f411c x =  (x^2 -1) / (2*x^2 - x - 1)

limit' e n = if ((f411c n) - (1 / 2)) < e
                then f411c n
                else limit' e (n+1)
limit e = limit' e 1

main 