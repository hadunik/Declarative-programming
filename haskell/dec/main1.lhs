\begin{code}
import AnGeo
import Lines
import LinesPlanes

--main = print( rectangularParallelepiped ( Paral (Vc 0 0 0) (Vc 1 0 0) (Vc 0 1 0) (Vc 0 0 1) ))

--main = print( proverka ( CPl 2 1 (-1) (-1)) ( CPl 1 3 (-2) 0))

--main = print( lineIntersectionOf2Planes (Pl (Vc 5 3 7) (Vc 5 0 0)) (Pl (Vc 2 7 5) (Vc 0 5 0)))

--main = print( lineIntersectionOf2Planes (Pl (Vc 0 0 0) (Vc 43 23 1)) (Pl (Vc 0 0 0) (Vc 1 1 1)))

--main = print( pointToCPLaneDistance (Pt 45 3 54) (CPl 3 4 1 5) )

--main = print( pointToPLaneDistance (Pt 45 3 54) (Pl (Vc 0 0 0) (Vc 3 2 1) ) )

--main = print( lineAndPlaneAngle (Ln (Vc 1 1 1) (Vc 1 1 1)) (Pl (Vc 0 0 0) (Vc 3 2 1) ) )

--main = print( planeAngle (Pl (Vc 0 0 0) (Vc 43 23 1)) (Pl (Vc 0 0 0) (Vc 1 1 1)) )

--main = print( lineAndPlanePerp (Ln (Vc 1 1 1) (Vc 1 1 1)) (Pl (Vc 0 0 0) (Vc 1 1 1) ) )

--main = print( lineAndPlaneParall (Ln (Vc 1 1 1) (Vc 1 1 1)) (Pl (Vc 0 0 0) (Vc 1 1 1) ) )

--main = print( cplanePerp (CPl 0 0 0 0) (CPl 1 0 0 0) )

--main = print( planePerp (Pl (Vc 0 0 0) (Vc 43 23 1)) (Pl (Vc 0 0 0) (Vc 1 1 1) ) )

--main = print( cplaneParall (CPl 0 0 0 0) (CPl 1 0 0 0) )

--main = print( planeParall (Pl (Vc 0 0 0) (Vc 43 23 1)) (Pl (Vc 0 0 0) (Vc 1 1 1) ))

--main = print( lineAndPlaneAngle (Ln (Vc 1 1 1) (Vc 1 1 1)) ( Pl (Vc 0 0 0) (Vc 0 0 1) ))

--main = print( lineOnCPlane (Ln (Vc 1 1 1) (Vc 1 1 1)) (CPl 1 1 1 1)) 

--main = print( lineOnPlane (Ln (Vc 1 1 1) (Vc 1 1 1)) (Pl (Vc 0 0 0) (Vc 0 0 1) ) )

--main = print( pointOnCPlane (Pt 0 0 0) (CPl 0 0 0 0) )

--main = print( pointOnPlane (Pt 0 0 0) (Pl (Vc 0 0 0) (Vc 0 0 1) ) )

--main = print( CPl 1 2 3 4 )

--main = print( cplaneToPlane (CPl 1 1 1 1))

--main = print( planeToCPlane (Pl (Vc 0 0 0) (Vc 0 0 1) ))

--main = print( planeFrom2Lines (Ln (Vc 10 10 10) (Vc 1 2 3)) (Ln (Vc 0 34 0) (Vc 32 2 2)))

--main = print( planeFrom3Points (Pt 0 0 0) (Pt 1 0 0) (Pt 0 1 0) )

--main = print( Ln (Vc 1 1 1) (Vc 3 3 3))

--main = print( skewLinesDistance (Ln (Vc 10 10 10) (Vc 1 2 3)) (Ln (Vc 0 34 0) (Vc  32 2 2)))

--main = print( pointToLineDistance (Pt 100 100 100) (Ln (Vc 1 1 1) (Vc 3 1 1)))

--main = print( lineAngle (Ln (Vc 1 1 1) (Vc 1 2 3)) (Ln (Vc 1 1 1) (Vc 32 2 0)))

--main = print( uY <> (Vc 3 3 3))

--main = print( pls (Vc 0 0 0) (Vc 1 2 3))

\end{code}


