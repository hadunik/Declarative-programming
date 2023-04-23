{-# UnicodeSyntax #-}

\section{Прямые и плоскости в 3-мерном пространстве}

\begin{code}

module LinesPlanes where

import AnGeo
import Lines
-- import Data.Semigroup
-- import Data.Monoid

\end{code}


Зададим тип данных "плоскость", задаваемый скалярным произведением:
$$
(\vec{r}_0 - \vec{r}) \cdot \vec{n} = 0,	
$$
т.е. описываем точки плоскости в которые приходит радиус-вектор $\vec{r}$ с помощью радиус-вектора начальной точки $\vec{r}_0$ и нормали $\vec{n}$.

\begin{code}
data Plane = Pl {mo, normal :: Vec} deriving (Read)
\end{code}

Зададим тип данных "каноническое уравнение плоскости" в соответствии с каноническим уравнением плоскости:
$$
Ax + By + Cz + D = 0.
$$

\begin{code}
data CPlane = CPl {aa,bb,cc,dd :: Double} deriving (Read)
\end{code}

Зададим функцию нахождения нормали для плоскости, заданной в канонической форме

\begin{code}
normalForCPlane :: CPlane -> Vec
normalForCPlane (CPl a b c _) = Vc a b c
-- normalForCPlane (CPl a b c d) = Vc a b c
\end{code}

Зададим функции-конструкторы плоскости:

\begin{code}
planeFromPointAndVec :: Point -> Vec -> Plane
planeFromPointAndVec p u = Pl (fromPoint p) u
\end{code}

(неплохо бы обдумать вырожденные случаи)

\begin{code}
planeFrom3Points :: Point -> Point -> Point -> CPlane
planeFrom3Points (Pt x1 y1 z1) (Pt x2 y2 z2) (Pt x3 y3 z3) = CPl
    (z3*(y2-y1)+z2*(y3+y1)+z1*(y3-y2))
    (z2*(x3-x1)-z3*(x1+x2))
    (x1*(y2-y3)+x2*(y3-y1)+x3*(y3-y2))
    (x1*y3*z2-x1*y2*z3+x2*y1*z3+x3*y1*z2+x3*y2*z1)
\end{code}


\begin{code}
planeFrom2Lines :: Line -> Line -> CPlane
planeFrom2Lines l1 l2 = CPl 
    ((vy $ dir l1)*(vz $ dir l2) - (vy $ dir l2)*(vz $ dir l1) )
    ((vx $ dir l1)*(vz $ dir l2) - (vx $ dir l2)*(vz $ dir l1) )
    ((vx $ dir l1)*(vy $ dir l2) - (vx $ dir l2)*(vy $ dir l1) )
    (
        (-1) * (vx $ ro l2 ) * ((vy $ dir l1)*(vz $ dir l2) - (vy $ dir l2)*(vz $ dir l1)) +
        (-1) * (vy $ ro l2 ) * ((vx $ dir l1)*(vz $ dir l2) - (vx $ dir l2)*(vz $ dir l1)) -
        (-1) * (vz $ ro l2 ) * ((vx $ dir l1)*(vy $ dir l2) - (vx $ dir l2)*(vy $ dir l1))
    )
\end{code}

Преобразование типов плоскостей:

\begin{code}
planeToCPlane :: Plane -> CPlane
planeToCPlane (Pl mo n) = CPl 
    (vx n)
    (vy n)
    (vz n)
    ((-1) * ( sprod mo n ))
\end{code}

begin{code}
cplaneToPlane :: CPlane -> Plane
cplaneToPlane (CPl aa bb cc dd) = Pl (Vc (aa/vecLength(nor)) (bb/vecLength(nor)) (cc/vecLength(nor)) ) nor
    where nor = (Vc aa bb cc)
end{code}

\begin{code}
cplaneToPlane :: CPlane -> Plane
cplaneToPlane (CPl aa bb cc dd) = Pl ( ((-dd) / (sprod nor nor)) `kprod` (nor) ) (nor)
    where nor = (Vc aa bb cc)
\end{code}

Красивое отображение канонической плоскости в виде уравнения:

\begin{code}
instance Show CPlane where
  show (CPl aa bb cc dd)  = (show aa)++ "x + " ++ (show bb)++ "y + " ++ (show cc)++ "z + " ++ (show dd) 
instance Show Plane where
  show (Pl v1 v2)  = (show v1)++ " & " ++ (show v2) 
\end{code}

Проверка принадлежености точки плоскости (в обеих формах)

\begin{code}
pointOnPlane :: Point -> Plane -> Bool
pointOnPlane p pl = pointOnCPlane p (planeToCPlane pl)

pointOnCPlane :: Point -> CPlane -> Bool
pointOnCPlane p cpl = (  (aa $ cpl)*(px $ p) + (bb $ cpl)*(py $ p) + (cc $ cpl)*(pz $ p) + (dd $ cpl) == 0  )
\end{code}

Проверка принадлежености прямой плоскости



\begin{code}

lineOnPlane :: Line -> Plane -> Bool
lineOnPlane l pl = lineOnCPlane l (planeToCPlane pl)

lineOnCPlane :: Line -> CPlane -> Bool
lineOnCPlane l cpl = if
    ( 
    ( (aa $ cpl)*(vx $ dir $ l) + (bb $ cpl)*(vy $ dir $ l) + (cc $ cpl)*(vz $ dir $ l) == 0) && 
    ( (aa $ cpl)*(vx $ ro $ l) + (aa $ cpl)*(vy $ ro $ l) + (aa $ cpl)*(vz $ ro $ l) + (dd $ cpl) == 0 )
    )
    then True
    else False
\end{code}

Проверка совпадения двух плоскостей


\begin{code}
instance Eq Plane where
    pl1 == pl2 = 
        (planeToCPlane pl1 ) == (planeToCPlane pl2 )

instance Eq CPlane where
    cpl1 == cpl2 =  
        ( 
            (aa $ cpl1) / (aa $ cpl2) == (bb $ cpl1) / (bb $ cpl2) &&
            (cc $ cpl1) / (cc $ cpl2) == (dd $ cpl1) / (dd $ cpl2) &&
            (aa $ cpl1) / (aa $ cpl2) == (cc $ cpl1) / (cc $ cpl2)
        ) 
\end{code}

Проверка параллельности двух плоскостей

\begin{code}
planeParall :: Plane -> Plane -> Bool
planeParall pl1 pl2 = (normal $ pl1) ¦¦ (normal $ pl2) 


cplaneParall :: CPlane -> CPlane -> Bool
cplaneParall cpl1 cpl2 = 
    (aa $ cpl1) / (aa $ cpl2) == (bb $ cpl1) / (bb $ cpl2) &&
    (bb $ cpl1) / (bb $ cpl2) == (cc $ cpl1) / (cc $ cpl2)
\end{code}

Проверка перпедикулярности двух плоскостей

\begin{code}
planePerp :: Plane -> Plane -> Bool
planePerp p1 p2 = (normal p1) `perp` (normal p2)

cplanePerp :: CPlane -> CPlane -> Bool
cplanePerp cpl1 cpl2 = (aa $ cpl1) * (aa $ cpl2) + (bb $ cpl1) * (bb $ cpl2) + (cc $ cpl1) * (cc $ cpl2) == 0 

\end{code}



Проверка параллельности прямой и плоскости

\begin{code}
lineAndPlaneParall :: Line -> Plane -> Bool
lineAndPlaneParall line plane = (dir line) ┴ (normal plane)
\end{code}

Проверка перпедикулярности прямой и плоскости

\begin{code}
lineAndPlanePerp :: Line -> Plane -> Bool
lineAndPlanePerp l pl = (dir $ l) ¦¦ (normal $ pl)
\end{code}

Нахождение угла между плоскостями (в градусах бы)...

\begin{code}
planeAngle :: Plane -> Plane  -> Double
planeAngle pl1 pl2 = if (
        (180/pi) * acos ( abs ((normal pl1) `sprod` (normal pl2)) /  ( vecLength (normal pl1) * vecLength (normal pl2)) ) == 0
    )
    then
        90
    else 
        (180/pi) * acos ( abs ((normal pl1) `sprod` (normal pl2)) /  ( vecLength (normal pl1) * vecLength (normal pl2)) )
\end{code}

Нахождение угла между прямой и плоскостью (в градусах бы)...

\begin{code}
lineAndPlaneAngle :: Line -> Plane  -> Double
lineAndPlaneAngle l pl = if(
        (180/pi) * acos ( abs ((normal pl) `sprod` (dir l)) /  ( vecLength (normal pl) * vecLength (dir l))) == 0
    )
    then 
        90
    else 
        (180/pi) * acos ( abs ((normal pl) `sprod` (dir l)) /  ( vecLength (normal pl) * vecLength (dir l)))
\end{code}

Нахождение расстояния между точкой и плоскостью

\begin{code}
pointToPLaneDistance :: Point -> Plane -> Double
pointToPLaneDistance p pl = pointToCPLaneDistance p (planeToCPlane pl)

pointToCPLaneDistance :: Point -> CPlane -> Double
pointToCPLaneDistance p cpl = abs( (aa $ cpl)*(px $ p) + (bb $ cpl)*(py $ p) + (cc $ cpl)*(pz $ p) + (dd $ cpl)) / 
    sqrt( (aa $ cpl)*(aa $ cpl) + (bb $ cpl)*(bb $ cpl) + (cc $ cpl)*(cc $ cpl) )
\end{code}

Нахождение линии пересечения двух плоскостей, заданных уравнением...

\begin{code}
lineIntersectionOf2Planes :: Plane -> Plane -> Line
lineIntersectionOf2Planes pl1 pl2 = Ln 
    (Vc
        ( (vy $ temp) / (vz $ temp) + (vx $ temp) / (vz $ temp) * 2)
        ( -(vx $ temp) / (vz $ temp) + (vy $ temp) / (vz $ temp) * 2)
        2
    ) 
    temp
    where temp = (vprod (normal pl1) (normal pl2))

proverka:: CPlane -> CPlane ->Line
proverka cpl1 cpl2 = lineIntersectionOf2Planes (cplaneToPlane cpl1) (cplaneToPlane cpl2)
\end{code}


\begin{code}
data Parallelepiped = Paral {rpo,xo,yo,zo :: Vec} deriving (Read)
\end{code}

\begin{code}

rectangularParallelepiped :: Parallelepiped -> Bool 
rectangularParallelepiped paral = (xo paral `perp` yo paral) && (xo paral `perp` zo paral) && (yo paral `perp` zo paral) 

\end{code}

