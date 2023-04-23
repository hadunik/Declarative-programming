import qualified Data.Map as Mapp
import qualified Data.List as Listt

data ATree a = ALeaf a | ABranch (ATree a) a (ATree a)
    deriving (Show, Read)

--дерево 1.5
t0 = ABranch (ABranch (ABranch (ALeaf 46) 22 (ABranch (ALeaf 62) 43 (ALeaf 66))) 2 (ALeaf 21)) 1 (ABranch (ALeaf 35) 3 (ALeaf 34))

--дерево 1
t62 = ALeaf 62
t66 = ALeaf 66
t43 = ABranch t62 43 t66
t46 = ALeaf 46
t22 = ABranch t43 22 t46
t21 = ALeaf 21
t2 = ABranch t21 2 t22

t34 = ALeaf 34
t35 = ALeaf 35
t3 = ABranch t34 3 t35
t1 = ABranch t2 1 t3

-- задание 1
summ (ALeaf a) = a
summ (ABranch l val r) = val + summ l + (summ r)

--задание 4
zadanie4 node@(ABranch l _ r) = zadanie4 l ++ (node : zadanie4 r)
zadanie4 a@(ALeaf _) = [a]


value (ALeaf a) = a
value (ABranch l v r) = v 


--задание 2
writ1 node@(ABranch l _ r) xs = writ1 l (node : writ1 r xs) 
writ1 a@(ALeaf _) xs = a : xs

arr = map value $ writ1 t1 []


otsort = Listt.filter (\a -> (a `mod` 2 == 0) ) arr

--задание 5
compar:: Eq a => ATree a -> ATree a -> Bool
compar (ABranch l1 val1 r1) (ABranch l2 val2 r2) = (val1 == val2) && (compar l1 l2) && (compar r1 r2) || (val1 == val2) && (compar l1 r2) && (compar r1 l2)
compar (ALeaf a) (ALeaf b) = (a == b)
compar _ _ = False

--main = print(zadanie4 t1)
--main = print (compar t1 t0)
--main = print (map value $ writ t1)
--main = print(map value $ writ1 t1 [] )















data Gender = F | M deriving (Read, Show, Eq)

listName   = ["Olya", "Helen", "Kate", "Alex", "Pasha", "Sasha", "Sasha", "Masha", "Nadya", "Emma"] :: [String]
listID     = [131,   132,    134,    135,    136,    137,    138,    139,    140,    141] :: [Int]
listGender = [F,     F,      F,      M,      M,      M,      F,      F,      F,      F] :: [Gender]
listAge    = [17,    18,     17,      19,    18,     19,     21,     19,     18,     20] :: [Int]
listFrends = [True,  False,  True,   False,  False,  True,   False,  True,   True,   False] :: [Bool]

array = Mapp.fromList $ Listt.zip listID $ Listt.zip4 listName listGender listAge listFrends

--Сделать из неё выборку всех юношей, сделать из неё выборку ключей, соответствующих этим юношам.
--В качестве ответа вывести список пар (id,имя)

for_ans = Mapp.filter (\(_,gender,_,_) -> (gender == M)) array
--задание 2.1
for_ans' = Mapp.map (\(name,_,_,_) -> name) for_ans

--for_ans'' = Mapp.mapKeys (+100000) for_ans'

--main = print( Mapp.toList for_ans' )
main = print( Mapp.toList array )
