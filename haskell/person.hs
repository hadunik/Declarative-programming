import Data.Char
import System.IO  
import Control.Monad

{-Для проверки 2 части задания нужно раскомментить и закомментить 1 main  ᓚᘏᗢ
¯\_( ͡° ͜ʖ ͡°)_/¯
-}

data Person = Per { name::String, age::Int, weight::Double} deriving (Eq,Show,Read)

makePerson::Person
makePerson = Per "QQQQ" 13 50.2

{-
main = do 
    let p1 = makePerson
    writeFile "test.txt" (show p1)
    s <- readFile "test.txt"
    let p2 = (read s) :: Person
    print(p2)-}


-------------------------------------часть 2 
pasreFile::String -> String -> String -> Person
pasreFile s1 s2 s3 |((head s1 == 'n') && (head s2 == 'a'))  = Per (parseName s1) (parseAge s2) (parseWeight s3)
                   |((head s1 == 'n') && (head s2 == 'w'))  = Per (parseName s1) (parseAge s3) (parseWeight s2)
                   |((head s1 == 'a') && (head s2 == 'n'))  = Per (parseName s2) (parseAge s1) (parseWeight s3)
                   |((head s1 == 'a') && (head s2 == 'w'))  = Per (parseName s3) (parseAge s1) (parseWeight s2)
                   |((head s1 == 'w') && (head s2 == 'n'))  = Per (parseName s2) (parseAge s3) (parseWeight s1)
                   |otherwise                               = Per (parseName s3) (parseAge s2) (parseWeight s1)

parseName::String -> String
parseName xs = init $ tail $ drop 7 xs ::String

parseAge::String -> Int
parseAge xs = (read((words xs) !! 2))::Int

parseWeight::String -> Double 
parseWeight xs = (read((words xs) !! 2))::Double

main = do  
    handle <- openFile "test.txt" ReadMode
    s1 <- hGetLine handle
    s2 <- hGetLine handle
    s3 <- hGetLine handle
    hClose handle
    let ans = pasreFile s1 s2 s3
    writeFile "test.txt" (show ans)
    print(pasreFile s1 s2 s3)


