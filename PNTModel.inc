#BeginMacro(DuringActionPotential)
time > 205 and time < 995
#EndMacro
#BeginMacro(NotDuringActionPotential)
(time <= 205 or time >= 995)
#EndMacro
#BeginMacro(CaIonChannelsAreOpenWRTCalciumLayer)
time > 605 and time < 1395
#EndMacro
#BeginMacro(CaIonChannelsAreClosedWRTMainLayer)
(time <= 605 or time >= 1395)
#EndMacro
#BeginMacro(CaIonChannelsAreOpenWRTMainLayer)
time > 605 and time < 1395
#EndMacro
#BeginMacro(CellIsInTopWallIncCorners)
cellPos(0) = 0 and cellPos(1) >= 0 and cellPos(1) <= 29 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsInLeftWallNotIncCorners)
cellPos(1) = 0 and cellPos(0) > 0 and cellPos(0) < 29 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsInRightWallNotIncCorners)
cellPos(1) = 29 and cellPos(0) > 0 and cellPos(0) < 29 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsInBottomWallIncCorners)
cellPos(0) = 29 and ((cellPos(1) >= 0 and cellPos(1) <= 6) or (cellPos(1) >= 23 and cellPos(1) <= 29) or (cellPos(1) = 8 or cellPos(1) = 9 or cellPos(1) = 20 or cellPos(1) = 21)) and cellPos(2) = 0
#EndMacro 
#BeginMacro(CellIsInCaIonChannel)
cellPos(0) = 29 and (cellPos(1) = 7 or cellPos(1) = 22) and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsAdjacentToCaIonChannel)
cellPos(0) = 28 and (cellPos(1) = 7 or cellPos(1) = 22) and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsNearCaIonChannel)
cellPos(0) = 28 and (cellPos(1) = 6 or cellPos(1) = 8 or cellPos(1) = 21 or cellPos(1) = 23) and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsSEFluidCornerForCalciumLayer)
cellPos(0) = 28 and cellPos(1) = 28 and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsSWFluidCornerForCalciumLayer)
cellPos(0) = 28 and cellPos(1) = 1 and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsNWFluidCornerForCalciumLayer)
cellPos(0) = 1 and cellPos(1) = 1 and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsNEFluidCornerForCalciumLayer)
cellPos(0) = 1 and cellPos(1) = 28 and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsTopRowFluidForCalciumLayer)
cellPos(0) = 1 and (cellPos(1) >= 2 and cellPos(1) <= 27) and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsLeftRowFluidForCalciumLayer)
cellPos(1) = 1 and (cellPos(0) >= 2 and cellPos(0) <= 27) and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsBottomRowFluidForCalciumLayer)
cellPos(1) = 28 and (cellPos(0) >= 2 and cellPos(0) <= 27) and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsRightRowFluidForCalciumLayer)
cellPos(0) = 28 and (cellPos(1) >= 2 and cellPos(1) <= 27) and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsFirstInnerSquareFluidForCalciumLayer)
((cellPos(0) = 2 and cellPos(1) >= 2 and cellPos(1) <= 27) or
(cellPos(0) = 27 and cellPos(1) >= 2 and cellPos(1) <= 27) or
(cellPos(1) = 2 and cellPos(0) >= 2 and cellPos(0) <= 27) or
(cellPos(1) = 27 and cellPos(0) >= 2 and cellPos(0) <= 27)) and cellPos(2) = 2 
#EndMacro
#BeginMacro(CellIsSecondInnerSquareFluidForCalciumLayer)
((cellPos(0) = 3 and cellPos(1) <= 26 and cellPos(1) >= 3) or
(cellPos(0) = 26 and cellPos(1) <= 26 and cellPos(1) >= 3) or
(cellPos(1) = 3 and cellPos(0) >= 3 and cellPos(0) <= 26) or
(cellPos(1) = 26 and cellPos(0) >= 3 and cellPos(0) <= 26)) and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsInteriorFluidForCalciumLayer)
cellPos(0) > 3 and cellPos(0) < 26 and cellPos(1) > 3 and cellPos(1) < 26 and cellPos(2) = 2
#EndMacro
#BeginMacro(CellIsFluid)
(0,0,0) = 0 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsCaMFromE)
(0,0,0) = 31 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsCaMFromN)
(0,0,0) = 32 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsCaMFromW)
(0,0,0) = 33 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsCaMFromS)
(0,0,0) = 34 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsCaMKIIFromE)
(0,0,0) = 41 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsCaMKIIFromN)
(0,0,0) = 42 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsCaMKIIFromW)
(0,0,0) = 43 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsCaMKIIFromS)
(0,0,0) = 44 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsActivatedCaMFromE)
((0,0,0) > 31.39 and (0,0,0) < 31.41) and cellPos(2) = 0
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromE)
(0,1,0) > 31.39 and (0,1,0) < 31.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromN)
(-1,0,0) > 32.39 and (-1,0,0) < 32.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromW)
(0,-1,0) > 33.39 and (0,-1,0) < 33.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromS)
(1,0,0) > 34.39 and (1,0,0) < 34.41
#EndMacro
#BeginMacro(ApproachingCaMFromE)
(0,1,0) = 31
#EndMacro
#BeginMacro(ApproachingCaMFromN)
(-1,0,0) = 32
#EndMacro
#BeginMacro(ApproachingCaMFromW)
(0,-1,0) = 33
#EndMacro
#BeginMacro(ApproachingCaMFromS)
(1,0,0) = 34
#EndMacro
#BeginMacro(ApproachingCaMKIIFromE)
(0,1,0) = 41
#EndMacro
#BeginMacro(ApproachingCaMKIIFromN)
(-1,0,0) = 42
#EndMacro
#BeginMacro(ApproachingCaMKIIFromW)
(0,-1,0) = 43
#EndMacro
#BeginMacro(ApproachingCaMKIIFromS)
(1,0,0) = 44
#EndMacro
#BeginMacro(ApproachingParticleFromE)
trunc(remainder((0,1,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingParticleFromN)
trunc(remainder((-1,0,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingParticleFromW)
trunc(remainder((0,-1,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingParticleFromS)
trunc(remainder((1,0,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(HighCalciumContent)
(0,0,2) > 4
#EndMacro
#BeginMacro(FromEWinsOverNWS)
(0,1,1) < (-1,0,1) and (0,1,1) < (0,-1,1) and (0,1,1) < (1,0,1) 
#EndMacro
#BeginMacro(FromNWinsOverEWS)
(-1,0,1) < (0,1,1) and (-1,0,1) < (0,-1,1) and (-1,0,1) < (1,0,1)
#EndMacro
#BeginMacro(FromWWinsOverENS)
(0,-1,1) < (0,1,1) and (0,-1,1) < (-1,0,1) and (0,-1,1) < (1,0,1)
#EndMacro
#BeginMacro(FromSWinsOverENW)
(1,0,1) < (0,1,1) and (1,0,1) < (-1,0,1) and (1,0,1) < (0,-1,1)
#EndMacro
#BeginMacro(FromEWinsOverWS)
(0,1,1) < (0,-1,1) and (0,1,1) < (1,0,1)
#EndMacro
#BeginMacro(FromEWinsOverNS)
(0,1,1) < (-1,0,1) and (0,1,1) < (1,0,1)
#EndMacro
#BeginMacro(FromEWinsOverNW)
(0,1,1) < (-1,0,1) and (0,1,1) < (0,-1,1)
#EndMacro
#BeginMacro(FromNWinsOverWS)
(-1,0,1) < (0,-1,1) and (-1,0,1) < (1,0,1)
#EndMacro
#BeginMacro(FromNWinsOverES)
(-1,0,1) < (0,1,1) and (-1,0,1) < (1,0,1)
#EndMacro
#BeginMacro(FromNWinsOverEW)
(-1,0,1) < (0,1,1) and (-1,0,1) < (0,-1,1)
#EndMacro
#BeginMacro(FromWWinsOverNS)
(0,-1,1) < (-1,0,1) and (0,-1,1) < (1,0,1)
#EndMacro
#BeginMacro(FromWWinsOverES)
(0,-1,1) < (0,1,1) and (0,-1,1) < (1,0,1)
#EndMacro
#BeginMacro(FromWWinsOverEN)
(0,-1,1) < (0,1,1) and (0,-1,1) < (-1,0,1)
#EndMacro
#BeginMacro(FromSWinsOverNW)
(1,0,1) < (-1,0,1) and (1,0,1) < (0,-1,1)
#EndMacro
#BeginMacro(FromSWinsOverEW)
(1,0,1) < (0,1,1) and (1,0,1) < (0,-1,1)
#EndMacro
#BeginMacro(FromSWinsOverEN)
(1,0,1) < (0,1,1) and (1,0,1) < (-1,0,1)
#EndMacro
#BeginMacro(FromEWinsOverN)
(0,1,1) < (-1,0,1)
#EndMacro
#BeginMacro(FromEWinsOverW)
(0,1,1) < (0,-1,1)
#EndMacro
#BeginMacro(FromEWinsOverS)
(0,1,1) < (1,0,1)
#EndMacro
#BeginMacro(FromNWinsOverE)
(-1,0,1) < (0,1,1)
#EndMacro
#BeginMacro(FromNWinsOverW)
(-1,0,1) < (0,-1,1)
#EndMacro
#BeginMacro(FromNWinsOverS)
(-1,0,1) < (1,0,1)
#EndMacro
#BeginMacro(FromWWinsOverE)
(0,-1,1) < (0,1,1)
#EndMacro
#BeginMacro(FromWWinsOverN)
(0,-1,1) < (-1,0,1)
#EndMacro
#BeginMacro(FromWWinsOverS)
(0,-1,1) < (1,0,1)
#EndMacro
#BeginMacro(FromSWinsOverE)
(1,0,1) < (0,1,1)
#EndMacro
#BeginMacro(FromSWinsOverN)
(1,0,1) < (-1,0,1)
#EndMacro
#BeginMacro(FromSWinsOverW)
(1,0,1) < (0,-1,1)
#EndMacro
#BeginMacro(CellToEIsFluid)
(0,1,0) = 0
#EndMacro
#BeginMacro(CellToNIsFluid)
(-1,0,0) = 0
#EndMacro
#BeginMacro(CellToWIsFluid)
(0,-1,0) = 0
#EndMacro
#BeginMacro(CellToSIsFluid)
(1,0,0) = 0
#EndMacro
#BeginMacro(CellToEIsWall)
((0,1,0) = 5 or (0,1,0) = 8)  
#EndMacro
#BeginMacro(CellToNIsWall)
((-1,0,0) = 5 or (-1,0,0) = 8)
#EndMacro
#BeginMacro(CellToWIsWall)
((0,-1,0) = 5 or (0,-1,0) = 8)
#EndMacro
#BeginMacro(CellToSIsWall)
(1,0,0) >= 5 and (1,0,0) <= 8  
#EndMacro
#BeginMacro(ParticleApproachingAtWFromN)
trunc(remainder((-1,-1,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ParticleApproachingAtWFromW)
trunc(remainder((0,-2,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ParticleApproachingAtWFromS)
trunc(remainder((1,-1,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(FromEWinsAtWOverNWS)
(0,0,1) < (-1,-1,1) and (0,0,1) < (0,-2,1) and (0,0,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromNWinsAtWOverEWS)
(-1,-1,1) < (0,0,1) and (-1,-1,1) < (0,-2,1) and (-1,-1,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromWWinsAtWOverENS)
(0,-2,1) < (0,0,1) and (0,-2,1) < (-1,-1,1) and (0,-2,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromSWinsAtWOverENW)
(1,-1,1) < (0,0,1) and (1,-1,1) < (-1,-1,1) and (1,-1,1) < (0,-2,1)
#EndMacro
#BeginMacro(FromELosesAtWToNWS)
( (0,0,1) > (-1,-1,1) or (0,0,1) > (0,-2,1) or (0,0,1) > (1,-1,1) )
#EndMacro
#BeginMacro(FromEWinsAtWOverWS)
(0,0,1) < (0,-2,1) and (0,0,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromEWinsAtWOverNS)
(0,0,1) < (-1,-1,1) and (0,0,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromEWinsAtWOverNW)
(0,0,1) < (-1,-1,1) and (0,0,1) < (0,-2,1)
#EndMacro
#BeginMacro(FromELosesAtWToNW)
( (0,0,1) > (-1,-1,1) or (0,0,1) > (0,-2,1) )
#EndMacro
#BeginMacro(FromELosesAtWToNS)
( (0,0,1) > (-1,-1,1) or (0,0,1) > (1,-1,1) )
#EndMacro
#BeginMacro(FromELosesAtWToWS)
( (0,0,1) > (0,-2,1) or (0,0,1) > (1,-1,1) )
#EndMacro
#BeginMacro(FromNWinsAtWOverEW)
(-1,-1,1) < (0,0,1) and (-1,-1,1) < (0,-2,1)
#EndMacro
#BeginMacro(FromNWinsAtWOverES)
(-1,-1,1) < (0,0,1) and (-1,-1,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromNWinsAtWOverWS)
(-1,-1,1) < (0,-2,1) and (-1,-1,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromWWinsAtWOverEN)
(0,-2,1) < (0,0,1) and (0,-2,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromWWinsAtWOverES)
(0,-2,1) < (0,0,1) and (0,-2,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromWWinsAtWOverNS)
(0,-2,1) < (-1,-1,1) and (0,-2,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromSWinsAtWOverEN)
(1,-1,1) < (0,0,1) and (1,-1,1) < (-1,-1,1) 
#EndMacro
#BeginMacro(FromSWinsAtWOverEW)
(1,-1,1) < (0,0,1) and (1,-1,1) < (0,-2,1)  
#EndMacro
#BeginMacro(FromSWinsAtWOverNW)
(1,-1,1) < (-1,-1,1) and (1,-1,1) < (0,-2,1)
#EndMacro
#BeginMacro(FromEWinsAtWOverN)
(0,0,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromEWinsAtWOverW)
(0,0,1) < (0,-2,1)
#EndMacro
#BeginMacro(FromEWinsAtWOverS)
(0,0,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromELosesAtWToN)
(0,0,1) > (-1,-1,1)
#EndMacro
#BeginMacro(FromELosesAtWToW)
(0,0,1) > (0,-2,1)
#EndMacro
#BeginMacro(FromELosesAtWToS)
(0,0,1) > (1,-1,1)
#EndMacro
#BeginMacro(FromNWinsAtWOverE)
(-1,-1,1) < (0,0,1) 
#EndMacro
#BeginMacro(FromNWinsAtWOverW)
(-1,-1,1) < (0,-2,1)
#EndMacro
#BeginMacro(FromNWinsAtWOverS)
(-1,-1,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromWWinsAtWOverE)
(0,-2,1) < (0,0,1) 
#EndMacro
#BeginMacro(FromWWinsAtWOverN)
(0,-2,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromWWinsAtWOverS)
(0,-2,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromSWinsAtWOverE)
(1,-1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromSWinsAtWOverN)
(1,-1,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromSWinsAtWOverW)
(1,-1,1) < (0,-2,1)
#EndMacro
#BeginMacro(FromNWinsAtSOverEWS)
(0,0,1) < (1,1,1) and (0,0,1) < (1,-1,1) and (0,0,1) < (2,0,1)
#EndMacro
#BeginMacro(FromEWinsAtSOverNWS)
(1,1,1) < (0,0,1) and (1,1,1) < (1,-1,1) and (1,1,1) < (2,0,1)
#EndMacro
#BeginMacro(FromWWinsAtSOverENS)
(1,-1,1) < (1,1,1) and (1,-1,1) < (0,0,1) and (1,-1,1) < (2,0,1)
#EndMacro
#BeginMacro(FromSWinsAtSOverENW)
(2,0,1) < (1,1,1) and (2,0,1) < (0,0,1) and (2,0,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromNLosesAtSToEWS)
( (0,0,1) > (1,1,1) or (0,0,1) > (1,-1,1) or (0,0,1) > (2,0,1) )
#EndMacro
#BeginMacro(FromNWinsAtSOverWS)
(0,0,1) < (1,-1,1) and (0,0,1) < (2,0,1)
#EndMacro
#BeginMacro(FromNWinsAtSOverES)
(0,0,1) < (1,1,1) and (0,0,1) < (2,0,1)
#EndMacro
#BeginMacro(FromNWinsAtSOverEW)
(0,0,1) < (1,1,1) and (0,0,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromNLosesAtSToWS)
( (0,0,1) > (1,-1,1) or (0,0,1) > (2,0,1) )
#EndMacro
#BeginMacro(FromNLosesAtSToES)
( (0,0,1) > (1,1,1) or (0,0,1) > (2,0,1) )
#EndMacro
#BeginMacro(FromNLosesAtSToEW)
( (0,0,1) > (1,1,1) or (0,0,1) > (1,-1,1) )
#EndMacro
#BeginMacro(FromEWinsAtSOverNW)
(1,1,1) < (0,0,1) and (1,1,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromEWinsAtSOverNS)
(1,1,1) < (0,0,1) and (1,1,1) < (2,0,1)
#EndMacro
#BeginMacro(FromEWinsAtSOverWS)
(1,1,1) < (1,-1,1) and (1,1,1) < (2,0,1)
#EndMacro
#BeginMacro(FromWWinsAtSOverEN)
(1,-1,1) < (1,1,1) and (1,-1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromWWinsAtSOverES)
(1,-1,1) < (1,1,1) and (1,-1,1) < (2,0,1)
#EndMacro
#BeginMacro(FromWWinsAtSOverNS)
(1,-1,1) < (0,0,1) and (1,-1,1) < (2,0,1)
#EndMacro
#BeginMacro(FromSWinsAtSOverEN)
(2,0,1) < (1,1,1) and (2,0,1) < (0,0,1)
#EndMacro
#BeginMacro(FromSWinsAtSOverEW)
(2,0,1) < (1,1,1) and (2,0,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromSWinsAtSOverNW)
(2,0,1) < (0,0,1) and (2,0,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromNWinsAtSOverE)
(0,0,1) < (1,1,1)
#EndMacro
#BeginMacro(FromNWinsAtSOverW)
(0,0,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromNWinsAtSOverS)
(0,0,1) < (2,0,1)
#EndMacro
#BeginMacro(FromNLosesAtSToE)
(0,0,1) > (1,1,1)
#EndMacro
#BeginMacro(FromNLosesAtSToW)
(0,0,1) > (1,-1,1)
#EndMacro
#BeginMacro(FromNLosesAtSToS)
(0,0,1) > (2,0,1)
#EndMacro
#BeginMacro(FromEWinsAtSOverN)
(1,1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromEWinsAtSOverW)
(1,1,1) < (1,-1,1)
#EndMacro
#BeginMacro(FromEWinsAtSOverS)
(1,1,1) < (2,0,1)
#EndMacro
#BeginMacro(FromWWinsAtSOverE)
(1,-1,1) < (1,1,1)
#EndMacro
#BeginMacro(FromWWinsAtSOverN)
(1,-1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromWWinsAtSOverS)
(1,-1,1) < (2,0,1)
#EndMacro
#BeginMacro(FromSWinsAtSOverE)
(2,0,1) < (1,1,1)
#EndMacro
#BeginMacro(FromSWinsAtSOverN)
(2,0,1) < (0,0,1)
#EndMacro
#BeginMacro(FromSWinsAtSOverW)
(2,0,1) < (1,-1,1)
#EndMacro
#BeginMacro(ParticleApproachingAtSFromE)
trunc(remainder((1,1,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ParticleApproachingAtSFromW)
trunc(remainder((1,-1,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ParticleApproachingAtSFromS)
trunc(remainder((2,0,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(CellIsActivatedCaMFromN)
((0,0,0) > 32.39 and (0,0,0) < 32.41) and cellPos(2) = 0
#EndMacro
#BeginMacro(ParticleApproachingAtEFromE)
trunc(remainder((0,2,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ParticleApproachingAtEFromN)
trunc(remainder((-1,1,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ParticleApproachingAtEFromS)
trunc(remainder((1,1,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(FromWWinsAtEOverENS)
(0,0,1) < (0,2,1) and (0,0,1) < (-1,1,1) and (0,0,1) < (1,1,1)
#EndMacro
#BeginMacro(FromEWinsAtEOverNWS)
(0,2,1) < (0,0,1) and (0,2,1) < (-1,1,1) and (0,2,1) < (1,1,1)
#EndMacro
#BeginMacro(FromNWinsAtEOverEWS)
(-1,1,1) < (0,2,1) and (-1,1,1) < (0,0,1) and (-1,1,1) < (1,1,1)
#EndMacro
#BeginMacro(FromSWinsAtEOverENW)
(1,1,1) < (0,2,1) and (1,1,1) < (-1,1,1) and (1,1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromWLosesAtEToENS)
( (0,0,1) > (0,2,1) or (0,0,1) > (-1,1,1) or (0,0,1) > (1,1,1) )
#EndMacro
#BeginMacro(FromWWinsAtEOverNS)
(0,0,1) < (-1,1,1) and (0,0,1) < (1,1,1)
#EndMacro
#BeginMacro(FromWWinsAtEOverES)
(0,0,1) < (0,2,1) and (0,0,1) < (1,1,1)
#EndMacro
#BeginMacro(FromWWinsAtEOverEN)
(0,0,1) < (0,2,1) and (0,0,1) < (-1,1,1)
#EndMacro
#BeginMacro(FromWLosesAtEToNS)
( (0,0,1) > (-1,1,1) or (0,0,1) > (1,1,1) )
#EndMacro
#BeginMacro(FromWLosesAtEToES)
( (0,0,1) > (0,2,1) or (0,0,1) > (1,1,1) )
#EndMacro
#BeginMacro(FromWLosesAtEToEN)
( (0,0,1) > (0,2,1) or (0,0,1) > (-1,1,1) )
#EndMacro
#BeginMacro(FromEWinsAtEOverNW)
(0,2,1) < (-1,1,1) and (0,2,1) < (0,0,1) 
#EndMacro
#BeginMacro(FromEWinsAtEOverNS)
(0,2,1) < (-1,1,1) and (0,2,1) < (1,1,1)
#EndMacro
#BeginMacro(FromEWinsAtEOverWS)
(0,2,1) < (0,0,1) and (0,2,1) < (1,1,1)
#EndMacro
#BeginMacro(FromNWinsAtEOverEW)
(-1,1,1) < (0,2,1) and (-1,1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromNWinsAtEOverES)
(-1,1,1) < (0,2,1) and (-1,1,1) < (1,1,1)
#EndMacro
#BeginMacro(FromNWinsAtEOverWS)
(-1,1,1) < (0,0,1) and (-1,1,1) < (1,1,1)
#EndMacro
#BeginMacro(FromSWinsAtEOverEN)
(1,1,1) < (0,2,1) and (1,1,1) < (-1,1,1)
#EndMacro
#BeginMacro(FromSWinsAtEOverEW)
(1,1,1) < (0,2,1) and (1,1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromSWinsAtEOverNW)
(1,1,1) < (-1,1,1) and (1,1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromWWinsAtEOverE)
(0,0,1) < (0,2,1)
#EndMacro
#BeginMacro(FromWWinsAtEOverN)
(0,0,1) < (-1,1,1)
#EndMacro
#BeginMacro(FromWWinsAtEOverS)
(0,0,1) < (1,1,1)
#EndMacro
#BeginMacro(FromWLosesAtEToE)
(0,0,1) > (0,2,1)
#EndMacro
#BeginMacro(FromWLosesAtEToN)
(0,0,1) > (-1,1,1)
#EndMacro
#BeginMacro(FromWLosesAtEToS)
(0,0,1) > (1,1,1)
#EndMacro
#BeginMacro(FromEWinsAtEOverN)
(0,2,1) < (-1,1,1)
#EndMacro
#BeginMacro(FromEWinsAtEOverW)
(0,2,1) < (0,0,1)
#EndMacro
#BeginMacro(FromEWinsAtEOverS)
(0,2,1) < (1,1,1)
#EndMacro
#BeginMacro(FromNWinsAtEOverE)
(-1,1,1) < (0,2,1)
#EndMacro
#BeginMacro(FromNWinsAtEOverW)
(-1,1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromNWinsAtEOverS)
(-1,1,1) < (1,1,1)
#EndMacro
#BeginMacro(FromSWinsAtEOverE)
(1,1,1) < (0,2,1)
#EndMacro
#BeginMacro(FromSWinsAtEOverN)
(1,1,1) < (-1,1,1)
#EndMacro
#BeginMacro(FromSWinsAtEOverW)
(1,1,1) < (0,0,1)
#EndMacro
#BeginMacro(CellIsActivatedCaMFromW)
((0,0,0) > 33.39 and (0,0,0) < 33.41) and cellPos(2) = 0
#EndMacro
#BeginMacro(ParticleApproachingAtNFromE)
trunc(remainder((-1,1,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ParticleApproachingAtNFromN)
trunc(remainder((-2,0,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ParticleApproachingAtNFromW)
trunc(remainder((-1,-1,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(FromSWinsAtNOverENW)
(0,0,1) < (-1,1,1) and (0,0,1) < (-2,0,1) and (0,0,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromEWinsAtNOverNWS)
(-1,1,1) < (-2,0,1) and (-1,1,1) < (-1,-1,1) and (-1,1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromNWinsAtNOverEWS)
(-2,0,1) < (-1,1,1) and (-2,0,1) < (-1,-1,1) and (-2,0,1) < (0,0,1)
#EndMacro
#BeginMacro(FromWWinsAtNOverENS)
(-1,-1,1) < (-1,1,1) and (-1,-1,1) < (-2,0,1) and (-1,-1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromSLosesAtNToENW)
( (0,0,1) > (-1,1,1) or (0,0,1) > (-2,0,1) or (0,0,1) > (-1,-1,1) )
#EndMacro
#BeginMacro(FromSWinsAtNOverNW)
(0,0,1) < (-2,0,1) and (0,0,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromSWinsAtNOverEW)
(0,0,1) < (-1,1,1) and (0,0,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromSWinsAtNOverEN)
(0,0,1) < (-1,1,1) and (0,0,1) < (-2,0,1)
#EndMacro
#BeginMacro(FromSLosesAtNToNW)
( (0,0,1) > (-2,0,1) or (0,0,1) > (-1,-1,1) )
#EndMacro
#BeginMacro(FromSLosesAtNToEW)
( (0,0,1) > (-1,1,1) or (0,0,1) > (-1,-1,1) )
#EndMacro
#BeginMacro(FromSLosesAtNToEN)
( (0,0,1) > (-1,1,1) or (0,0,1) > (-2,0,1) )
#EndMacro
#BeginMacro(FromEWinsAtNOverNW)
(-1,1,1) < (-2,0,1) and (-1,1,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromEWinsAtNOverNS)
(-1,1,1) < (-2,0,1) and (-1,1,1) < (0,0,1) 
#EndMacro
#BeginMacro(FromEWinsAtNOverWS)
(-1,1,1) < (-1,-1,1) and (-1,1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromNWinsAtNOverEW)
(-2,0,1) < (-1,1,1) and (-2,0,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromNWinsAtNOverES)
(-2,0,1) < (-1,1,1) and (-2,0,1) < (0,0,1)
#EndMacro
#BeginMacro(FromNWinsAtNOverWS)
(-2,0,1) < (-1,-1,1) and (-2,0,1) < (0,0,1) 
#EndMacro
#BeginMacro(FromWWinsAtNOverEN)
(-1,-1,1) < (-1,1,1) and (-1,-1,1) < (-2,0,1)
#EndMacro
#BeginMacro(FromWWinsAtNOverES)
(-1,-1,1) < (-1,1,1) and (-1,-1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromWWinsAtNOverNS)
(-1,-1,1) < (-2,0,1) and (-1,-1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromSWinsAtNOverE)
(0,0,1) < (-1,1,1)
#EndMacro
#BeginMacro(FromSWinsAtNOverN)
(0,0,1) < (-2,0,1)
#EndMacro
#BeginMacro(FromSWinsAtNOverW)
(0,0,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromSLosesAtNToE)
(0,0,1) > (-1,1,1)
#EndMacro
#BeginMacro(FromSLosesAtNToN)
(0,0,1) > (-2,0,1)
#EndMacro
#BeginMacro(FromSLosesAtNToW)
(0,0,1) > (-1,-1,1)
#EndMacro
#BeginMacro(FromEWinsAtNOverN)
(-1,1,1) < (-2,0,1)
#EndMacro
#BeginMacro(FromEWinsAtNOverW)
(-1,1,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromEWinsAtNOverS)
(-1,1,1) < (0,0,1)
#EndMacro
#BeginMacro(FromNWinsAtNOverE)
(-2,0,1) < (-1,1,1)
#EndMacro
#BeginMacro(FromNWinsAtNOverW)
(-2,0,1) < (-1,-1,1)
#EndMacro
#BeginMacro(FromNWinsAtNOverS)
(-2,0,1) < (0,0,1)
#EndMacro
#BeginMacro(FromWWinsAtNOverE)
(-1,-1,1) < (-1,1,1)
#EndMacro
#BeginMacro(FromWWinsAtNOverN)
(-1,-1,1) < (-2,0,1)
#EndMacro
#BeginMacro(FromWWinsAtNOverS)
(-1,-1,1) < (0,0,1)
#EndMacro
#BeginMacro(CellIsActivatedCaMFromS)
((0,0,0) > 34.39 and (0,0,0) < 34.41) and cellPos(2) = 0
#EndMacro
#BeginMacro(CellToEIsNotFluid)
(0,1,0) != 0
#EndMacro
#BeginMacro(CellToNIsNotFluid)
(-1,0,0) != 0
#EndMacro
#BeginMacro(CellToWIsNotFluid)
(0,-1,0) != 0
#EndMacro
#BeginMacro(CellToSIsNotFluid)
(1,0,0) != 0
#EndMacro
#BeginMacro(CellToEIsCaMKII)
trunc(((0,1,0)+0.001)/10) = 4
#EndMacro
#BeginMacro(CellToNIsCaMKII)
trunc(((-1,0,0)+0.001)/10) = 4
#EndMacro
#BeginMacro(CellToWIsCaMKII)
trunc(((0,-1,0)+0.001)/10) = 4
#EndMacro
#BeginMacro(CellToSIsCaMKII)
trunc(((1,0,0)+0.001)/10) = 4
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfThreeCaMKIIs)
(0,0,3) < 0.9
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfTwoCaMKIIs)
(0,0,3) < 0.6
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfOneCaMKII)
(0,0,3) < 0.3
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfThreeActivatedCaMs)
(0,0,3) < 0.9
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfTwoActivatedCaMs)
(0,0,3) < 0.6
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfOneActivatedCaM)
(0,0,3) < 0.3
#EndMacro
#BeginMacro(ActivatedCaMApproachingAtSFromE)
(1,1,0) > 31.39 and (1,1,0) < 31.41
#EndMacro
#BeginMacro(ActivatedCaMApproachingAtSFromW)
(1,-1,0) > 33.39 and (1,-1,0) < 33.41
#EndMacro
#BeginMacro(ActivatedCaMApproachingAtSFromS)
(2,0,0) > 34.39 and (2,0,0) < 34.41
#EndMacro
#BeginMacro(CaMKIIApproachingAtSFromE)
(1,1,0) = 41
#EndMacro
#BeginMacro(CaMKIIApproachingAtSFromW)
(1,-1,0) = 43
#EndMacro
#BeginMacro(CaMKIIApproachingAtSFromS)
(2,0,0) = 44
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromE)
(0,1,0) != 41 and trunc(remainder((0,1,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromN)
(-1,0,0) != 42 and trunc(remainder((-1,0,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromW)
(0,-1,0) != 43 and trunc(remainder((0,-1,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromS)
(1,0,0) != 44 and trunc(remainder((1,0,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromE)
((0,1,0) < 31.39 or (0,1,0) > 31.41) and trunc(remainder((0,1,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromN)
((-1,0,0) < 32.39 or (-1,0,0) > 32.41) and trunc(remainder((-1,0,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromW)
((0,-1,0) < 33.39 or (0,-1,0) > 33.41) and trunc(remainder((0,-1,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromS)
((1,0,0) < 34.39 or (1,0,0) > 34.41) and trunc(remainder((1,0,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(CellToEIsNotApproaching)
trunc(remainder((0,1,0) + 0.001,10)) != 1
#EndMacro
#BeginMacro(CellToNIsNotApproaching)
trunc(remainder((-1,0,0) + 0.001,10)) != 2
#EndMacro
#BeginMacro(CellToWIsNotApproaching)
trunc(remainder((0,-1,0) + 0.001,10)) != 3
#EndMacro
#BeginMacro(CellToSIsNotApproaching)
trunc(remainder((1,0,0) + 0.001,10)) != 4
#EndMacro
#BeginMacro(ApproachingActivatedCaMKIIFromE)
(0,1,0) > 41.39 and (0,1,0) < 41.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMKIIFromN)
(-1,0,0) > 42.39 and (-1,0,0) < 42.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMKIIFromW)
(0,-1,0) > 43.39 and (0,-1,0) < 43.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMKIIFromS)
(1,0,0) > 44.39 and (1,0,0) < 44.41
#EndMacro
#BeginMacro(CellIsActivatedCaMKIIFromE)
((0,0,0) > 41.39 and (0,0,0) < 41.41) and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsActivatedCaMKIIFromN)
((0,0,0) > 42.39 and (0,0,0) < 42.41) and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsActivatedCaMKIIFromW)
((0,0,0) > 43.39 and (0,0,0) < 43.41) and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsActivatedCaMKIIFromS)
((0,0,0) > 44.39 and (0,0,0) < 44.41) and cellPos(2) = 0
#EndMacro
#BeginMacro(ApproachingParticleFromNAtW)
trunc(remainder((-1,-1,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingParticleFromWAtW)
trunc(remainder((0,-2,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingParticleFromSAtW)
trunc(remainder((1,-1,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(ApproachingCaMKIIFromNAtW)
(-1,-1,0) = 42
#EndMacro
#BeginMacro(ApproachingCaMKIIFromWAtW)
(0,-2,0) = 43
#EndMacro
#BeginMacro(ApproachingCaMKIIFromSAtW)
(1,-1,0) = 44
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromNAtW)
((-1,-1,0) < 32.39 or (-1,-1,0) > 32.41) and trunc(remainder((-1,-1,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromWAtW)
((0,-2,0) < 33.39 or (0,-2,0) > 33.41) and trunc(remainder((0,-2,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromSAtW)
((1,-1,0) < 34.39 or (1,-1,0) > 34.41) and trunc(remainder((1,-1,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromNAtW)
(-1,-1,0) != 42 and trunc(remainder((-1,-1,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromWAtW)
(0,-2,0) != 43 and trunc(remainder((0,-2,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromSAtW)
(1,-1,0) != 44 and trunc(remainder((1,-1,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(ActivatedCaMToECombinesOverWSAtW)
(0,0,4) < (0,-2,4) and (0,0,4) < (1,-1,4) 
#EndMacro
#BeginMacro(ActivatedCaMToECombinesOverNSAtW)
(0,0,4) < (-1,-1,4) and (0,0,4) < (1,-1,4) 
#EndMacro
#BeginMacro(ActivatedCaMToECombinesOverNWAtW)
(0,0,4) < (-1,-1,4) and (0,0,4) < (0,-2,4) 
#EndMacro
#BeginMacro(ActivatedCaMToECombinesOverNAtW)
(0,0,4) < (-1,-1,4)
#EndMacro
#BeginMacro(ActivatedCaMToECombinesOverWAtW)
(0,0,4) < (0,-2,4)
#EndMacro
#BeginMacro(ActivatedCaMToECombinesOverSAtW)
(0,0,4) < (1,-1,4)
#EndMacro
#BeginMacro(CaMKIIToECombinesOverWSAtW)
(0,0,4) < (0,-2,4) and (0,0,4) < (1,-1,4) 
#EndMacro
#BeginMacro(CaMKIIToECombinesOverNSAtW)
(0,0,4) < (-1,-1,4) and (0,0,4) < (1,-1,4) 
#EndMacro
#BeginMacro(CaMKIIToECombinesOverNWAtW)
(0,0,4) < (-1,-1,4) and (0,0,4) < (0,-2,4) 
#EndMacro
#BeginMacro(CaMKIIToECombinesOverNAtW)
(0,0,4) < (-1,-1,4)
#EndMacro
#BeginMacro(CaMKIIToECombinesOverWAtW)
(0,0,4) < (0,-2,4)
#EndMacro
#BeginMacro(CaMKIIToECombinesOverSAtW)
(0,0,4) < (1,-1,4)
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfThreeActivatedCaMsAtW)
(0,-1,3) < 0.9
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW)
(0,-1,3) < 0.6
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfOneActivatedCaMAtW)
(0,-1,3) < 0.3
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtW)
(0,-1,3) < 0.9
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW)
(0,-1,3) < 0.6
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfOneCaMKIIAtW)
(0,-1,3) < 0.3
#EndMacro
#BeginMacro(CellToNIsNotApproachingAtW)
trunc(remainder((-1,-1,0) + 0.001,10)) != 2
#EndMacro
#BeginMacro(CellToWIsNotApproachingAtW)
trunc(remainder((0,-2,0) + 0.001,10)) != 3
#EndMacro
#BeginMacro(CellToSIsNotApproachingAtW)
trunc(remainder((1,-1,0) + 0.001,10)) != 4
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromNAtW)
(-1,-1,0) > 32.39 and (-1,-1,0) < 32.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromWAtW)
(0,-2,0) > 33.39 and (0,-2,0) < 33.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromSAtW)
(1,-1,0) > 34.39 and (1,-1,0) < 34.41
#EndMacro
#BeginMacro(ApproachingCaMKIIFromEAtS)
(1,1,0) = 41
#EndMacro
#BeginMacro(ApproachingCaMKIIFromWAtS)
(1,-1,0) = 43
#EndMacro
#BeginMacro(ApproachingCaMKIIFromSAtS)
(2,0,0) = 44
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromEAtS)
((1,1,0) < 31.39 or (1,1,0) > 31.41) and trunc(remainder((1,1,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromWAtS)
((1,-1,0) < 33.39 or (1,-1,0) > 33.41) and trunc(remainder((1,-1,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromSAtS)
((2,0,0) < 34.39 or (2,0,0) > 34.41) and trunc(remainder((2,0,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromEAtS)
(1,1,0) != 41 and trunc(remainder((1,1,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromWAtS)
(1,-1,0) != 43 and trunc(remainder((1,-1,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromSAtS)
(2,0,0) != 44 and trunc(remainder((2,0,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(ActivatedCaMToNCombinesOverWSAtS)
(0,0,4) < (1,-1,4) and (0,0,4) < (2,0,4)   
#EndMacro
#BeginMacro(ActivatedCaMToNCombinesOverESAtS)
(0,0,4) < (1,1,4) and (0,0,4) < (2,0,4) 
#EndMacro
#BeginMacro(ActivatedCaMToNCombinesOverEWAtS)
(0,0,4) < (1,1,4) and (0,0,4) < (1,-1,4) 
#EndMacro
#BeginMacro(ActivatedCaMToNCombinesOverEAtS)
(0,0,4) < (1,1,4)
#EndMacro
#BeginMacro(ActivatedCaMToNCombinesOverWAtS)
(0,0,4) < (1,-1,4)
#EndMacro
#BeginMacro(ActivatedCaMToNCombinesOverSAtS)
(0,0,4) < (2,0,4)
#EndMacro
#BeginMacro(CaMKIIToNCombinesOverWSAtS)
(0,0,4) < (1,-1,4) and (0,0,4) < (2,0,4)   
#EndMacro
#BeginMacro(CaMKIIToNCombinesOverESAtS)
(0,0,4) < (1,1,4) and (0,0,4) < (2,0,4) 
#EndMacro
#BeginMacro(CaMKIIToNCombinesOverEWAtS)
(0,0,4) < (1,1,4) and (0,0,4) < (1,-1,4) 
#EndMacro
#BeginMacro(CaMKIIToNCombinesOverEAtS)
(0,0,4) < (1,1,4)
#EndMacro
#BeginMacro(CaMKIIToNCombinesOverWAtS)
(0,0,4) < (1,-1,4)
#EndMacro
#BeginMacro(CaMKIIToNCombinesOverSAtS)
(0,0,4) < (2,0,4)
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfThreeActivatedCaMsAtS)
(1,0,3) < 0.9
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS)
(1,0,3) < 0.6
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfOneActivatedCaMAtS)
(1,0,3) < 0.3
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtS)
(1,0,3) < 0.9
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS)
(1,0,3) < 0.6
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfOneCaMKIIAtS)
(1,0,3) < 0.3
#EndMacro
#BeginMacro(CellToEIsNotApproachingAtS)
trunc(remainder((1,1,0) + 0.001,10)) != 1
#EndMacro
#BeginMacro(CellToWIsNotApproachingAtS)
trunc(remainder((1,-1,0) + 0.001,10)) != 3
#EndMacro
#BeginMacro(CellToSIsNotApproachingAtS)
trunc(remainder((2,0,0) + 0.001,10)) != 4
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromEAtS)
(1,1,0) > 31.39 and (1,1,0) < 31.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromWAtS)
(1,-1,0) > 33.39 and (1,-1,0) < 33.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromSAtS)
(2,0,0) > 34.39 and (2,0,0) < 34.41
#EndMacro
#BeginMacro(ApproachingCaMKIIFromEAtE)
(0,2,0) = 41
#EndMacro
#BeginMacro(ApproachingCaMKIIFromNAtE)
(-1,1,0) = 42
#EndMacro
#BeginMacro(ApproachingCaMKIIFromSAtE)
(1,1,0) = 44
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromEAtE)
((0,2,0) < 31.39 or (0,2,0) > 31.41) and trunc(remainder((0,2,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromNAtE)
((-1,1,0) < 32.39 or (-1,1,0) > 32.41) and trunc(remainder((-1,1,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromSAtE)
((1,1,0) < 34.39 or (1,1,0) > 34.41) and trunc(remainder((1,1,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromEAtE)
(0,2,0) != 41 and trunc(remainder((0,2,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromNAtE)
(-1,1,0) != 42 and trunc(remainder((-1,1,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromSAtE)
(1,1,0) != 44 and trunc(remainder((1,1,0)+0.001,10)) = 4
#EndMacro
#BeginMacro(ActivatedCaMToWCombinesOverENAtE)
(0,0,4) < (0,2,4) and (0,0,4) < (-1,1,4)   
#EndMacro
#BeginMacro(ActivatedCaMToWCombinesOverESAtE)
(0,0,4) < (0,2,4) and (0,0,4) < (1,1,4) 
#EndMacro
#BeginMacro(ActivatedCaMToWCombinesOverNSAtE)
(0,0,4) < (-1,1,4) and (0,0,4) < (1,1,4) 
#EndMacro
#BeginMacro(ActivatedCaMToWCombinesOverEAtE)
(0,0,4) < (0,2,4)
#EndMacro
#BeginMacro(ActivatedCaMToWCombinesOverNAtE)
(0,0,4) < (-1,1,4)
#EndMacro
#BeginMacro(ActivatedCaMToWCombinesOverSAtE)
(0,0,4) < (1,1,4)
#EndMacro
#BeginMacro(CaMKIIToWCombinesOverENAtE)
(0,0,4) < (0,2,4) and (0,0,4) < (-1,1,4)   
#EndMacro
#BeginMacro(CaMKIIToWCombinesOverESAtE)
(0,0,4) < (0,2,4) and (0,0,4) < (1,1,4) 
#EndMacro
#BeginMacro(CaMKIIToWCombinesOverNSAtE)
(0,0,4) < (-1,1,4) and (0,0,4) < (1,1,4) 
#EndMacro
#BeginMacro(CaMKIIToWCombinesOverEAtE)
(0,0,4) < (0,2,4)
#EndMacro
#BeginMacro(CaMKIIToWCombinesOverNAtE)
(0,0,4) < (-1,1,4)
#EndMacro
#BeginMacro(CaMKIIToWCombinesOverSAtE)
(0,0,4) < (1,1,4)
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfThreeActivatedCaMsAtE)
(0,1,3) < 0.9
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE)
(0,1,3) < 0.6
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfOneActivatedCaMAtE)
(0,1,3) < 0.3
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtE)
(0,1,3) < 0.9
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE)
(0,1,3) < 0.6
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfOneCaMKIIAtE)
(0,1,3) < 0.3
#EndMacro
#BeginMacro(CellToEIsNotApproachingAtE)
trunc(remainder((0,2,0) + 0.001,10)) != 1
#EndMacro
#BeginMacro(CellToNIsNotApproachingAtE)
trunc(remainder((-1,1,0) + 0.001,10)) != 2
#EndMacro
#BeginMacro(CellToSIsNotApproachingAtE)
trunc(remainder((1,1,0) + 0.001,10)) != 4
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromEAtE)
(0,2,0) > 31.39 and (0,2,0) < 31.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromNAtE)
(-1,1,0) > 32.39 and (-1,1,0) < 32.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromSAtE)
(1,1,0) > 34.39 and (1,1,0) < 34.41
#EndMacro
#BeginMacro(ApproachingCaMKIIFromEAtN)
(-1,1,0) = 41
#EndMacro
#BeginMacro(ApproachingCaMKIIFromNAtN)
(-2,0,0) = 42
#EndMacro
#BeginMacro(ApproachingCaMKIIFromWAtN)
(-1,-1,0) = 43
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromEAtN)
((-1,1,0) < 31.39 or (-1,1,0) > 31.41) and trunc(remainder((-1,1,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromNAtN)
((-2,0,0) < 32.39 or (-2,0,0) > 32.41) and trunc(remainder((-2,0,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingNonActivatedCaMFromWAtN)
((-1,-1,0) < 33.39 or (-1,-1,0) > 33.41) and trunc(remainder((-1,-1,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromEAtN)
(-1,1,0) != 41 and trunc(remainder((-1,1,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromNAtN)
(-2,0,0) != 42 and trunc(remainder((-2,0,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingNonCaMKIIFromWAtN)
(-1,-1,0) != 43 and trunc(remainder((-1,-1,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ActivatedCaMToSCombinesOverENAtN)
(0,0,4) < (-1,1,4) and (0,0,4) < (-2,0,4)   
#EndMacro
#BeginMacro(ActivatedCaMToSCombinesOverEWAtN)
(0,0,4) < (-1,1,4) and (0,0,4) < (-1,-1,4) 
#EndMacro
#BeginMacro(ActivatedCaMToSCombinesOverNWAtN)
(0,0,4) < (-2,0,4) and (0,0,4) < (-1,-1,4) 
#EndMacro
#BeginMacro(ActivatedCaMToSCombinesOverEAtN)
(0,0,4) < (-1,1,4)
#EndMacro
#BeginMacro(ActivatedCaMToSCombinesOverNAtN)
(0,0,4) < (-2,0,4)
#EndMacro
#BeginMacro(ActivatedCaMToSCombinesOverWAtN)
(0,0,4) < (-1,-1,4)
#EndMacro
#BeginMacro(CaMKIIToSCombinesOverENAtN)
(0,0,4) < (-1,1,4) and (0,0,4) < (-2,0,4)   
#EndMacro
#BeginMacro(CaMKIIToSCombinesOverEWAtN)
(0,0,4) < (-1,1,4) and (0,0,4) < (-1,-1,4) 
#EndMacro
#BeginMacro(CaMKIIToSCombinesOverNWAtN)
(0,0,4) < (-2,0,4) and (0,0,4) < (-1,-1,4) 
#EndMacro
#BeginMacro(CaMKIIToSCombinesOverEAtN)
(0,0,4) < (-1,1,4)
#EndMacro
#BeginMacro(CaMKIIToSCombinesOverNAtN)
(0,0,4) < (-2,0,4)
#EndMacro
#BeginMacro(CaMKIIToSCombinesOverWAtN)
(0,0,4) < (-1,-1,4)
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfThreeActivatedCaMsAtN)
(-1,0,3) < 0.9
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN)
(-1,0,3) < 0.6
#EndMacro
#BeginMacro(CaMKIIBindsToOneOfOneActivatedCaMAtN)
(-1,0,3) < 0.3
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtN)
(-1,0,3) < 0.9
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN)
(-1,0,3) < 0.6
#EndMacro
#BeginMacro(ActivatedCaMBindsToOneOfOneCaMKIIAtN)
(-1,0,3) < 0.3
#EndMacro
#BeginMacro(CellToEIsNotApproachingAtN)
trunc(remainder((-1,1,0) + 0.001,10)) != 1
#EndMacro
#BeginMacro(CellToNIsNotApproachingAtN)
trunc(remainder((-2,0,0) + 0.001,10)) != 2
#EndMacro
#BeginMacro(CellToWIsNotApproachingAtN)
trunc(remainder((-1,-1,0) + 0.001,10)) != 3
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromEAtN)
(-1,1,0) > 31.39 and (-1,1,0) < 31.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromNAtN)
(-2,0,0) > 32.39 and (-2,0,0) < 32.41
#EndMacro
#BeginMacro(ApproachingActivatedCaMFromWAtN)
(-1,-1,0) > 33.39 and (-1,-1,0) < 33.41
#EndMacro
#BeginMacro(CellIsStationarySynapsin)
(0,0,0) = 29 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsSynapsinFromE)
(0,0,0) = 21 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsSynapsinFromN)
(0,0,0) = 22 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsSynapsinFromW)
(0,0,0) = 23 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsSynapsinFromS)
(0,0,0) = 24 and cellPos(2) = 0
#EndMacro
#BeginMacro(ActivatedCaMKIIFromEPhosphorylatesSynapsin)
(0,1,3) < 0.8
#EndMacro
#BeginMacro(ActivatedCaMKIIFromNPhosphorylatesSynapsin)
(-1,0,3) < 0.8
#EndMacro
#BeginMacro(ActivatedCaMKIIFromWPhosphorylatesSynapsin)
(0,-1,3) < 0.8
#EndMacro
#BeginMacro(ActivatedCaMKIIFromSPhosphorylatesSynapsin)
(1,0,3) < 0.8
#EndMacro
#BeginMacro(ApproachingSynapsinFromE)
(0,1,0) = 21
#EndMacro
#BeginMacro(ApproachingSynapsinFromN)
(-1,0,0) = 22
#EndMacro
#BeginMacro(ApproachingSynapsinFromW)
(0,-1,0) = 23
#EndMacro
#BeginMacro(ApproachingSynapsinFromS)
(1,0,0) = 24
#EndMacro
#BeginMacro(CellIsStationaryVesicleNotInCluster)
(0,0,0) = 19 and ((0,1,0) != 29 and (-1,0,0) != 29 and (0,-1,0) != 29 and (1,0,0) != 29) and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsVesicleFromE)
(0,0,0) = 11 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsVesicleFromN)
(0,0,0) = 12 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsVesicleFromW)
(0,0,0) = 13 and cellPos(2) = 0
#EndMacro
#BeginMacro(ApproachingNonVesicleFromNAtW)
(-1,-1,0) != 12 and trunc(remainder((-1,-1,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingNonVesicleFromWAtW)
(0,-2,0) != 13 and trunc(remainder((0,-2,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingNonVesicleFromEAtS)
(1,1,0) != 11 and trunc(remainder((1,1,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingNonVesicleFromWAtS)
(1,-1,0) != 13 and trunc(remainder((1,-1,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingNonVesicleFromEAtE)
(0,2,0) != 11 and trunc(remainder((0,2,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingNonVesicleFromNAtE)
(-1,1,0) != 12 and trunc(remainder((-1,1,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingNonVesicleFromEAtN)
(-1,1,0) != 11 and trunc(remainder((-1,1,0)+0.001,10)) = 1
#EndMacro
#BeginMacro(ApproachingNonVesicleFromNAtN)
(-2,0,0) != 12 and trunc(remainder((-2,0,0)+0.001,10)) = 2
#EndMacro
#BeginMacro(ApproachingNonVesicleFromWAtN)
(-1,-1,0) != 13 and trunc(remainder((-1,-1,0)+0.001,10)) = 3
#EndMacro
#BeginMacro(ApproachingVesicleFromE)
(0,1,0) = 11
#EndMacro
#BeginMacro(ApproachingVesicleFromN)
(-1,0,0) = 12
#EndMacro
#BeginMacro(ApproachingVesicleFromW)
(0,-1,0) = 13
#EndMacro
#BeginMacro(CellIsDockedVesicle)
(0,0,0) = 12 and (1,0,0) = 6 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellToSIsActiveZone)
(1,0,0) = 6
#EndMacro
#BeginMacro(CellToSIsDockedVesicle)
(1,0,0) = 12 and (2,0,0) = 6 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellToSIsNextToActiveZoneButNotAVesicle)
trunc((1,0,0)/10) = 1 and (2,0,0) = 6
#EndMacro
#BeginMacro(CellIsInEastRegion)
cellPos(1) > 17
#EndMacro
#BeginMacro(CellToEIsInEastRegion)
cellPos(1) > 16
#EndMacro
#BeginMacro(CellIsInNorthRegion)
cellPos(0) < 22
#EndMacro
#BeginMacro(CellIsInWestRegion)
cellPos(1) < 12
#EndMacro
#BeginMacro(CellToWIsInWestRegion)
cellPos(1) < 13
#EndMacro
#BeginMacro(CellIsInSouthRegion)
cellPos(0) > 25
#EndMacro
#BeginMacro(HighCalciumContentToN)
(-1,0,2) > 4
#EndMacro
#BeginMacro(CellToNIsDocked)
(-1,0,0) = 12 and cellPos(0) = 29 and (cellPos(1) > 9 and cellPos(1) < 20)
#EndMacro
#BeginMacro(CellIsInActiveZone)
(0,0,0) = 6 and cellPos(2) = 0
#EndMacro
#BeginMacro(CellIsVesicleInActiveZone)
(0,0,0) = 12 and cellPos(0) = 29 and (cellPos(1) > 9 and cellPos(1) < 20) and cellPos(2) = 0
#EndMacro
#BeginMacro(ApproachingVesicleFromNAtW)
(-1,-1,0) = 12
#EndMacro
#BeginMacro(ApproachingVesicleFromWAtW)
(0,-2,0) = 13
#EndMacro
#BeginMacro(ApproachingVesicleFromEAtN)
(-1,1,0) = 11
#EndMacro
#BeginMacro(ApproachingVesicleFromNAtN)
(-2,0,0) = 12
#EndMacro
#BeginMacro(ApproachingVesicleFromWAtN)
(-1,-1,0) = 13
#EndMacro
#BeginMacro(ApproachingVesicleFromEAtE)
(0,2,0) = 11
#EndMacro
#BeginMacro(ApproachingVesicleFromNAtE)
(-1,1,0) = 12
#EndMacro
#BeginMacro(ApproachingVesicleFromEAtS)
(1,1,0) = 11
#EndMacro
#BeginMacro(ApproachingVesicleFromWAtS)
(1,-1,0) = 13
#EndMacro