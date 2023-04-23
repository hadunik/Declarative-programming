import Barans
import Control.Monad
import Data.List
import Data.Maybe

----------------------task 1
grandfather':: Sheep -> Maybe Sheep
grandfather' = mother >=> father 
----------------------task 2
grandgrandfather::Sheep -> Maybe Sheep
grandgrandfather = mother >=> father >=> father

----------------------task 3


parents' p xs = map fromJust $ filter (isJust) (map p xs) 

parents = (sort.nub) $ (parents' mother names) ++ (parents' father names)

----------------------task 4
sirota::Sheep -> Bool
sirota s = isNothing $ father s `mplus` mother s 


----------------------task 5
select_Father::Sheep -> Maybe Sheep
select_Father s = (father >=> isSelected) s



isSelected s = find ( == s) selected_barans

--select_Father s xs = if (father s) `elem` map Just xs then (father s) else Nothing

----------------------task 6
listOfMans s = map fromJust $ tail $ takeWhile (isJust) $ iterate ( >>= father ) (return s)

find_select = find (isJust.isSelected)

nearestMan = find_select.listOfMans

--main = print(nearestMan "i3") 
--main = print(select_Father "i11")
--main = print(sirota "i7")
main = print( parents )
--main = print( names )
--main = print( grandgrandfather "i12")
--main = print( grandfather' "i10")

selected_barans = ["i3", "i5", "i6", "i9", "i12"]

{--
                      i12
          i10, i11
      i8           i9         i6
   i3    i7     i3   i5    i4    i5
i1    i2

--}



--parentsM [] = [] 
--parentsM (x:xs) = if mother x == Nothing then parentsM xs else mother x : parentsM xs

--parentsF [] = [] 
--parentsF (x:xs) = if father x == Nothing then parentsF xs else father x : parentsF xs    