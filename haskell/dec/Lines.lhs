{-# UnicodeSyntax #-}

\section{Прямые в 3-мерном пространстве}

\begin{code}

module Lines where

import AnGeo
-- import Data.Semigroup
-- import Data.Monoid

\end{code}


Зададим тип данных "прямая" в соответствии с параметрическим векторным уравнением прямой:
$\vec{r} = \vec{r}_0 + \vec{a}t$.

\begin{code}
data Line = Ln {ro, dir :: Vec} deriving (Read)
\end{code}

Зададим функции-конструкторы прямой линии:

\begin{code}
lineFromPointAndVec :: Point -> Vec -> Line
lineFromPointAndVec p a = Ln (fromPoint p)  a

lineFrom2Points :: Point -> Point -> Line
lineFrom2Points p q = lineFromPointAndVec p (fromOrSeg (OrS p q))
\end{code}

(неплохо бы обдумать вырожденные случаи)

Проверка принадлежености точки прямой линии

\begin{code}
pointOnLine :: Point -> Line -> Bool
pointOnLine p l = (fromOrSeg (OrS p q)) ¦¦
  (dir l) where q = toPoint $ ro l
\end{code}

Проверка совпадения двух прямых линий

\begin{code}
instance Eq Line where
  l1 == l2 = ((dir l1) ¦¦ (dir l2)) && 
               ((toPoint $ ro l1) `pointOnLine` l2) && 
               ((toPoint $ ro l2) `pointOnLine` l1)
-- Наверно, проверка ((toPoint $ ro l2) `pointOnLine` l1) уже лишняя
\end{code}

Проверка параллельности двух прямых линий

\begin{code}
lineParall :: Line -> Line -> Bool
lineParall l1 l2 = (dir l1) `coll` (dir l2)
\end{code}

Проверка перпендикулярности двух прямых линий

\begin{code}
linePerp :: Line -> Line -> Bool
linePerp l1 l2 = (dir l1) `perp` (dir l2)
\end{code}

Нахождение угла между прямыми (в градусах бы)

Attention!!! функция выдаёт косинус

\begin{code}
lineAngle:: Line -> Line -> Double
lineAngle l1 l2 = if 
        ( (180/pi) * acos (((dir l1) `sprod` (dir l2)) / ( vecLength (dir l1) * vecLength (dir l2))) == 0 )
    then 
        90 
    else 
        (180/pi) * acos (((dir l1) `sprod` (dir l2)) / ( vecLength (dir l1) * vecLength (dir l2)))
\end{code}



Нахождение расстояния между точкой и прямой в пространстве

\begin{code}
pointToLineDistance :: Point -> Line -> Double
pointToLineDistance p l = vecLength ((dir l) `vprod` (Vc ((px p) - (vx $ ro l)) ((py p) - (vy $ ro l)) ((pz p) - (vz $ ro l)))) / (vecLength ( dir l))
\end{code}


Нахождение расстояния между двумя скрещивающимися прямыми

\begin{code}
skewLinesDistance :: Line -> Line -> Double
skewLinesDistance l1 l2 = abs(mixprod 
    (Vc ((vx $ ro $ l2) - (vx $ ro $ l1)) ((vy $ ro $ l2) - (vy $ ro $ l1)) ((vz $ ro $ l2) - (vz $ ro $ l1))) 
    (dir l1) 
    (dir l2)) 
    /
    (vecLength (vprod (dir l1) (dir l2)))
\end{code}



Красивое отображение прямой линии в виде уравнения
Параметрическое уравнение прямой

\begin{code}
instance Show Line where
  show (Ln ro dir) = "(x;y;z) = " ++ (show ro) ++ " + a*" ++ (show dir)  
\end{code}
