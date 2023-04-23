prog:: Double ->Double ->Double ->Double

prog b q n = b * (q**n - 1) / (q - 1)

bq:: Double ->Double ->Double ->Double
bq b q n = b * q**(n-1)

limit:: Double ->Double ->Double ->Double ->Double 
limit b q n e = if bq b q n > e 
                then limit b q (n+1) e
                else prog b q n

main = print$ limit 2 0.5 3 10