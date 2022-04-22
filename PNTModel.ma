%CDPlusPlus_Builder_Version_1.0.0
#include(PNTModel.inc)
[top]
components : particle 

[particle] 
type : cell 
dim : (30,30,5)
delay : transport 
defaultDelayTime : 10 
border : wrapped 
neighbors : particle(-3,0,0)     
neighbors : particle(-2,-1,0) particle(-2,0,0) particle(-2,1,0) 
neighbors : particle(-1,-2,0) particle(-1,-1,0) particle(-1,0,0) particle(-1,1,0) particle(-1,2,0) 
neighbors : particle(0,-3,0) particle(0,-2,0) particle(0,-1,0) particle(0,0,0) particle(0,1,0) particle(0,2,0) particle(0,3,0) 
neighbors : particle(1,-2,0) particle(1,-1,0) particle(1,0,0) particle(1,1,0) particle(1,2,0) 
neighbors : particle(2,-1,0) particle(2,0,0) particle(2,1,0) 
neighbors : particle(3,0,0)     
neighbors : particle(-2,0,1)
neighbors : particle(-1,-1,1) particle(-1,0,1) particle(-1,1,1)
neighbors : particle(0,-2,1) particle(0,-1,1) particle(0,0,1) particle(0,1,1) particle(0,2,1)
neighbors : particle(1,-1,1) particle(1,0,1) particle(1,1,1)
neighbors : particle(2,0,1) 
neighbors : particle(-2,0,2) 
neighbors : particle(-1,-1,2) particle(-1,0,2) particle(-1,1,2)
neighbors : particle(0,-2,2) particle(0,-1,2) particle(0,0,2) particle(0,1,2) particle(0,2,2)
neighbors : particle(1,-1,2) particle(1,0,2) particle(1,1,2)
neighbors : particle(2,0,2)
neighbors : particle(-2,0,3)
neighbors : particle(-1,-1,3) particle(-1,0,3) particle(-1,1,3)
neighbors : particle(0,-2,3) particle(0,-1,3) particle(0,0,3) particle(0,1,3) particle(0,2,3)
neighbors : particle(1,-1,3) particle(1,0,3) particle(1,1,3)
neighbors : particle(2,0,3)
neighbors : particle(-2,0,4)
neighbors : particle(-1,-1,4) particle(-1,0,4) particle(-1,1,4)
neighbors : particle(0,-2,4) particle(0,-1,4) particle(0,0,4) particle(0,1,4) particle(0,2,4) 
neighbors : particle(1,-1,4) particle(1,0,4) particle(1,1,4)
neighbors : particle(2,0,4)
initialvalue : 0 
initialCellsValue : PNTModel30by30.val
localtransition : move-rule 
[move-rule]
%
% Rules for wall colour.
%
%   Set wall to yellow when action potential is occurring.
%
rule : 8 10 { #macro(CellIsInTopWallIncCorners) and #macro(DuringActionPotential) }
rule : 8 10 { #macro(CellIsInLeftWallNotIncCorners) and #macro(DuringActionPotential) }
rule : 8 10 { #macro(CellIsInRightWallNotIncCorners) and #macro(DuringActionPotential) }
rule : 8 10 { #macro(CellIsInBottomWallIncCorners) and #macro(DuringActionPotential) }
%
%   Set wall to black when action potential is not occurring.
%
rule : 5 10 { #macro(CellIsInTopWallIncCorners) and #macro(NotDuringActionPotential) }
rule : 5 10 { #macro(CellIsInLeftWallNotIncCorners) and #macro(NotDuringActionPotential) }
rule : 5 10 { #macro(CellIsInRightWallNotIncCorners) and #macro(NotDuringActionPotential) }
rule : 5 10 { #macro(CellIsInBottomWallIncCorners) and #macro(NotDuringActionPotential) }
%
% Rules for calcium ion channel colour.
%
%   Set calcium ion channel colour to closed value.
%
rule : 7 10 { #macro(CellIsInCaIonChannel) and #macro(CaIonChannelsAreClosedWRTMainLayer) }
%
%   Set calcium ion channel colour to open value.
%
rule : 7.5 10 { #macro(CellIsInCaIonChannel) and #macro(CaIonChannelsAreOpenWRTMainLayer) }
%
% Rules for creation of calcium ions at cells near calcium ion channels when they are open. 
%
rule : { (0,0,0) + randInt(5) + 1 } 10 { #macro(CellIsAdjacentToCaIonChannel) and #macro(CaIonChannelsAreOpenWRTCalciumLayer) } 
rule : { (0,0,0) + randInt(4) + 1 } 10 { #macro(CellIsNearCaIonChannel) and #macro(CaIonChannelsAreOpenWRTCalciumLayer) } 
%
% Rules for updating calcium ion concentration. Up to 3 calcium ions will be lost per time step for each cell. Note that the 
% calcium ions do not 'see' any other particles (calcium ions are much smaller than any of the proteins or the Vesicles).
%
%   Update calcium ion concentration in corner cells (corner of the fluid that is).
%
rule : { max(0,0 - randInt(3) + round(((0,0,0)           + (-1,0,0) + (0,-1,0)            )/3)) } 10 { #macro(CellIsSEFluidCornerForCalciumLayer) }
rule : { max(0,0 - randInt(3) + round(((0,0,0) + (0,1,0)                       + (1,0,0)  )/3)) } 10 { #macro(CellIsNWFluidCornerForCalciumLayer) }
rule : { max(0,0 - randInt(3) + round(((0,0,0) + (0,1,0) + (-1,0,0)                       )/3)) } 10 { #macro(CellIsSWFluidCornerForCalciumLayer) }
rule : { max(0,0 - randInt(3) + round(((0,0,0) +                      (0,-1,0) + (1,0,0)  )/3)) } 10 { #macro(CellIsNEFluidCornerForCalciumLayer) }
%
%   Update calcium ion concentration cells along walls (edges of fluid next to wall, but not corners).
%
rule : { max(0,0 - randInt(3) + round(((0,0,0)           + (-1,0,0) + (0,-1,0) + (1,0,0)  )/4)) } 10 { #macro(CellIsBottomRowFluidForCalciumLayer) }
rule : { max(0,0 - randInt(3) + round(((0,0,0) + (0,1,0)            + (0,-1,0) + (1,0,0)  )/4)) } 10 { #macro(CellIsTopRowFluidForCalciumLayer) }
rule : { max(0,0 - randInt(3) + round(((0,0,0) + (0,1,0) + (-1,0,0)            + (1,0,0)  )/4)) } 10 { #macro(CellIsLeftRowFluidForCalciumLayer) }
rule : { max(0,0 - randInt(3) + round(((0,0,0) + (0,1,0) + (-1,0,0) + (0,-1,0)            )/4)) } 10 { #macro(CellIsRightRowFluidForCalciumLayer) }
%
%   Update calcium ion concentration in rows or columns one closer to the centre than the rows and columns adjacent to the wall.
%
rule : { max(0,0 - randInt(3) + round(((0,0,0) + (0,1,0) + (-1,0,0) + (0,-1,0) + (1,0,0)  )/5)) } 10 { #macro(CellIsFirstInnerSquareFluidForCalciumLayer) }
%
%   Update calcium ion concentration in rows or columns two closer to the centre than the rows and columns adjacent to the wall.
%
rule : { max(0,0 - randInt(3) + round(((0,0,0) + (0,1,0) + (-1,0,0) + (0,-1,0) + (1,0,0) +
                                      (-1,1,0)+ (-1,-1,0)+ (1,-1,0) + (1,1,0) + 
                                      (0,2,0) + (-2,0,0) + (0,-2,0) + (2,0,0) )/13)) } 10 { #macro(CellIsSecondInnerSquareFluidForCalciumLayer) }
%                                      
%   Update calcium ion concentration in the central part of the grid.
%
rule : { max(0,0 - randInt(3) + round(((-3,0,0) +
                         (-2,-1,0) + (-2,0,0) + (-2,1,0) +
                         (-1,-2,0) + (-1,-1,0) + (-1,0,0) + (-1,1,0) + (-1,2,0) +
                         (0,-3,0) + (0,-2,0) + (0,-1,0) + (0,0,0) + (0,1,0) + (0,2,0) + (0,3,0) +
                         (1,-2,0) + (1,-1,0) + (1,0,0) + (1,1,0) + (1,2,0) + 
                         (2,-1,0) + (2,0,0) + (2,1,0) +
                         (3,0,0) )/25)) } 10 { #macro(CellIsInteriorFluidForCalciumLayer) }
%
% Rules specifically for stationary Vesicles and Synapsins to change status.                         
%
%   Cell is a stationary Vesicle but is no longer attached to any Synapsins. Convert to Vesicle from north.
%
rule : 12 10 { #macro(CellIsStationaryVesicleNotInCluster) }
%
%   Cell is a stationary Synapsin. It is bumped into by an activated CaMKII. The Synapsin is phosphorylated.
%
rule : { 21 + randInt(3) } 10 { #macro(CellIsStationarySynapsin) and (
                               (#macro(ApproachingActivatedCaMKIIFromE) and #macro(ActivatedCaMKIIFromEPhosphorylatesSynapsin)) or                           
                               (#macro(ApproachingActivatedCaMKIIFromN) and #macro(ActivatedCaMKIIFromNPhosphorylatesSynapsin)) or                           
                               (#macro(ApproachingActivatedCaMKIIFromW) and #macro(ActivatedCaMKIIFromWPhosphorylatesSynapsin)) or                           
                               (#macro(ApproachingActivatedCaMKIIFromS) and #macro(ActivatedCaMKIIFromSPhosphorylatesSynapsin))) }                           
%
% Rules for an already docked Vesicle.
%
rule : 0 10 { #macro(CellIsDockedVesicle) and #macro(HighCalciumContent) }
rule : 12 10 { #macro(CellIsInActiveZone) and #macro(CellToNIsDocked) and #macro(HighCalciumContentToN) }
rule : 6 10 { #macro(CellIsVesicleInActiveZone) } 
rule : { (0,0,0) } 10 { #macro(CellIsDockedVesicle) }
%
% Rules for a moving Vesicle when the cell 'in front' is fluid. It has priority over other types of particles.
%
%   Cell is a Vesicle from east.
%
rule : 11 10 { #macro(CellIsVesicleFromE) and #macro(CellToWIsFluid) and #macro(ApproachingVesicleFromNAtW) } 
rule : 0 10 { #macro(CellIsVesicleFromE) and #macro(CellToWIsFluid) and #macro(ApproachingVesicleFromWAtW) and #macro(FromEWinsAtWOverW) }
rule : 11 10 { #macro(CellIsVesicleFromE) and #macro(CellToWIsFluid) and #macro(ApproachingVesicleFromWAtW) and #macro(CellIsInEastRegion) and #macro(FromWWinsAtWOverE) }
rule : 12 10 { #macro(CellIsVesicleFromE) and #macro(CellToWIsFluid) and #macro(ApproachingVesicleFromWAtW) and #macro(FromWWinsAtWOverE) }
rule : 0 10 { #macro(CellIsVesicleFromE) and #macro(CellToWIsFluid) }
%
%   Cell is a Vesicle from north. This has the highest priority.
%
rule : 0 10 { #macro(CellIsVesicleFromN) and #macro(CellToSIsFluid) } 
%
%   Cell is a Vesicle from west.
%
rule : 13 10 { #macro(CellIsVesicleFromW) and #macro(CellToEIsFluid) and #macro(ApproachingVesicleFromNAtE) } 
rule : 0 10 { #macro(CellIsVesicleFromW) and #macro(CellToEIsFluid) and #macro(ApproachingVesicleFromEAtE) and #macro(FromWWinsAtEOverE) }
rule : 13 10 { #macro(CellIsVesicleFromW) and #macro(CellToEIsFluid) and #macro(ApproachingVesicleFromEAtE) and #macro(CellIsInWestRegion) and #macro(FromEWinsAtEOverW) }
rule : 12 10 { #macro(CellIsVesicleFromW) and #macro(CellToEIsFluid) and #macro(ApproachingVesicleFromEAtE) and #macro(FromEWinsAtEOverW) }
rule : 0 10 { #macro(CellIsVesicleFromW) and #macro(CellToEIsFluid) }
%
% Rules for a moving Vesicle when the cell 'in front' is a particle.
%
%   Cell is a Vesicle from east.
%
rule : 12 10 { #macro(CellIsVesicleFromE) and #macro(CellToWIsNotFluid) and #macro(CellToSIsActiveZone) }
rule : 12 10 { #macro(CellIsVesicleFromE) and #macro(CellToWIsNotFluid) and #macro(CellIsInNorthRegion) }
rule : 13 10 { #macro(CellIsVesicleFromE) and #macro(CellToWIsNotFluid) and #macro(CellIsInWestRegion) }
rule : 11 10 { #macro(CellIsVesicleFromE) and #macro(CellToWIsNotFluid) and #macro(CellIsInEastRegion) }
rule : 12 10 { #macro(CellIsVesicleFromE) and #macro(CellToWIsNotFluid) }
%
%   Cell is a Vesicle from north.
%
rule : 11 10 { #macro(CellIsVesicleFromN) and #macro(CellToSIsDockedVesicle) and random < 0.5 }
rule : 13 10 { #macro(CellIsVesicleFromN) and #macro(CellToSIsDockedVesicle) }
rule : 11 10 { #macro(CellIsVesicleFromN) and #macro(CellToSIsNotFluid) and #macro(CellIsInEastRegion) and #macro(CellIsInSouthRegion) }
rule : 13 10 { #macro(CellIsVesicleFromN) and #macro(CellToSIsNotFluid) and #macro(CellIsInWestRegion) and #macro(CellIsInSouthRegion) }
rule : 12 10 { #macro(CellIsVesicleFromN) and #macro(CellToSIsNotFluid) }
rule : { 11 + randInt(2) } 10 { #macro(CellIsVesicleFromN) and #macro(CellToSIsNotFluid) }
%
%   Cell is a Vesicle from west.
%
rule : 12 10 { #macro(CellIsVesicleFromW) and #macro(CellToEIsNotFluid) and #macro(CellToSIsActiveZone) }
rule : 12 10 { #macro(CellIsVesicleFromW) and #macro(CellToEIsNotFluid) and #macro(CellIsInNorthRegion) }
rule : 13 10 { #macro(CellIsVesicleFromW) and #macro(CellToEIsNotFluid) and #macro(CellIsInWestRegion) }
rule : 11 10 { #macro(CellIsVesicleFromW) and #macro(CellToEIsNotFluid) and #macro(CellIsInEastRegion) }
rule : 12 10 { #macro(CellIsVesicleFromW) and #macro(CellToEIsNotFluid) }
%
% Rules for a moving particle other than a Vesicle when a Vesicle is approaching the cell 'in front' which is Fluid.
%
%   Cell is a particle from east other than a Vesicle. Cell to west is Fluid. A Vesicle is approaching the Fluid.
%
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) and (#macro(ApproachingVesicleFromNAtW) or #macro(ApproachingVesicleFromWAtW)) }   
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) and (#macro(ApproachingVesicleFromNAtW) or #macro(ApproachingVesicleFromWAtW)) }   
rule : { 31 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid) and (#macro(ApproachingVesicleFromNAtW) or #macro(ApproachingVesicleFromWAtW)) }   
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) and (#macro(ApproachingVesicleFromNAtW) or #macro(ApproachingVesicleFromWAtW)) }   
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromE) and #macro(CellToWIsFluid) and (#macro(ApproachingVesicleFromNAtW) or #macro(ApproachingVesicleFromWAtW)) }   
%
%   Cell is a particle from north other than a Vesicle. Cell to south is Fluid. A Vesicle is approaching the Fluid.
%
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) and (#macro(ApproachingVesicleFromEAtS) or #macro(ApproachingVesicleFromWAtS)) }   
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) and (#macro(ApproachingVesicleFromEAtS) or #macro(ApproachingVesicleFromWAtS)) }   
rule : { 31 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) and (#macro(ApproachingVesicleFromEAtS) or #macro(ApproachingVesicleFromWAtS)) }   
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) and (#macro(ApproachingVesicleFromEAtS) or #macro(ApproachingVesicleFromWAtS)) }   
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromN) and #macro(CellToSIsFluid) and (#macro(ApproachingVesicleFromEAtS) or #macro(ApproachingVesicleFromWAtS)) }   
%
%   Cell is a particle from west other than a Vesicle. Cell to east is Fluid. A Vesicle is approaching the Fluid.
%
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) and (#macro(ApproachingVesicleFromEAtE) or #macro(ApproachingVesicleFromNAtE)) }   
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) and (#macro(ApproachingVesicleFromEAtE) or #macro(ApproachingVesicleFromNAtE)) }   
rule : { 31 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) and (#macro(ApproachingVesicleFromEAtE) or #macro(ApproachingVesicleFromNAtE)) }   
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) and (#macro(ApproachingVesicleFromEAtE) or #macro(ApproachingVesicleFromNAtE)) }   
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromW) and #macro(CellToEIsFluid) and (#macro(ApproachingVesicleFromEAtE) or #macro(ApproachingVesicleFromNAtE)) }   
%
%   Cell is a particle from south other than a Vesicle. Cell to north is Fluid. A Vesicle is approaching the Fluid.
%
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) and (#macro(ApproachingVesicleFromEAtN) or #macro(ApproachingVesicleFromNAtN) or #macro(ApproachingVesicleFromWAtN)) }   
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) and (#macro(ApproachingVesicleFromEAtN) or #macro(ApproachingVesicleFromNAtN) or #macro(ApproachingVesicleFromWAtN)) }   
rule : { 31 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) and (#macro(ApproachingVesicleFromEAtN) or #macro(ApproachingVesicleFromNAtN) or #macro(ApproachingVesicleFromWAtN)) }   
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) and (#macro(ApproachingVesicleFromEAtN) or #macro(ApproachingVesicleFromNAtN) or #macro(ApproachingVesicleFromWAtN)) }   
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromS) and #macro(CellToNIsFluid) and (#macro(ApproachingVesicleFromEAtN) or #macro(ApproachingVesicleFromNAtN) or #macro(ApproachingVesicleFromWAtN)) }   
%
% Rules for a Fluid when a Vesicle is approaching.
%
%   Cell is Fluid. North is an approaching Vesicle.
%
rule : 12 10 { #macro(CellIsFluid) and #macro(ApproachingVesicleFromN) }
%
%   Cell is Fluid. East is an approaching Vesicle.
%
rule : 12 10 { #macro(CellIsFluid) and #macro(ApproachingVesicleFromE) and #macro(CellToSIsNextToActiveZoneButNotAVesicle) }
rule : 11 10 { #macro(CellIsFluid) and #macro(ApproachingVesicleFromE) and #macro(ApproachingVesicleFromW) and #macro(FromEWinsOverW)  }
rule : 11 10 { #macro(CellIsFluid) and #macro(ApproachingVesicleFromE)  }
%
%   Cell is Fluid. West is an approaching Vesicle.
%
rule : 12 10 { #macro(CellIsFluid) and #macro(ApproachingVesicleFromW) and #macro(CellToSIsNextToActiveZoneButNotAVesicle) }
rule : 13 10 { #macro(CellIsFluid) and #macro(ApproachingVesicleFromW) and #macro(ApproachingVesicleFromE) and #macro(FromWWinsOverE)  }
rule : 13 10 { #macro(CellIsFluid) and #macro(ApproachingVesicleFromW) }
%
% Rules for a Fluid when an activated CaM is approaching and at least one CaMKII is approaching. A complex is formed.
%
%   Cell is Fluid. East is an approaching activated CaM. There are three other approaching particles at least one of which is a CaMKII. 
%   East wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromE) and #macro(FromEWinsOverNWS) and (
             (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingCaMKIIFromW)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfThreeCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingCaMKIIFromW)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingNonCaMKIIFromW) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingCaMKIIFromW)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingNonCaMKIIFromW) and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
             (#macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingCaMKIIFromW)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
             (#macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingNonCaMKIIFromW) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII))) }
%
%   Cell is Fluid. East is an approaching activated CaM. There are two other approaching particles at least one of which is a CaMKII. 
%   East wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromE) and (
               (#macro(FromEWinsOverWS) and #macro(CellToNIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromW)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromW)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromW) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII)))) or 
               (#macro(FromEWinsOverNS) and #macro(CellToWIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII)))) or 
               (#macro(FromEWinsOverNW) and #macro(CellToSIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingNonCaMKIIFromW) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII))))) }
%
%   Cell is Fluid. East is an approaching activated CaM. There is one other approaching particle and it is a CaMKII.
%   East wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromE) and #macro(ActivatedCaMBindsToOneOfOneCaMKII) and (
               (#macro(FromEWinsOverN) and #macro(ApproachingCaMKIIFromN) and #macro(CellToWIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromEWinsOverW) and #macro(ApproachingCaMKIIFromW) and #macro(CellToNIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromEWinsOverS) and #macro(ApproachingCaMKIIFromS) and #macro(CellToNIsNotApproaching) and #macro(CellToWIsNotApproaching))) }
%                         
%   Cell is Fluid. North is an approaching activated CaM. There are three other approaching particles at least one of which is a CaMKII. 
%   North wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromN) and #macro(FromNWinsOverEWS) and (
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromW)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfThreeCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromW)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromW) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromW)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromW) and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
             (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromW)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
             (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingNonCaMKIIFromW) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII))) }
%
%   Cell is Fluid. North is an approaching activated CaM. There are two other approaching particles at least one of which is a CaMKII. 
%   North wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromN) and (
               (#macro(FromNWinsOverWS) and #macro(CellToEIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromW)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromW)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromW) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII)))) or 
               (#macro(FromNWinsOverES) and #macro(CellToWIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII)))) or 
               (#macro(FromNWinsOverEW) and #macro(CellToSIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromW) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII))))) }
%
%   Cell is Fluid. North is an approaching activated CaM. There is one other approaching particle and it is a CaMKII.
%   North wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromN) and #macro(ActivatedCaMBindsToOneOfOneCaMKII) and ( 
               (#macro(FromNWinsOverE) and #macro(ApproachingCaMKIIFromE) and #macro(CellToWIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromNWinsOverW) and #macro(ApproachingCaMKIIFromW) and #macro(CellToEIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromNWinsOverS) and #macro(ApproachingCaMKIIFromS) and #macro(CellToEIsNotApproaching) and #macro(CellToWIsNotApproaching))) }
%                         
%   Cell is Fluid. West is an approaching activated CaM. There are three other approaching particles at least one of which is a CaMKII. 
%   West wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromW) and #macro(FromWWinsOverENS) and (
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromN)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfThreeCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromN)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromN)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
             (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromN)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
             (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII))) }
%
%   Cell is Fluid. West is an approaching activated CaM. There are two other approaching particles at least one of which is a CaMKII. 
%   West wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromW) and (
               (#macro(FromWWinsOverNS) and #macro(CellToEIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII)))) or 
               (#macro(FromWWinsOverES) and #macro(CellToNIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromS)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII)))) or 
               (#macro(FromWWinsOverEN) and #macro(CellToSIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromN)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromN) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromN)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII))))) }
%
%   Cell is Fluid. West is an approaching activated CaM. There is one other approaching particle and it is a CaMKII.
%   West wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromW) and #macro(ActivatedCaMBindsToOneOfOneCaMKII) and (
               (#macro(FromWWinsOverE) and #macro(ApproachingCaMKIIFromE) and #macro(CellToNIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromWWinsOverN) and #macro(ApproachingCaMKIIFromN) and #macro(CellToEIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromWWinsOverS) and #macro(ApproachingCaMKIIFromS) and #macro(CellToEIsNotApproaching) and #macro(CellToNIsNotApproaching))) }
%                         
%   Cell is Fluid. South is an approaching activated CaM. There are three other approaching particles at least one of which is a CaMKII. 
%   South wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromS) and #macro(FromSWinsOverENW) and (
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromN)    and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfThreeCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromN)    and #macro(ApproachingNonCaMKIIFromW) and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromN)    and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
             (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingNonCaMKIIFromW) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
             (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromN)    and #macro(ApproachingNonCaMKIIFromW) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
             (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII))) }
%
%   Cell is Fluid. South is an approaching activated CaM. There are two other approaching particles at least one of which is a CaMKII. 
%   South wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromS) and (
               (#macro(FromSWinsOverNW) and #macro(CellToEIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromN)    and #macro(ApproachingNonCaMKIIFromW) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromN) and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII))) ) or 
               (#macro(FromSWinsOverEW) and #macro(CellToNIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromW) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromW)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII))) ) or 
               (#macro(FromSWinsOverEN) and #macro(CellToWIsNotApproaching) and (
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingCaMKIIFromN)    and #macro(ActivatedCaMBindsToOneOfTwoCaMKIIs)) or 
                 (#macro(ApproachingCaMKIIFromE)    and #macro(ApproachingNonCaMKIIFromN) and #macro(ActivatedCaMBindsToOneOfOneCaMKII)) or 
                 (#macro(ApproachingNonCaMKIIFromE) and #macro(ApproachingCaMKIIFromN)    and #macro(ActivatedCaMBindsToOneOfOneCaMKII))))) }
%
%   Cell is Fluid. South is an approaching activated CaM. There is one other approaching particle and it is a CaMKII.
%   South wins right to advance. A CaM-CaMKII complex is formed.
%
rule : 0 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromS) and #macro(ActivatedCaMBindsToOneOfOneCaMKII) and (
               (#macro(FromSWinsOverE) and #macro(ApproachingCaMKIIFromE) and #macro(CellToNIsNotApproaching) and #macro(CellToWIsNotApproaching)) or
               (#macro(FromSWinsOverN) and #macro(ApproachingCaMKIIFromN) and #macro(CellToEIsNotApproaching) and #macro(CellToWIsNotApproaching)) or
               (#macro(FromSWinsOverW) and #macro(ApproachingCaMKIIFromW) and #macro(CellToEIsNotApproaching) and #macro(CellToNIsNotApproaching))) }
%                         
% Rules for a Fluid when a CaMKII is approaching and at least one activated CaM is approaching. 
%
%   Cell is Fluid. East is an approaching CaMKII. There are three other approaching particles at least one of which is an activated CaM. 
%   East wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 41 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromE) and #macro(FromEWinsOverNWS) and (
             (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfThreeActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingNonActivatedCaMFromW) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingNonActivatedCaMFromW) and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
             (#macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
             (#macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingNonActivatedCaMFromW) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM))) }
%
%   Cell is Fluid. East is an approaching CaMKII. There are two other approaching particles at least one of which is an activated CaM. 
%   East wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 41 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromE) and (
               (#macro(FromEWinsOverWS) and #macro(CellToNIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromW) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM)))) or 
               (#macro(FromEWinsOverNS) and #macro(CellToWIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM)))) or 
               (#macro(FromEWinsOverNW) and #macro(CellToSIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingNonActivatedCaMFromW) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM))))) }
%
%   Cell is Fluid. East is an approaching CaMKII. There is one other approaching particle and it is an activated CaM.
%   East wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 41 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromE) and #macro(CaMKIIBindsToOneOfOneActivatedCaM) and (
               (#macro(FromEWinsOverN) and #macro(ApproachingActivatedCaMFromN) and #macro(CellToWIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromEWinsOverW) and #macro(ApproachingActivatedCaMFromW) and #macro(CellToNIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromEWinsOverS) and #macro(ApproachingActivatedCaMFromS) and #macro(CellToNIsNotApproaching) and #macro(CellToWIsNotApproaching))) }
%                         
%   Cell is Fluid. North is an approaching CaMKII. There are three other approaching particles at least one of which is an activated CaM. 
%   North wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 42 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromN) and #macro(FromNWinsOverEWS) and (
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfThreeActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromW) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromW) and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
             (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
             (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingNonActivatedCaMFromW) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM))) }
%                         
%   Cell is Fluid. North is an approaching CaMKII. There are two other approaching particles at least one of which is an activated CaM. 
%   North wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 42 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromN) and (
               (#macro(FromNWinsOverWS) and #macro(CellToEIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromW)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromW) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM)))) or 
               (#macro(FromNWinsOverES) and #macro(CellToWIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM)))) or 
               (#macro(FromNWinsOverEW) and #macro(CellToSIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromW) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM))))) }
%
%   Cell is Fluid. North is an approaching CaMKII. There is one other approaching particle and it is an activated CaM.
%   North wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 42 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromN) and #macro(CaMKIIBindsToOneOfOneActivatedCaM) and ( 
               (#macro(FromNWinsOverE) and #macro(ApproachingActivatedCaMFromE) and #macro(CellToWIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromNWinsOverW) and #macro(ApproachingActivatedCaMFromW) and #macro(CellToEIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromNWinsOverS) and #macro(ApproachingActivatedCaMFromS) and #macro(CellToEIsNotApproaching) and #macro(CellToWIsNotApproaching))) }
%                         
%   Cell is Fluid. West is an approaching CaMKII. There are three other approaching particles at least one of which is an activated CaM. 
%   West wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 43 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromW) and #macro(FromWWinsOverENS) and (
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfThreeActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
             (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
             (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM))) }
%                         
%   Cell is Fluid. West is an approaching CaMKII. There are two other approaching particles at least one of which is an activated CaM. 
%   West wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 43 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromW) and (
               (#macro(FromWWinsOverNS) and #macro(CellToEIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM)))) or 
               (#macro(FromWWinsOverES) and #macro(CellToNIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromS)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM)))) or 
               (#macro(FromWWinsOverEN) and #macro(CellToSIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromN)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromN) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromN)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM))))) }
%
%   Cell is Fluid. West is an approaching CaMKII. There is one other approaching particle and it is an activated CaM.
%   West wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 43 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromW) and #macro(CaMKIIBindsToOneOfOneActivatedCaM) and (
               (#macro(FromWWinsOverE) and #macro(ApproachingActivatedCaMFromE) and #macro(CellToNIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromWWinsOverN) and #macro(ApproachingActivatedCaMFromN) and #macro(CellToEIsNotApproaching) and #macro(CellToSIsNotApproaching)) or
               (#macro(FromWWinsOverS) and #macro(ApproachingActivatedCaMFromS) and #macro(CellToEIsNotApproaching) and #macro(CellToNIsNotApproaching))) }
%                         
%   Cell is Fluid. South is an approaching CaMKII. There are three other approaching particles at least one of which is an activated CaM. 
%   South wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 44 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromS) and #macro(FromSWinsOverENW) and (
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfThreeActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingNonActivatedCaMFromW) and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
             (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingNonActivatedCaMFromW) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
             (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingNonActivatedCaMFromW) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
             (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM))) }
%                         
%   Cell is Fluid. South is an approaching CaMKII. There are two other approaching particles at least one of which is an activated CaM. 
%   South wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 44 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromS) and (
               (#macro(FromSWinsOverNW) and #macro(CellToEIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromN)    and #macro(ApproachingNonActivatedCaMFromW) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromN) and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM))) ) or 
               (#macro(FromSWinsOverEW) and #macro(CellToNIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromW) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromW)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM))) ) or 
               (#macro(FromSWinsOverEN) and #macro(CellToWIsNotApproaching) and (
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingActivatedCaMFromN)    and #macro(CaMKIIBindsToOneOfTwoActivatedCaMs)) or 
                 (#macro(ApproachingActivatedCaMFromE)    and #macro(ApproachingNonActivatedCaMFromN) and #macro(CaMKIIBindsToOneOfOneActivatedCaM)) or 
                 (#macro(ApproachingNonActivatedCaMFromE) and #macro(ApproachingActivatedCaMFromN)    and #macro(CaMKIIBindsToOneOfOneActivatedCaM))))) }
%
%   Cell is Fluid. South is an approaching CaMKII. There is one other approaching particle and it is an activated CaM.
%   South wins right to advance. A CaM-CaMKII complex is formed.
%
rule : { 44 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromS) and #macro(CaMKIIBindsToOneOfOneActivatedCaM) and (
               (#macro(FromSWinsOverE) and #macro(ApproachingActivatedCaMFromE) and #macro(CellToNIsNotApproaching) and #macro(CellToWIsNotApproaching)) or
               (#macro(FromSWinsOverN) and #macro(ApproachingActivatedCaMFromN) and #macro(CellToEIsNotApproaching) and #macro(CellToWIsNotApproaching)) or
               (#macro(FromSWinsOverW) and #macro(ApproachingActivatedCaMFromW) and #macro(CellToEIsNotApproaching) and #macro(CellToNIsNotApproaching))) }
%
% Rules for when cell is an activated CaM and a reaction occurs.
%
%   Cell is an activated CaM from east. Cell to west is Fluid. Cell loses at west to three particles at least one of which is a CaMKII. 
%   CaMKII moves into Fluid at west. There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid) and (
             (#macro(ApproachingCaMKIIFromNAtW) and #macro(FromNWinsAtWOverEWS) and (
                (#macro(ApproachingActivatedCaMFromWAtW) and #macro(ApproachingActivatedCaMFromSAtW) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverWSAtW)) or
                (#macro(ApproachingActivatedCaMFromWAtW) and #macro(ApproachingNonActivatedCaMFromSAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverWAtW)) or
                (#macro(ApproachingNonActivatedCaMFromWAtW) and #macro(ApproachingActivatedCaMFromSAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverSAtW)) or
                (#macro(ApproachingNonActivatedCaMFromWAtW) and #macro(ApproachingNonActivatedCaMFromSAtW) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW)))) or
             (#macro(ApproachingCaMKIIFromWAtW) and #macro(FromWWinsAtWOverENS) and (
                (#macro(ApproachingActivatedCaMFromNAtW) and #macro(ApproachingActivatedCaMFromSAtW) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverNSAtW)) or
                (#macro(ApproachingActivatedCaMFromNAtW) and #macro(ApproachingNonActivatedCaMFromSAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverNAtW)) or
                (#macro(ApproachingNonActivatedCaMFromNAtW) and #macro(ApproachingActivatedCaMFromSAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverSAtW)) or
                (#macro(ApproachingNonActivatedCaMFromNAtW) and #macro(ApproachingNonActivatedCaMFromSAtW) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW)))) or 
             (#macro(ApproachingCaMKIIFromSAtW) and #macro(FromSWinsAtWOverENW) and (
                (#macro(ApproachingActivatedCaMFromNAtW) and #macro(ApproachingActivatedCaMFromWAtW) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverNWAtW)) or
                (#macro(ApproachingActivatedCaMFromNAtW) and #macro(ApproachingNonActivatedCaMFromWAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverNAtW)) or
                (#macro(ApproachingNonActivatedCaMFromNAtW) and #macro(ApproachingActivatedCaMFromWAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverWAtW)) or
                (#macro(ApproachingNonActivatedCaMFromNAtW) and #macro(ApproachingNonActivatedCaMFromWAtW) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW))))) }
%
%   Cell is an activated CaM from east. Cell to west is Fluid. Cell loses at west to two particles at least one of which is a CaMKII. 
%   CaMKII moves into Fluid at west. There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid) and (
             (#macro(ApproachingCaMKIIFromNAtW) and (
                (#macro(FromNWinsAtWOverEW) and #macro(ApproachingActivatedCaMFromWAtW) and #macro(CellToSIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverWAtW)) or
                (#macro(FromNWinsAtWOverEW) and #macro(ApproachingNonActivatedCaMFromWAtW) and #macro(CellToSIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW)) or
                (#macro(FromNWinsAtWOverES) and #macro(ApproachingActivatedCaMFromSAtW) and #macro(CellToWIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverSAtW)) or
                (#macro(FromNWinsAtWOverES) and #macro(ApproachingNonActivatedCaMFromSAtW) and #macro(CellToWIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW)))) or
             (#macro(ApproachingCaMKIIFromWAtW) and ( 
                (#macro(FromWWinsAtWOverEN) and #macro(ApproachingActivatedCaMFromNAtW) and #macro(CellToSIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverNAtW)) or
                (#macro(FromWWinsAtWOverEN) and #macro(ApproachingNonActivatedCaMFromNAtW) and #macro(CellToSIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW)) or
                (#macro(FromWWinsAtWOverES) and #macro(ApproachingActivatedCaMFromSAtW) and #macro(CellToNIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverSAtW)) or
                (#macro(FromWWinsAtWOverES) and #macro(ApproachingNonActivatedCaMFromSAtW) and #macro(CellToNIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW)))) or
             (#macro(ApproachingCaMKIIFromSAtW) and (
                (#macro(FromSWinsAtWOverEN) and #macro(ApproachingActivatedCaMFromNAtW) and #macro(CellToWIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverNAtW)) or
                (#macro(FromSWinsAtWOverEN) and #macro(ApproachingNonActivatedCaMFromNAtW) and #macro(CellToWIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW)) or
                (#macro(FromSWinsAtWOverEW) and #macro(ApproachingActivatedCaMFromWAtW) and #macro(CellToNIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtW) and #macro(ActivatedCaMToECombinesOverWAtW)) or
                (#macro(FromSWinsAtWOverEW) and #macro(ApproachingNonActivatedCaMFromWAtW) and #macro(CellToNIsNotApproachingAtW) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW))))) }               
%
%   Cell is an activated CaM from east. Cell to west is Fluid. Cell loses at west to one particle which is a CaMKII. 
%   There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid) and (
             (#macro(ApproachingCaMKIIFromNAtW) and #macro(FromNWinsAtWOverE) and 
              #macro(CellToWIsNotApproachingAtW) and #macro(CellToSIsNotApproachingAtW) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW)) or
             (#macro(ApproachingCaMKIIFromWAtW) and #macro(FromWWinsAtWOverE) and 
              #macro(CellToNIsNotApproachingAtW) and #macro(CellToSIsNotApproachingAtW) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW)) or
             (#macro(ApproachingCaMKIIFromSAtW) and #macro(FromSWinsAtWOverE) and 
              #macro(CellToNIsNotApproachingAtW) and #macro(CellToWIsNotApproachingAtW) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtW))) }
%
%   Cell is an activated CaM from north. Cell to south is Fluid. Cell loses at south to three particles at least one of which is a CaMKII. 
%   CaMKII moves into Fluid at south. There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) and ( 
             (#macro(ApproachingCaMKIIFromEAtS) and #macro(FromEWinsAtSOverNWS) and (
                (#macro(ApproachingActivatedCaMFromWAtS) and #macro(ApproachingActivatedCaMFromSAtS) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverWSAtS)) or
                (#macro(ApproachingActivatedCaMFromWAtS) and #macro(ApproachingNonActivatedCaMFromSAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverWAtS)) or
                (#macro(ApproachingNonActivatedCaMFromWAtS) and #macro(ApproachingActivatedCaMFromSAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverSAtS)) or
                (#macro(ApproachingNonActivatedCaMFromWAtS) and #macro(ApproachingNonActivatedCaMFromSAtS) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtS)))) or
             (#macro(ApproachingCaMKIIFromWAtS) and #macro(FromWWinsAtSOverENS) and (
                (#macro(ApproachingActivatedCaMFromEAtS) and #macro(ApproachingActivatedCaMFromSAtS) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverESAtS)) or
                (#macro(ApproachingActivatedCaMFromEAtS) and #macro(ApproachingNonActivatedCaMFromSAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverEAtS)) or
                (#macro(ApproachingNonActivatedCaMFromEAtS) and #macro(ApproachingActivatedCaMFromSAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverSAtS)) or
                (#macro(ApproachingNonActivatedCaMFromEAtS) and #macro(ApproachingNonActivatedCaMFromSAtS) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtS)))) or 
             (#macro(ApproachingCaMKIIFromSAtS) and #macro(FromSWinsAtSOverENW) and (
                (#macro(ApproachingActivatedCaMFromEAtS) and #macro(ApproachingActivatedCaMFromWAtS) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverEWAtS)) or
                (#macro(ApproachingActivatedCaMFromEAtS) and #macro(ApproachingNonActivatedCaMFromWAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverEAtS)) or
                (#macro(ApproachingNonActivatedCaMFromEAtS) and #macro(ApproachingActivatedCaMFromWAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverWAtS)) or
                (#macro(ApproachingNonActivatedCaMFromEAtS) and #macro(ApproachingNonActivatedCaMFromWAtS) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtS))))) }
%
%   Cell is an activated CaM from north. Cell to south is Fluid. Cell loses at south to two particles at least one of which is a CaMKII. 
%   CaMKII moves into Fluid at south. There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) and (
             (#macro(ApproachingCaMKIIFromEAtS) and ( 
                (#macro(FromEWinsAtSOverNW) and #macro(ApproachingActivatedCaMFromWAtS) and #macro(CellToSIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverWAtS)) or
                (#macro(FromEWinsAtSOverNW) and #macro(ApproachingNonActivatedCaMFromWAtS) and #macro(CellToSIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfoneActivatedCaMAtS)) or
                (#macro(FromEWinsAtSOverNS) and #macro(ApproachingActivatedCaMFromSAtS) and #macro(CellToWIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverSAtS)) or
                (#macro(FromEWinsAtSOverNS) and #macro(ApproachingNonActivatedCaMFromSAtS) and #macro(CellToWIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtS)))) or
             (#macro(ApproachingCaMKIIFromWAtS) and (
                (#macro(FromWWinsAtSOverEN) and #macro(ApproachingActivatedCaMFromEAtS) and #macro(CellToSIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverEAtS)) or
                (#macro(FromWWinsAtSOverEN) and #macro(ApproachingNonActivatedCaMFromEAtS) and #macro(CellToSIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtS)) or
                (#macro(FromWWinsAtSOverNS) and #macro(ApproachingActivatedCaMFromSAtS) and #macro(CellToEIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverSAtS)) or
                (#macro(FromWWinsAtSOverNS) and #macro(ApproachingNonActivatedCaMFromSAtS) and #macro(CellToEIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtS)))) or
             (#macro(ApproachingCaMKIIFromSAtS) and (
                (#macro(FromSWinsAtSOverEN) and #macro(ApproachingActivatedCaMFromEAtS) and #macro(CellToWIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverEAtS)) or
                (#macro(FromSWinsAtSOverEN) and #macro(ApproachingNonActivatedCaMFromEAtS) and #macro(CellToWIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtS)) or
                (#macro(FromSWinsAtSOverNW) and #macro(ApproachingActivatedCaMFromWAtS) and #macro(CellToEIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtS) and #macro(ActivatedCaMToNCombinesOverWAtS)) or
                (#macro(FromSWinsAtSOverNW) and #macro(ApproachingNonActivatedCaMFromWAtS) and #macro(CellToEIsNotApproachingAtS) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtS))))) }               
%
%   Cell is an activated CaM from north. Cell to south is Fluid. Cell loses at south to one particle which is a CaMKII. 
%   There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) and (
             (#macro(ApproachingCaMKIIFromEAtS) and #macro(FromEWinsAtSOverN) and 
              #macro(CellToWIsNotApproachingAtS) and #macro(CellToSIsNotApproachingAtS) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtS)) or
             (#macro(ApproachingCaMKIIFromWAtS) and #macro(FromWWinsAtSOverN) and 
              #macro(CellToEIsNotApproachingAtS) and #macro(CellToSIsNotApproachingAtS) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtS)) or
             (#macro(ApproachingCaMKIIFromSAtS) and #macro(FromSWinsAtSOverN) and 
              #macro(CellToEIsNotApproachingAtS) and #macro(CellToWIsNotApproachingAtS) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtS))) }
%
%   Cell is an activated CaM from west. Cell to east is Fluid. Cell loses at east to three particles at least one of which is a CaMKII. 
%   CaMKII moves into Fluid at east. There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) and (
             (#macro(ApproachingCaMKIIFromEAtE) and #macro(FromEWinsAtEOverNWS) and (
                (#macro(ApproachingActivatedCaMFromNAtE) and #macro(ApproachingActivatedCaMFromSAtE) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverNSAtE)) or
                (#macro(ApproachingActivatedCaMFromNAtE) and #macro(ApproachingNonActivatedCaMFromSAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverNAtE)) or
                (#macro(ApproachingNonActivatedCaMFromNAtE) and #macro(ApproachingActivatedCaMFromSAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverSAtE)) or
                (#macro(ApproachingNonActivatedCaMFromNAtE) and #macro(ApproachingNonActivatedCaMFromSAtE) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE)))) or
             (#macro(ApproachingCaMKIIFromNAtE) and #macro(FromNWinsAtEOverEWS) and (
                (#macro(ApproachingActivatedCaMFromEAtE) and #macro(ApproachingActivatedCaMFromSAtE) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverESAtE)) or
                (#macro(ApproachingActivatedCaMFromEAtE) and #macro(ApproachingNonActivatedCaMFromSAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverEAtE)) or
                (#macro(ApproachingNonActivatedCaMFromEAtE) and #macro(ApproachingActivatedCaMFromSAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverSAtE)) or
                (#macro(ApproachingNonActivatedCaMFromEAtE) and #macro(ApproachingNonActivatedCaMFromSAtE) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE)))) or 
             (#macro(ApproachingCaMKIIFromSAtE) and #macro(FromSWinsAtEOverENW) and (
                (#macro(ApproachingActivatedCaMFromEAtE) and #macro(ApproachingActivatedCaMFromNAtE) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverENAtE)) or
                (#macro(ApproachingActivatedCaMFromEAtE) and #macro(ApproachingNonActivatedCaMFromNAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverEAtE)) or
                (#macro(ApproachingNonActivatedCaMFromEAtE) and #macro(ApproachingActivatedCaMFromNAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverNAtE)) or
                (#macro(ApproachingNonActivatedCaMFromEAtE) and #macro(ApproachingNonActivatedCaMFromNAtE) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE))))) }
%
%   Cell is an activated CaM from west. Cell to east is Fluid. Cell loses at east to two particles at least one of which is a CaMKII. 
%   CaMKII moves into Fluid at east. There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) and (
             (#macro(ApproachingCaMKIIFromEAtE) and (
                (#macro(FromEWinsAtEOverNW) and #macro(ApproachingActivatedCaMFromNAtE) and #macro(CellToSIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverNAtE)) or
                (#macro(FromEWinsAtEOverNW) and #macro(ApproachingNonActivatedCaMFromNAtE) and #macro(CellToSIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE)) or
                (#macro(FromEWinsAtEOverWS) and #macro(ApproachingActivatedCaMFromSAtE) and #macro(CellToNIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverSAtE)) or
                (#macro(FromEWinsAtEOverWS) and #macro(ApproachingNonActivatedCaMFromSAtE) and #macro(CellToNIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE)))) or
             (#macro(ApproachingCaMKIIFromNAtE) and ( 
                (#macro(FromNWinsAtEOverEW) and #macro(ApproachingActivatedCaMFromEAtE) and #macro(CellToSIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverEAtE)) or
                (#macro(FromNWinsAtEOverEW) and #macro(ApproachingNonActivatedCaMFromEAtE) and #macro(CellToSIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE)) or
                (#macro(FromNWinsAtEOverWS) and #macro(ApproachingActivatedCaMFromSAtE) and #macro(CellToEIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverSAtE)) or
                (#macro(FromNWinsAtEOverWS) and #macro(ApproachingNonActivatedCaMFromSAtE) and #macro(CellToEIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE)))) or
             (#macro(ApproachingCaMKIIFromSAtE) and (
                (#macro(FromSWinsAtEOverEW) and #macro(ApproachingActivatedCaMFromEAtE) and #macro(CellToNIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverEAtE)) or
                (#macro(FromSWinsAtEOverEW) and #macro(ApproachingNonActivatedCaMFromEAtE) and #macro(CellToNIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE)) or
                (#macro(FromSWinsAtEOverNW) and #macro(ApproachingActivatedCaMFromNAtE) and #macro(CellToEIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtE) and #macro(ActivatedCaMToWCombinesOverNAtE)) or
                (#macro(FromSWinsAtEOverNW) and #macro(ApproachingNonActivatedCaMFromNAtE) and #macro(CellToEIsNotApproachingAtE) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE))))) }               
%
%   Cell is an activated CaM from west. Cell to east is Fluid. Cell loses at east to one particle which is a CaMKII. 
%   There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) and (
             (#macro(ApproachingCaMKIIFromEAtE) and #macro(FromEWinsAtEOverW) and 
              #macro(CellToNIsNotApproachingAtE) and #macro(CellToSIsNotApproachingAtE) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE)) or
             (#macro(ApproachingCaMKIIFromNAtE) and #macro(FromNWinsAtEOverW) and 
              #macro(CellToEIsNotApproachingAtE) and #macro(CellToSIsNotApproachingAtE) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE)) or
             (#macro(ApproachingCaMKIIFromSAtE) and #macro(FromSWinsAtEOverW) and 
              #macro(CellToEIsNotApproachingAtE) and #macro(CellToNIsNotApproachingAtE) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtE))) }
%
%   Cell is an activated CaM from south. Cell to north is Fluid. Cell loses at north to three particles at least one of which is a CaMKII. 
%   CaMKII moves into Fluid at north. There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) and (
             (#macro(ApproachingCaMKIIFromEAtN) and #macro(FromEWinsAtNOverNWS) and ( 
                (#macro(ApproachingActivatedCaMFromNAtN) and #macro(ApproachingActivatedCaMFromWAtN) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverNWAtN)) or
                (#macro(ApproachingActivatedCaMFromNAtN) and #macro(ApproachingNonActivatedCaMFromWAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverNAtN)) or
                (#macro(ApproachingNonActivatedCaMFromNAtN) and #macro(ApproachingActivatedCaMFromWAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverWAtN)) or
                (#macro(ApproachingNonActivatedCaMFromNAtN) and #macro(ApproachingNonActivatedCaMFromWAtN) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN)))) or
             (#macro(ApproachingCaMKIIFromNAtN) and #macro(FromNWinsAtNOverEWS) and (
                (#macro(ApproachingActivatedCaMFromEAtN) and #macro(ApproachingActivatedCaMFromWAtN) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverEWAtN)) or
                (#macro(ApproachingActivatedCaMFromEAtN) and #macro(ApproachingNonActivatedCaMFromWAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverEAtN)) or
                (#macro(ApproachingNonActivatedCaMFromEAtN) and #macro(ApproachingActivatedCaMFromWAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverWAtN)) or
                (#macro(ApproachingNonActivatedCaMFromEAtN) and #macro(ApproachingNonActivatedCaMFromWAtN) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN)))) or 
             (#macro(ApproachingCaMKIIFromWAtN) and #macro(FromWWinsAtNOverENS) and (
                (#macro(ApproachingActivatedCaMFromEAtN) and #macro(ApproachingActivatedCaMFromNAtN) and
                 #macro(CaMKIIBindsToOneOfThreeActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverENAtN)) or
                (#macro(ApproachingActivatedCaMFromEAtN) and #macro(ApproachingNonActivatedCaMFromNAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverEAtN)) or
                (#macro(ApproachingNonActivatedCaMFromEAtN) and #macro(ApproachingActivatedCaMFromNAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverNAtN)) or
                (#macro(ApproachingNonActivatedCaMFromEAtN) and #macro(ApproachingNonActivatedCaMFromNAtN) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN))))) }
%
%   Cell is an activated CaM from south. Cell to north is Fluid. Cell loses at north to two particles at least one of which is a CaMKII. 
%   CaMKII moves into Fluid at north. There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) and (
             (#macro(ApproachingCaMKIIFromEAtN) and (
                (#macro(FromEWinsAtNOverNS) and #macro(ApproachingActivatedCaMFromNAtN) and #macro(CellToWIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverNAtN)) or
                (#macro(FromEWinsAtNOverNS) and #macro(ApproachingNonActivatedCaMFromNAtN) and #macro(CellToWIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN)) or
                (#macro(FromEWinsAtNOverWS) and #macro(ApproachingActivatedCaMFromWAtN) and #macro(CellToNIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverWAtN)) or
                (#macro(FromEWinsAtNOverWS) and #macro(ApproachingNonActivatedCaMFromWAtN) and #macro(CellToNIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN)))) or
             (#macro(ApproachingCaMKIIFromNAtN) and ( 
                (#macro(FromNWinsAtNOverES) and #macro(ApproachingActivatedCaMFromEAtN) and #macro(CellToWIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverEAtN)) or
                (#macro(FromNWinsAtNOverES) and #macro(ApproachingNonActivatedCaMFromEAtN) and #macro(CellToWIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN)) or
                (#macro(FromNWinsAtNOverWS) and #macro(ApproachingActivatedCaMFromWAtN) and #macro(CellToEIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverWAtN)) or
                (#macro(FromNWinsAtNOverWS) and #macro(ApproachingNonActivatedCaMFromWAtN) and #macro(CellToEIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN)))) or
             (#macro(ApproachingCaMKIIFromWAtN) and (
                (#macro(FromWWinsAtNOverES) and #macro(ApproachingActivatedCaMFromEAtN) and #macro(CellToNIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverEAtN)) or
                (#macro(FromWWinsAtNOverES) and #macro(ApproachingNonActivatedCaMFromEAtN) and #macro(CellToNIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN)) or
                (#macro(FromWWinsAtNOverNS) and #macro(ApproachingActivatedCaMFromNAtN) and #macro(CellToEIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfTwoActivatedCaMsAtN) and #macro(ActivatedCaMToSCombinesOverNAtN)) or
                (#macro(FromWWinsAtNOverNS) and #macro(ApproachingActivatedCaMFromNAtN) and #macro(CellToEIsNotApproachingAtN) and
                 #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN))))) }               
%
%   Cell is an activated CaM from south. Cell to north is Fluid. Cell loses at north to one particle which is a CaMKII. 
%   There is a reaction.
%
rule : 0 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) and (
             (#macro(ApproachingCaMKIIFromEAtN) and #macro(FromEWinsAtNOverS) and 
              #macro(CellToNIsNotApproachingAtN) and #macro(CellToWIsNotApproachingAtN) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN)) or
             (#macro(ApproachingCaMKIIFromNAtN) and #macro(FromNWinsAtNOverS) and 
              #macro(CellToEIsNotApproachingAtN) and #macro(CellToWIsNotApproachingAtN) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN)) or
             (#macro(ApproachingCaMKIIFromWAtN) and #macro(FromWWinsAtNOverS) and 
              #macro(CellToEIsNotApproachingAtN) and #macro(CellToNIsNotApproachingAtN) and
              #macro(CaMKIIBindsToOneOfOneActivatedCaMAtN))) }
%
% Rules for when cell is a CaMKII and a reaction occurs.
%
%   Cell is a CaMKII from east. Cell to west is Fluid. Cell loses at west to three particles at least one of which is an activated CaM. 
%   Activated CaM moves into Fluid at west. There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) and (
             (#macro(ApproachingActivatedCaMFromNAtW) and #macro(FromNWinsAtWOverEWS) and (
                (#macro(ApproachingCaMKIIFromWAtW) and #macro(ApproachingCaMKIIFromSAtW) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtW) and #macro(CaMKIIToECombinesOverWSAtW)) or
                (#macro(ApproachingCaMKIIFromWAtW) and #macro(ApproachingNonCaMKIIFromSAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverWAtW)) or
                (#macro(ApproachingNonCaMKIIFromWAtW) and #macro(ApproachingCaMKIIFromSAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverSAtW)) or
                (#macro(ApproachingNonCaMKIIFromWAtW) and #macro(ApproachingNonCaMKIIFromSAtW) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW)))) or
             (#macro(ApproachingActivatedCaMFromWAtW) and #macro(FromWWinsAtWOverENS) and (
                (#macro(ApproachingCaMKIIFromNAtW) and #macro(ApproachingCaMKIIFromSAtW) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtW) and #macro(CaMKIIToECombinesOverNSAtW)) or
                (#macro(ApproachingCaMKIIFromNAtW) and #macro(ApproachingNonCaMKIIFromSAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverNAtW)) or
                (#macro(ApproachingNonCaMKIIFromNAtW) and #macro(ApproachingCaMKIIFromSAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverSAtW)) or
                (#macro(ApproachingNonCaMKIIFromNAtW) and #macro(ApproachingNonCaMKIIFromSAtW) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW)))) or 
             (#macro(ApproachingActivatedCaMFromSAtW) and #macro(FromSWinsAtWOverENW) and (
                (#macro(ApproachingCaMKIIFromNAtW) and #macro(ApproachingCaMKIIFromWAtW) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtW) and #macro(CaMKIIToECombinesOverNWAtW)) or
                (#macro(ApproachingCaMKIIFromNAtW) and #macro(ApproachingNonCaMKIIFromWAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverNAtW)) or
                (#macro(ApproachingNonCaMKIIFromNAtW) and #macro(ApproachingCaMKIIFromWAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverWAtW)) or
                (#macro(ApproachingNonCaMKIIFromNAtW) and #macro(ApproachingNonCaMKIIFromWAtW) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW))))) }
%
%   Cell is a CaMKII from east. Cell to west is Fluid. Cell loses at west to two particles at least one of which is an activated CaM. 
%   Activated CaM moves into Fluid at west. There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) and (
             (#macro(ApproachingActivatedCaMFromNAtW) and (
                (#macro(FromNWinsAtWOverEW) and #macro(ApproachingCaMKIIFromWAtW) and #macro(CellToSIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverWAtW)) or
                (#macro(FromNWinsAtWOverEW) and #macro(ApproachingNonCaMKIIFromWAtW) and #macro(CellToSIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW)) or
                (#macro(FromNWinsAtWOverES) and #macro(ApproachingCaMKIIFromSAtW) and #macro(CellToWIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverSAtW)) or
                (#macro(FromNWinsAtWOverES) and #macro(ApproachingNonCaMKIIFromSAtW) and #macro(CellToWIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW)))) or
             (#macro(ApproachingActivatedCaMFromWAtW) and ( 
                (#macro(FromWWinsAtWOverEN) and #macro(ApproachingCaMKIIFromNAtW) and #macro(CellToSIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverNAtW)) or
                (#macro(FromWWinsAtWOverEN) and #macro(ApproachingNonCaMKIIFromNAtW) and #macro(CellToSIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW)) or
                (#macro(FromWWinsAtWOverES) and #macro(ApproachingCaMKIIFromSAtW) and #macro(CellToNIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverSAtW)) or
                (#macro(FromWWinsAtWOverES) and #macro(ApproachingNonCaMKIIFromSAtW) and #macro(CellToNIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW)))) or
             (#macro(ApproachingActivatedCaMFromSAtW) and (
                (#macro(FromSWinsAtWOverEN) and #macro(ApproachingCaMKIIFromNAtW) and #macro(CellToWIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverNAtW)) or
                (#macro(FromSWinsAtWOverEN) and #macro(ApproachingNonCaMKIIFromNAtW) and #macro(CellToWIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW)) or
                (#macro(FromSWinsAtWOverEW) and #macro(ApproachingCaMKIIFromWAtW) and #macro(CellToNIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtW) and #macro(CaMKIIToECombinesOverWAtW)) or
                (#macro(FromSWinsAtWOverEW) and #macro(ApproachingNonCaMKIIFromWAtW) and #macro(CellToNIsNotApproachingAtW) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW))))) }               
%
%   Cell is a CaMKII from east. Cell to west is Fluid. Cell loses at west to one particle which is an activated CaM. 
%   There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) and (
             (#macro(ApproachingActivatedCaMFromNAtW) and #macro(FromNWinsAtWOverE) and 
              #macro(CellToWIsNotApproachingAtW) and #macro(CellToSIsNotApproachingAtW) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW)) or
             (#macro(ApproachingActivatedCaMFromWAtW) and #macro(FromWWinsAtWOverE) and 
              #macro(CellToNIsNotApproachingAtW) and #macro(CellToSIsNotApproachingAtW) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW)) or
             (#macro(ApproachingActivatedCaMFromSAtW) and #macro(FromSWinsAtWOverE) and 
              #macro(CellToNIsNotApproachingAtW) and #macro(CellToWIsNotApproachingAtW) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtW))) }
%
%   Cell is a CaMKII from north. Cell to south is Fluid. Cell loses at south to three particles at least one of which is an activated CaM. 
%   Activated CaM moves into Fluid at south. There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) and ( 
             (#macro(ApproachingActivatedCaMFromEAtS) and #macro(FromEWinsAtSOverNWS) and (
                (#macro(ApproachingCaMKIIFromWAtS) and #macro(ApproachingCaMKIIFromSAtS) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverWSAtS)) or
                (#macro(ApproachingCaMKIIFromWAtS) and #macro(ApproachingNonCaMKIIFromSAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverWAtS)) or
                (#macro(ApproachingNonCaMKIIFromWAtS) and #macro(ApproachingCaMKIIFromSAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverSAtS)) or
                (#macro(ApproachingNonCaMKIIFromWAtS) and #macro(ApproachingNonCaMKIIFromSAtS) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtS)))) or
             (#macro(ApproachingActivatedCaMFromWAtS) and #macro(FromWWinsAtSOverENS) and (
                (#macro(ApproachingCaMKIIFromEAtS) and #macro(ApproachingCaMKIIFromSAtS) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverESAtS)) or
                (#macro(ApproachingCaMKIIFromEAtS) and #macro(ApproachingNonCaMKIIFromSAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverEAtS)) or
                (#macro(ApproachingNonCaMKIIFromEAtS) and #macro(ApproachingCaMKIIFromSAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverSAtS)) or
                (#macro(ApproachingNonCaMKIIFromEAtS) and #macro(ApproachingNonCaMKIIFromSAtS) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtS)))) or 
             (#macro(ApproachingActivatedCaMFromSAtS) and #macro(FromSWinsAtSOverENW) and (
                (#macro(ApproachingCaMKIIFromEAtS) and #macro(ApproachingCaMKIIFromWAtS) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverEWAtS)) or
                (#macro(ApproachingCaMKIIFromEAtS) and #macro(ApproachingNonCaMKIIFromWAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverEAtS)) or
                (#macro(ApproachingNonCaMKIIFromEAtS) and #macro(ApproachingCaMKIIFromWAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverWAtS)) or
                (#macro(ApproachingNonCaMKIIFromEAtS) and #macro(ApproachingNonCaMKIIFromWAtS) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtS))))) }
%
%   Cell is a CaMKII from north. Cell to south is Fluid. Cell loses at south to two particles at least one of which is an activated CaM. 
%   Activated CaM moves into Fluid at south. There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) and (
             (#macro(ApproachingActivatedCaMFromEAtS) and ( 
                (#macro(FromEWinsAtSOverNW) and #macro(ApproachingCaMKIIFromWAtS) and #macro(CellToSIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverWAtS)) or
                (#macro(FromEWinsAtSOverNW) and #macro(ApproachingNonCaMKIIFromWAtS) and #macro(CellToSIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtS)) or
                (#macro(FromEWinsAtSOverNS) and #macro(ApproachingCaMKIIFromSAtS) and #macro(CellToWIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverSAtS)) or
                (#macro(FromEWinsAtSOverNS) and #macro(ApproachingNonCaMKIIFromSAtS) and #macro(CellToWIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfoneCaMKIIAtS)))) or
             (#macro(ApproachingActivatedCaMFromWAtS) and (
                (#macro(FromWWinsAtSOverEN) and #macro(ApproachingCaMKIIFromEAtS) and #macro(CellToSIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverEAtS)) or
                (#macro(FromWWinsAtSOverEN) and #macro(ApproachingNonCaMKIIFromEAtS) and #macro(CellToSIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtS)) or
                (#macro(FromWWinsAtSOverNS) and #macro(ApproachingCaMKIIFromSAtS) and #macro(CellToEIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverSAtS)) or
                (#macro(FromWWinsAtSOverNS) and #macro(ApproachingNonCaMKIIFromSAtS) and #macro(CellToEIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtS)))) or
             (#macro(ApproachingActivatedCaMFromSAtS) and (
                (#macro(FromSWinsAtSOverEN) and #macro(ApproachingCaMKIIFromEAtS) and #macro(CellToWIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverEAtS)) or
                (#macro(FromSWinsAtSOverEN) and #macro(ApproachingNonCaMKIIFromEAtS) and #macro(CellToWIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtS)) or
                (#macro(FromSWinsAtSOverNW) and #macro(ApproachingCaMKIIFromWAtS) and #macro(CellToEIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtS) and #macro(CaMKIIToNCombinesOverWAtS)) or
                (#macro(FromSWinsAtSOverNW) and #macro(ApproachingNonCaMKIIFromWAtS) and #macro(CellToEIsNotApproachingAtS) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtS))))) }               
%
%   Cell is a CaMKII from north. Cell to south is Fluid. Cell loses at south to one particle which is an activated CaM. 
%   There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) and (
             (#macro(ApproachingActivatedCaMFromEAtS) and #macro(FromEWinsAtSOverN) and 
              #macro(CellToWIsNotApproachingAtS) and #macro(CellToSIsNotApproachingAtS) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtS)) or
             (#macro(ApproachingActivatedCaMFromWAtS) and #macro(FromWWinsAtSOverN) and 
              #macro(CellToEIsNotApproachingAtS) and #macro(CellToSIsNotApproachingAtS) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtS)) or
             (#macro(ApproachingActivatedCaMFromSAtS) and #macro(FromSWinsAtSOverN) and 
              #macro(CellToEIsNotApproachingAtS) and #macro(CellToWIsNotApproachingAtS) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtS))) }
%
%   Cell is a CaMKII from west. Cell to east is Fluid. Cell loses at east to three particles at least one of which is an activated CaM. 
%   Activated CaM moves into Fluid at east. There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) and (
             (#macro(ApproachingActivatedCaMFromEAtE) and #macro(FromEWinsAtEOverNWS) and (
                (#macro(ApproachingCaMKIIFromNAtE) and #macro(ApproachingCaMKIIFromSAtE) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverNSAtE)) or
                (#macro(ApproachingCaMKIIFromNAtE) and #macro(ApproachingNonCaMKIIFromSAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverNAtE)) or
                (#macro(ApproachingNonCaMKIIFromNAtE) and #macro(ApproachingCaMKIIFromSAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverSAtE)) or
                (#macro(ApproachingNonCaMKIIFromNAtE) and #macro(ApproachingNonCaMKIIFromSAtE) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtE)))) or
             (#macro(ApproachingActivatedCaMFromNAtE) and #macro(FromNWinsAtEOverEWS) and (
                (#macro(ApproachingCaMKIIFromEAtE) and #macro(ApproachingCaMKIIFromSAtE) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverESAtE)) or
                (#macro(ApproachingCaMKIIFromEAtE) and #macro(ApproachingNonCaMKIIFromSAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverEAtE)) or
                (#macro(ApproachingNonCaMKIIFromEAtE) and #macro(ApproachingCaMKIIFromSAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverSAtE)) or
                (#macro(ApproachingNonCaMKIIFromEAtE) and #macro(ApproachingNonCaMKIIFromSAtE) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtE)))) or 
             (#macro(ApproachingActivatedCaMFromSAtE) and #macro(FromSWinsAtEOverENW) and (
                (#macro(ApproachingCaMKIIFromEAtE) and #macro(ApproachingCaMKIIFromNAtE) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverENAtE)) or
                (#macro(ApproachingCaMKIIFromEAtE) and #macro(ApproachingNonCaMKIIFromNAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverEAtE)) or
                (#macro(ApproachingNonCaMKIIFromEAtE) and #macro(ApproachingCaMKIIFromNAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverNAtE)) or
                (#macro(ApproachingNonCaMKIIFromEAtE) and #macro(ApproachingNonCaMKIIFromNAtE) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtE))))) }
%
%   Cell is a CaMKII from west. Cell to east is Fluid. Cell loses at east to two particles at least one of which is an activated CaM. 
%   Activated CaM moves into Fluid at east. There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) and (
             (#macro(ApproachingActivatedCaMFromEAtE) and (
                (#macro(FromEWinsAtEOverNW) and #macro(ApproachingCaMKIIFromNAtE) and #macro(CellToSIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverNAtE)) or
                (#macro(FromEWinsAtEOverNW) and #macro(ApproachingNonCaMKIIFromNAtE) and #macro(CellToSIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtE)) or
                (#macro(FromEWinsAtEOverWS) and #macro(ApproachingCaMKIIFromSAtE) and #macro(CellToNIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverSAtE)) or
                (#macro(FromEWinsAtEOverWS) and #macro(ApproachingNonCaMKIIFromSAtE) and #macro(CellToNIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverSAtE)))) or
             (#macro(ApproachingActivatedCaMFromNAtE) and ( 
                (#macro(FromNWinsAtEOverEW) and #macro(ApproachingCaMKIIFromEAtE) and #macro(CellToSIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverEAtE)) or
                (#macro(FromNWinsAtEOverEW) and #macro(ApproachingNonCaMKIIFromEAtE) and #macro(CellToSIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtE)) or
                (#macro(FromNWinsAtEOverWS) and #macro(ApproachingCaMKIIFromSAtE) and #macro(CellToEIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverSAtE)) or
                (#macro(FromNWinsAtEOverWS) and #macro(ApproachingNonCaMKIIFromSAtE) and #macro(CellToEIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtE)))) or
             (#macro(ApproachingActivatedCaMFromSAtE) and (
                (#macro(FromSWinsAtEOverEW) and #macro(ApproachingCaMKIIFromEAtE) and #macro(CellToNIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverEAtE)) or
                (#macro(FromSWinsAtEOverEW) and #macro(ApproachingNonCaMKIIFromEAtE) and #macro(CellToNIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtE)) or
                (#macro(FromSWinsAtEOverNW) and #macro(ApproachingCaMKIIFromNAtE) and #macro(CellToEIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtE) and #macro(CaMKIIToWCombinesOverNAtE)) or
                (#macro(FromSWinsAtEOverNW) and #macro(ApproachingNonCaMKIIFromNAtE) and #macro(CellToEIsNotApproachingAtE) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtE))))) }               
%
%   Cell is a CaMKII from west. Cell to east is Fluid. Cell loses at east to one particle which is an activated CaM. 
%   There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) and (
             (#macro(ApproachingActivatedCaMFromEAtE) and #macro(FromEWinsAtEOverW) and 
              #macro(CellToNIsNotApproachingAtE) and #macro(CellToSIsNotApproachingAtE) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtE)) or
             (#macro(ApproachingActivatedCaMFromNAtE) and #macro(FromNWinsAtEOverW) and 
              #macro(CellToEIsNotApproachingAtE) and #macro(CellToSIsNotApproachingAtE) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtE)) or
             (#macro(ApproachingActivatedCaMFromSAtE) and #macro(FromSWinsAtEOverW) and 
              #macro(CellToEIsNotApproachingAtE) and #macro(CellToNIsNotApproachingAtE) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtE))) }
%
%   Cell is a CaMKII from south. Cell to north is Fluid. Cell loses at north to three particles at least one of which is an activated CaM. 
%   Activated CaM moves into Fluid at north. There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) and (
             (#macro(ApproachingActivatedCaMFromEAtN) and #macro(FromEWinsAtNOverNWS) and (
                (#macro(ApproachingCaMKIIFromNAtN) and #macro(ApproachingCaMKIIFromWAtN) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverNWAtN)) or
                (#macro(ApproachingCaMKIIFromNAtN) and #macro(ApproachingNonCaMKIIFromWAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverNAtN)) or
                (#macro(ApproachingNonCaMKIIFromNAtN) and #macro(ApproachingCaMKIIFromWAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverWAtN)) or
                (#macro(ApproachingNonCaMKIIFromNAtN) and #macro(ApproachingNonCaMKIIFromWAtN) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtN)))) or
             (#macro(ApproachingActivatedCaMFromNAtN) and #macro(FromNWinsAtNOverEWS) and (
                (#macro(ApproachingCaMKIIFromEAtN) and #macro(ApproachingCaMKIIFromWAtN) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverEWAtN)) or
                (#macro(ApproachingCaMKIIFromEAtN) and #macro(ApproachingNonCaMKIIFromWAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverEAtN)) or
                (#macro(ApproachingNonCaMKIIFromEAtN) and #macro(ApproachingCaMKIIFromWAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverWAtN)) or
                (#macro(ApproachingNonCaMKIIFromEAtN) and #macro(ApproachingNonCaMKIIFromWAtN) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtN)))) or 
             (#macro(ApproachingActivatedCaMFromWAtN) and #macro(FromWWinsAtNOverENS) and (
                (#macro(ApproachingCaMKIIFromEAtN) and #macro(ApproachingCaMKIIFromNAtN) and
                 #macro(ActivatedCaMBindsToOneOfThreeCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverENAtN)) or
                (#macro(ApproachingCaMKIIFromEAtN) and #macro(ApproachingNonCaMKIIFromNAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverEAtN)) or
                (#macro(ApproachingNonCaMKIIFromEAtN) and #macro(ApproachingCaMKIIFromNAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverNAtN)) or
                (#macro(ApproachingNonCaMKIIFromEAtN) and #macro(ApproachingNonCaMKIIFromNAtN) and
                 #macro(ActivatedCaMBindsToOneOfoneCaMKIIAtN))))) }
%
%   Cell is a CaMKII from south. Cell to north is Fluid. Cell loses at north to two particles at least one of which is an activated CaM. 
%   Activated CaM moves into Fluid at north. There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) and (
             (#macro(ApproachingActivatedCaMFromEAtN) and (
                (#macro(FromEWinsAtNOverNS) and #macro(ApproachingCaMKIIFromNAtN) and #macro(CellToWIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverNAtN)) or
                (#macro(FromEWinsAtNOverNS) and #macro(ApproachingNonCaMKIIFromNAtN) and #macro(CellToWIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtN)) or
                (#macro(FromEWinsAtNOverWS) and #macro(ApproachingCaMKIIFromWAtN) and #macro(CellToNIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverWAtN)) or
                (#macro(FromEWinsAtNOverWS) and #macro(ApproachingNonCaMKIIFromWAtN) and #macro(CellToNIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtN)))) or
             (#macro(ApproachingActivatedCaMFromNAtN) and ( 
                (#macro(FromNWinsAtNOverES) and #macro(ApproachingCaMKIIFromEAtN) and #macro(CellToWIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverEAtN)) or
                (#macro(FromNWinsAtNOverES) and #macro(ApproachingNonCaMKIIFromEAtN) and #macro(CellToWIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtN)) or
                (#macro(FromNWinsAtNOverWS) and #macro(ApproachingCaMKIIFromWAtN) and #macro(CellToEIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverWAtN)) or
                (#macro(FromNWinsAtNOverWS) and #macro(ApproachingNonCaMKIIFromWAtN) and #macro(CellToEIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtN)))) or
             (#macro(ApproachingActivatedCaMFromWAtN) and (
                (#macro(FromWWinsAtNOverES) and #macro(ApproachingCaMKIIFromEAtN) and #macro(CellToNIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverEAtN)) or
                (#macro(FromWWinsAtNOverES) and #macro(ApproachingNonCaMKIIFromEAtN) and #macro(CellToNIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtN)) or
                (#macro(FromWWinsAtNOverNS) and #macro(ApproachingCaMKIIFromNAtN) and #macro(CellToEIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN) and #macro(CaMKIIToSCombinesOverNAtN)) or
                (#macro(FromWWinsAtNOverNS) and #macro(ApproachingNonCaMKIIFromNAtN) and #macro(CellToEIsNotApproachingAtN) and
                 #macro(ActivatedCaMBindsToOneOfTwoCaMKIIsAtN))))) }               
%
%   Cell is a CaMKII from south. Cell to north is Fluid. Cell loses at north to one particle which is an activated CaM. 
%   There is a reaction.
%
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) and (
             (#macro(ApproachingActivatedCaMFromEAtN) and #macro(FromEWinsAtNOverS) and 
              #macro(CellToNIsNotApproachingAtN) and #macro(CellToWIsNotApproachingAtN) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtN)) or
             (#macro(ApproachingActivatedCaMFromNAtN) and #macro(FromNWinsAtNOverS) and 
              #macro(CellToEIsNotApproachingAtN) and #macro(CellToWIsNotApproachingAtN) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtN)) or
             (#macro(ApproachingActivatedCaMFromWAtN) and #macro(FromWWinsAtNOverS) and 
              #macro(CellToEIsNotApproachingAtN) and #macro(CellToNIsNotApproachingAtN) and
              #macro(ActivatedCaMBindsToOneOfOneCaMKIIAtN))) }
%
% Updating of cells that are currently Fluid. These cells do not have Vesicles approaching and are not the sites
% of reactions between activated CaM and CaMKII.
%
%   Cell is Fluid. There are four approaching particles.
%
rule : { 31 + 0.4 } 10 { #macro(CellIsFluid)  
                    and #macro(HighCalciumContent) 
                    and #macro(ApproachingCaMFromE) and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                    and #macro(FromEWinsOverNWS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromE) or #macro(ApproachingActivatedCaMFromE))
                    and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                    and #macro(FromEWinsOverNWS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromE) or #macro(ApproachingActivatedCaMKIIFromE))
                    and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                    and #macro(FromEWinsOverNWS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromE)
                    and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                    and #macro(FromEWinsOverNWS) }
rule : { 32 + 0.4 } 10 { #macro(CellIsFluid) 
                    and #macro(HighCalciumContent)
                    and #macro(ApproachingParticleFromE) and #macro(ApproachingCaMFromN) and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                    and #macro(FromNWinsOverEWS) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromN) or #macro(ApproachingActivatedCaMFromN))
                    and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                    and #macro(FromNWinsOverEWS) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromN) or #macro(ApproachingActivatedCaMKIIFromN)) 
                    and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                    and #macro(FromNWinsOverEWS) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromN) 
                    and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                    and #macro(FromNWinsOverEWS) }
%
rule : { 33 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromW) 
                 and #macro(HighCalciumContent)
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverENS) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromW) or #macro(ApproachingActivatedCaMFromW)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverENS) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromW) or #macro(ApproachingActivatedCaMKIIFromW)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverENS) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromW) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverENS) }
%
rule : { 34 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromS)
                 and #macro(HighCalciumContent)
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW)
                 and #macro(FromSWinsOverENW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromS) or #macro(ApproachingActivatedCaMFromS))
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW)
                 and #macro(FromSWinsOverENW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromS) or #macro(ApproachingActivatedCaMKIIFromS))
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW)
                 and #macro(FromSWinsOverENW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromS) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW)
                 and #macro(FromSWinsOverENW) }
%
%   Cell is Fluid. There are three approaching particles. East is not approaching.
%
rule : { 32 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromN) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverWS) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromN) or #macro(ApproachingActivatedCaMFromN)) 
                 and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverWS) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromN) or #macro(ApproachingActivatedCaMKIIFromN))  
                 and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverWS) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromN)  
                 and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverWS) }
%
rule : { 33 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromW)
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverNS) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromW) or #macro(ApproachingActivatedCaMFromW))
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverNS) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromW) or #macro(ApproachingActivatedCaMKIIFromW))
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverNS) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromW)
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverNS) }
%
rule : { 34 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromS) 
                 and #macro(HighCalciumContent)
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverNW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromS) or #macro(ApproachingActivatedCaMFromS)) 
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverNW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromS) or #macro(ApproachingActivatedCaMKIIFromS)) 
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverNW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromS)  
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverNW) }
%
%   Cell is Fluid. There are three approaching particles. North is not approaching.
%
rule : { 31 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromE) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverWS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromE) or #macro(ApproachingActivatedCaMFromE))
                 and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverWS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromE) or #macro(ApproachingActivatedCaMKIIFromE))
                 and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverWS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromE)
                 and #macro(ApproachingParticleFromW) and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverWS) }
%
rule : { 33 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromW)
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverES) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromW) or #macro(ApproachingActivatedCaMFromW)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverES) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromW) or #macro(ApproachingActivatedCaMKIIFromW)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverES) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromW) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverES) }
%
rule : { 34 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromS) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverEW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromS) or #macro(ApproachingActivatedCaMFromS)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverEW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromS) or #macro(ApproachingActivatedCaMKIIFromS)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverEW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromS)  
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverEW) }
%
%   Cell is Fluid. There are three approaching particles. West is not approaching.
%
rule : { 31 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromE) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverNS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromE) or #macro(ApproachingActivatedCaMFromE))
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverNS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromE) or #macro(ApproachingActivatedCaMKIIFromE))
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverNS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromE)
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverNS) }
%
rule : { 32 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromN)
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverES) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromN) or #macro(ApproachingActivatedCaMFromN)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverES) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromN) or #macro(ApproachingActivatedCaMKIIFromN))  
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverES) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromN)  
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverES) }
%
rule : { 34 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromS) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) 
                 and #macro(FromSWinsOverEN) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromS) or #macro(ApproachingActivatedCaMFromS)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) 
                 and #macro(FromSWinsOverEN) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromS) or #macro(ApproachingActivatedCaMKIIFromS)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) 
                 and #macro(FromSWinsOverEN) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromS)  
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) 
                 and #macro(FromSWinsOverEN) }
%
%   Cell is Fluid. There are three approaching particles. South is not approaching.
%
rule : { 31 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromE) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) 
                 and #macro(FromEWinsOverNW) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromE) or #macro(ApproachingActivatedCaMFromE)) 
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) 
                 and #macro(FromEWinsOverNW) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromE) or #macro(ApproachingActivatedCaMKIIFromE)) 
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) 
                 and #macro(FromEWinsOverNW) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromE) 
                 and #macro(ApproachingParticleFromN) and #macro(ApproachingParticleFromW) 
                 and #macro(FromEWinsOverNW) }
%
rule : { 32 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromN) 
                 and #macro(HighCalciumContent)
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromW) 
                 and #macro(FromNWinsOverEW) }
rule : { (-1,0,0)} 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromN) or #macro(ApproachingActivatedCaMFromN)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromW)
                 and #macro(FromNWinsOverEW) }
rule : { (-1,0,0)} 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromN) or #macro(ApproachingActivatedCaMKIIFromN))  
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromW)
                 and #macro(FromNWinsOverEW) }
rule : { (-1,0,0)} 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromN)  
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromW)
                 and #macro(FromNWinsOverEW) }
%
rule : { 33 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromW)
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) 
                 and #macro(FromWWinsOverEN) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromW) or #macro(ApproachingActivatedCaMFromW)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) 
                 and #macro(FromWWinsOverEN) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromW) or #macro(ApproachingActivatedCaMKIIFromW)) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) 
                 and #macro(FromWWinsOverEN) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromW) 
                 and #macro(ApproachingParticleFromE) and #macro(ApproachingParticleFromN) 
                 and #macro(FromWWinsOverEN) }
%
%   Cell is Fluid. There are two approaching particles, from the west and south.
%
rule : { 33 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromW) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverS) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromW)or #macro(ApproachingActivatedCaMFromW)) 
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverS) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromW)or #macro(ApproachingActivatedCaMKIIFromW)) 
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverS) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromW) 
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromWWinsOverS) }
%
rule : { 34 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromS) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromS) or #macro(ApproachingActivatedCaMFromS)) 
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromS) or #macro(ApproachingActivatedCaMKIIFromS)) 
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverW) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromS)  
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromSWinsOverW) }
%
%   Cell is Fluid. There are two approaching particles, from the north and south.
%
rule : { 32 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromN) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverS) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromN) or #macro(ApproachingActivatedCaMFromN)) 
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverS) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromN) or #macro(ApproachingActivatedCaMKIIFromN))  
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverS) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromN)  
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromNWinsOverS) }
%
rule : { 34 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromS) and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromN) 
                 and #macro(FromSWinsOverN) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromS) or #macro(ApproachingActivatedCaMFromS)) 
                 and #macro(ApproachingParticleFromN) 
                 and #macro(FromSWinsOverN) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromS) or #macro(ApproachingActivatedCaMKIIFromS)) 
                 and #macro(ApproachingParticleFromN) 
                 and #macro(FromSWinsOverN) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromS)  
                 and #macro(ApproachingParticleFromN) 
                 and #macro(FromSWinsOverN) }
%
%   Cell is Fluid. There are two approaching particles, from the north and west.
%
rule : { 32 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromN) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromNWinsOverW) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromN) or #macro(ApproachingActivatedCaMFromN)) 
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromNWinsOverW) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromN) or #macro(ApproachingActivatedCaMKIIFromN))  
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromNWinsOverW) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromN)  
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromNWinsOverW) }
%
rule : { 33 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromW) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromN) 
                 and #macro(FromWWinsOverN) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromW) or #macro(ApproachingActivatedCaMFromW)) 
                 and #macro(ApproachingParticleFromN)
                 and #macro(FromWWinsOverN) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromW) or #macro(ApproachingActivatedCaMKIIFromW)) 
                 and #macro(ApproachingParticleFromN)
                 and #macro(FromWWinsOverN) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromW) 
                 and #macro(ApproachingParticleFromN)
                 and #macro(FromWWinsOverN) }
%
%   Cell is Fluid. There are two approaching particles, from the east and south.
%
rule : { 31 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromE) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromE) or #macro(ApproachingActivatedCaMFromE)) 
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromE) or #macro(ApproachingActivatedCaMKIIFromE)) 
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverS) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromE) 
                 and #macro(ApproachingParticleFromS) 
                 and #macro(FromEWinsOverS) }
%
rule : { 34 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromS) 
                 and #macro(HighCalciumContent)
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromSWinsOverE) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromS) or #macro(ApproachingActivatedCaMFromS)) 
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromSWinsOverE) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromS) or #macro(ApproachingActivatedCaMKIIFromS)) 
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromSWinsOverE) }
rule : { (1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromS)  
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromSWinsOverE) }
%
%   Cell is Fluid. There are two approaching particles, from the east and west.
%
rule : { 31 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromE) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromEWinsOverW) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromE) or #macro(ApproachingActivatedCaMFromE)) 
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromEWinsOverW) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromE) or #macro(ApproachingActivatedCaMKIIFromE)) 
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromEWinsOverW) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromE) 
                 and #macro(ApproachingParticleFromW) 
                 and #macro(FromEWinsOverW) }
%
rule : { 33 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromW)
                 and #macro(HighCalciumContent)
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromWWinsOverE) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromW) or #macro(ApproachingActivatedCaMFromW)) 
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromWWinsOverE) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromW) or #macro(ApproachingActivatedCaMKIIFromW)) 
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromWWinsOverE) }
rule : { (0,-1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromW) 
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromWWinsOverE) }
%
%   Cell is Fluid. There are two approaching particles, from the east and north.
%
rule : { 31 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromE) 
                 and #macro(HighCalciumContent) 
                 and #macro(ApproachingParticleFromN) 
                 and #macro(FromEWinsOverN) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromE) or #macro(ApproachingActivatedCaMFromE)) 
                 and #macro(ApproachingParticleFromN) 
                 and #macro(FromEWinsOverN) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromE) or #macro(ApproachingActivatedCaMKIIFromE)) 
                 and #macro(ApproachingParticleFromN) 
                 and #macro(FromEWinsOverN) }
rule : { (0,1,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromE) 
                 and #macro(ApproachingParticleFromN) 
                 and #macro(FromEWinsOverN) }
%
rule : { 32 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromN) 
                 and #macro(HighCalciumContent)
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromNWinsOverE) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMFromN) or #macro(ApproachingActivatedCaMFromN)) 
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromNWinsOverE) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and (#macro(ApproachingCaMKIIFromN) or #macro(ApproachingActivatedCaMKIIFromN))  
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromNWinsOverE) }
rule : { (-1,0,0) } 10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromN)  
                 and #macro(ApproachingParticleFromE) 
                 and #macro(FromNWinsOverE) }
%
%   Cell is Fluid. There is one approaching particle from the east.
%
rule : { 31 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromE) and #macro(HighCalciumContent) }
rule : { 31 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromE) }
rule : 11       10 { #macro(CellIsFluid) and #macro(ApproachingVesicleFromE) }
rule : 21       10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromE) }
rule : 31       10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromE) }
rule : 41       10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromE) }
rule : { 41 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMKIIFromE) }
%
%   Cell is Fluid. There is one approaching particle from the north.
%
rule : { 32 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromN) and #macro(HighCalciumContent) }
rule : { 32 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromN) }
rule : 12       10 { #macro(CellIsFluid) and #macro(ApproachingVesicleFromN) }
rule : 22       10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromN) }
rule : 32       10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromN) }
rule : 42       10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromN)  }
rule : {42 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMKIIFromN)  }
%
%   Cell is Fluid. There is one approaching particle from the west.
%
rule : { 33 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromW) and #macro(HighCalciumContent) }
rule : { 33 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromW) }
rule : 13       10 { #macro(CellIsFluid) and #macro(ApproachingVesicleFromW) }
rule : 23       10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromW) }
rule : 33       10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromW) }
rule : 43       10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromW)  }
rule : {43 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMKIIFromW)  }
%
%   Cell is Fluid. There is one approaching particle from the south.
%
rule : { 34 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromS) and #macro(HighCalciumContent) }
rule : { 34 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMFromS) }
rule : 24       10 { #macro(CellIsFluid) and #macro(ApproachingSynapsinFromS) }
rule : 34       10 { #macro(CellIsFluid) and #macro(ApproachingCaMFromS) }
rule : 44       10 { #macro(CellIsFluid) and #macro(ApproachingCaMKIIFromS)  }
rule : {44 + 0.4 } 10 { #macro(CellIsFluid) and #macro(ApproachingActivatedCaMKIIFromS)  }
%
%   Cell is Fluid. There are no approaching particles.
%
rule : 0 10 { #macro(CellIsFluid) }
%
% Rules for when cell is a CaM or activated CaM and there is no reaction. 
%
%   Cell is a CaM or activated CaM from east. Cell to west is Fluid. There are three other approaching particles to the Fluid.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
          and #macro(FromEWinsAtWOverNWS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                               and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
                               and #macro(HighCalciumContent) 
                               and #macro(FromELosesAtWToNWS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid) 
                               and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS)
                               and #macro(FromELosesAtWToNWS) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) }
%
%   Cell is a CaM or activated CaM from east. Cell to west is Fluid. There are two other approaching particles to the Fluid, from the west and south.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                           and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
                           and #macro(FromEWinsAtWOverWS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid)
                          and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
                          and #macro(HighCalciumContent)
                          and #macro(FromELosesAtWToWS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
                          and #macro(FromELosesAtWToWS) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) }
%
%   Cell is a CaM or activated CaM from east. Cell to west is Fluid. There are two other approaching particles to the Fluid, from the north and south.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                           and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromS) 
                           and #macro(FromEWinsAtWOverNS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromS) 
                          and #macro(HighCalciumContent)
                          and #macro(FromELosesAtWToNS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromS) 
                          and #macro(FromELosesAtWToNS) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromS) }
%
%   Cell is a CaM or activated CaM from east. Cell to west is Fluid. There are two other approaching particles to the Fluid, from the north and west.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                           and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) 
                           and #macro(FromEWinsAtWOverNW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) 
                          and #macro(HighCalciumContent)
                          and #macro(FromELosesAtWToNW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid)
                          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) 
                          and #macro(FromELosesAtWToNW) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) }
%
%   Cell is a CaM or activated CaM from east. Cell to west is Fluid. There is one other approaching particle to the Fluid, from the north.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid)
                           and #macro(ParticleApproachingAtWFromN) 
                           and #macro(FromEWinsAtWOverN) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) 
                          and #macro(HighCalciumContent)
                          and #macro(FromELosesAtWToN) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) 
                          and #macro(FromELosesAtWToN) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) }
%
%   Cell is a CaM or activated CaM from east. Cell to west is Fluid. There is one other approaching particle to the Fluid, from the west.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid)
                           and #macro(ParticleApproachingAtWFromW) 
                           and #macro(FromEWinsAtWOverW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromW) 
                          and #macro(HighCalciumContent)
                          and #macro(FromELosesAtWToW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromW) 
                          and #macro(FromELosesAtWToW) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromW) }
%
%   Cell is a CaM or activated CaM from east. Cell to west is Fluid. There is one other approaching particle to the Fluid, from the south.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                           and #macro(ParticleApproachingAtWFromS) 
                           and #macro(FromEWinsAtWOverS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromS) 
                          and #macro(HighCalciumContent)
                          and #macro(FromELosesAtWToS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromS) 
                          and #macro(FromELosesAtWToS) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromS) }
%
%   Cell is a CaM or activated CaM from east. Cell to west is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) }
rule : 0 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsFluid) }
%
%   Cell is a CaM or activated CaM from north. Cell to south is Fluid. There are three other approaching particles to the Fluid.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                           and #macro(FromNWinsAtSOverEWS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                          and #macro(HighCalciumContent)
                          and #macro(FromNLosesAtSToEWS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                          and #macro(FromNLosesAtSToEWS) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) }
%
%   Cell is a CaM or activated CaM from north. Cell to south is Fluid. There are two other approaching particles to the Fluid, from the west and south.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                           and #macro(FromNWinsAtSOverWS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                          and #macro(HighCalciumContent)
                          and #macro(FromNLosesAtSToWS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                          and #macro(FromNLosesAtSToWS) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) }
%
%   Cell is a CaM or activated CaM from north. Cell to south is Fluid. There are two other approaching particles to the Fluid, from the east and south.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromS) 
                           and #macro(FromNWinsAtSOverES) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromS) 
                          and #macro(HighCalciumContent)
                          and #macro(FromNLosesAtSToES) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromS) 
                          and #macro(FromNLosesAtSToES) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromS) }
%
%   Cell is a CaM or activated CaM from north. Cell to south is Fluid. There are two other approaching particles to the Fluid, from the east and west.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) 
                           and #macro(FromNWinsAtSOverEW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) 
                          and #macro(HighCalciumContent)
                          and #macro(FromNLosesAtSToEW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) 
                          and #macro(FromNLosesAtSToEW) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) }
%
%   Cell is a CaM or activated CaM from north. Cell to south is Fluid. There is one other approaching particle to the Fluid, from the east.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromE) 
                           and #macro(FromNWinsAtSOverE) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) 
                          and #macro(HighCalciumContent)
                          and #macro(FromNLosesAtSToE) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) 
                          and #macro(FromNLosesAtSToE) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) }
%
%   Cell is a CaM or activated CaM from north. Cell to south is Fluid. There is one other approaching particle to the Fluid, from the west.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromW) 
                           and #macro(FromNWinsAtSOverW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromW) 
                          and #macro(HighCalciumContent)                           
                          and #macro(FromNLosesAtSToW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromW) 
                          and #macro(FromNLosesAtSToW) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromW) }
%
%   Cell is a CaM or activated CaM from north. Cell to south is Fluid. There is one other approaching particle to the Fluid, from the south.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromS) 
                           and #macro(FromNWinsAtSOverS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromS) 
                          and #macro(HighCalciumContent)
                          and #macro(FromNLosesAtSToS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromS) 
                          and #macro(FromNLosesAtSToS) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromS) }
%
%   Cell is a CaM or activated CaM from north. Cell to south is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) }
rule : 0 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsFluid) }
%
%   Cell is a CaM or activated CaM from west. Cell to east is Fluid. There are three other approaching particles to the Fluid.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                           and #macro(FromWWinsAtEOverENS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                          and #macro(HighCalciumContent)                            
                          and #macro(FromWLosesAtEToENS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                          and #macro(FromWLosesAtEToENS) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) }
%
%   Cell is a CaM or activated CaM from west. Cell to east is Fluid. There are two other approaching particles to the Fluid, from the north and south.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                           and #macro(FromWWinsAtEOverNS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                          and #macro(HighCalciumContent) 
                          and #macro(FromWLosesAtEToNS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                          and #macro(FromWLosesAtEToNS) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) }
%
%   Cell is a CaM or activated CaM from west. Cell to east is Fluid. There are two other approaching particles to the Fluid, from the east and south.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromS) 
                           and #macro(FromWWinsAtEOverES) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromS) 
                          and #macro(HighCalciumContent) 
                          and #macro(FromWLosesAtEToES) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromS) 
                          and #macro(FromWLosesAtEToES) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromS) }
%
%   Cell is a CaM or activated CaM from west. Cell to east is Fluid. There are two other approaching particles to the Fluid, from the east and north.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) 
                           and #macro(FromWWinsAtEOverEN) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) 
                          and #macro(HighCalciumContent)                            
                          and #macro(FromWLosesAtEToEN) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) 
                          and #macro(FromWLosesAtEToEN) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) }
%
%   Cell is a CaM or activated CaM from west. Cell to east is Fluid. There is one other approaching particle to the Fluid, from the east.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromE) 
                           and #macro(FromWWinsAtEOverE) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromE) 
                          and #macro(HighCalciumContent)
                          and #macro(FromWLosesAtEToE) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromE) 
                          and #macro(FromWLosesAtEToE) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) }
%
%   Cell is a CaM or activated CaM from west. Cell to east is Fluid. There is one other approaching particle to the Fluid, from the north.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromN) 
                           and #macro(FromWWinsAtEOverN) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromN) 
                          and #macro(HighCalciumContent)
                          and #macro(FromWLosesAtEToN) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromN) 
                          and #macro(FromWLosesAtEToN) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromN) }
%
%   Cell is a CaM or activated CaM from west. Cell to east is Fluid. There is one other approaching particle to the Fluid, from the south.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromS) 
                           and #macro(FromWWinsAtEOverS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromS) 
                          and #macro(HighCalciumContent)                      
                          and #macro(FromWLosesAtEToS) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) 
                          and #macro(ParticleApproachingAtEFromS) 
                          and #macro(FromWLosesAtEToS) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromS) }
%
%   Cell is a CaM or activated CaM from west. Cell to east is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsFluid) }
rule : 0 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsFluid) }
%
%   Cell is a CaM or activated CaM from south. Cell to north is Fluid. There are three other approaching particles to the Fluid.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                           and #macro(FromSWinsAtNOverENW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                          and #macro(HighCalciumContent)
                          and #macro(FromSLosesAtNToENW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                          and #macro(FromSLosesAtNToENW) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) }
%
%   Cell is a CaM or activated CaM from south. Cell to north is Fluid. There are two other approaching particles to the Fluid, from the north and west.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                           and #macro(FromSWinsAtNOverNW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                          and #macro(HighCalciumContent)
                          and #macro(FromSLosesAtNToNW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                          and #macro(FromSLosesAtNToNW) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) }
%
%   Cell is a CaM or activated CaM from south. Cell to north is Fluid. There are two other approaching particles to the Fluid, from the east and west.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromW) 
                           and #macro(FromSWinsAtNOverEW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromW) 
                          and #macro(HighCalciumContent) 
                          and #macro(FromSLosesAtNToEW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromW) 
                          and #macro(FromSLosesAtNToEW) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromW) }
%
%   Cell is a CaM or activated CaM from south. Cell to north is Fluid. There are two other approaching particles to the Fluid, from the east and north.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) 
                           and #macro(FromSWinsAtNOverEN) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) 
                          and #macro(HighCalciumContent)
                          and #macro(FromSLosesAtNToEN) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) 
                          and #macro(FromSLosesAtNToEN) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) }
%
%   Cell is a CaM or activated CaM from south. Cell to north is Fluid. There is one other approaching particle to the Fluid, from the east.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromE) 
                           and #macro(FromSWinsAtNOverE) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) 
                          and #macro(HighCalciumContent) 
                          and #macro(FromSLosesAtNToE) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) 
                          and #macro(FromSLosesAtNToE) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) }
%
%   Cell is a CaM or activated CaM from south. Cell to north is Fluid. There is one other approaching particle to the Fluid, from the north.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromN) 
                           and #macro(FromSWinsAtNOverN) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromN) 
                          and #macro(HighCalciumContent)
                          and #macro(FromSLosesAtNToN) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromN) 
                          and #macro(FromSLosesAtNToN) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromN) }
%
%   Cell is a CaM or activated CaM from south. Cell to north is Fluid. There is one other approaching particle to the Fluid, from the west.
%   There is no reaction.
%
rule : 0 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromW) 
                           and #macro(FromSWinsAtNOverW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromW) 
                          and #macro(HighCalciumContent)
                          and #macro(FromSLosesAtNToW) }
rule : { 31 + randInt(3)+ 0.4 } 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromW) 
                          and #macro(FromSLosesAtNToW) }
rule : { 31 + randInt(3) } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromW) }
%
%   Cell is a CaM or activated CaM from south. Cell to north is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) }
rule : 0 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsFluid) }
%
% Rules for when cell is a CaM or activated CaM and there is a particle 'in front' not including Vesicles.
%
%   Cell is a CaM or activated CaM from east. There is a particle 'in front'.
%
rule : 91 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsFluid) }
rule : { 33 + 0.4 } 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsWall) and #macro(HighCalciumContent) and random < 0.8 }
rule : 33 10 { #macro(CellIsCaMFromE) and #macro(CellToWIsWall) and random < 0.8 }
rule : { randInt(3) + 31 + 0.4 } 10 { #macro(CellIsCaMFromE) and #macro(HighCalciumContent) }
rule : { 33 + 0.4 } 10 { #macro(CellIsActivatedCaMFromE) and #macro(CellToWIsWall) and random < 0.8 }
rule : { randInt(3) + 31 + 0.4 } 10 { #macro(CellIsActivatedCaMFromE) }
rule : { randInt(3) + 31 } 10 { #macro(CellIsCaMFromE) }
%
%   Cell is a CaM or activated CaM from north. There is a particle 'in front'.
%
rule : 92 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsFluid) }
rule : { 34 + 0.4 } 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsWall) and #macro(HighCalciumContent) and random < 0.8 }
rule : 34 10 { #macro(CellIsCaMFromN) and #macro(CellToSIsWall) and random < 0.8 }
rule : { randInt(3) + 31 + 0.4 } 10 { #macro(CellIsCaMFromN) and #macro(HighCalciumContent) }
rule : { 34 + 0.4 } 10 { #macro(CellIsActivatedCaMFromN) and #macro(CellToSIsWall) and random < 0.8 }
rule : { randInt(3) + 31 + 0.4 } 10 { #macro(CellIsActivatedCaMFromN) }
rule : { randInt(3) + 31 } 10 { #macro(CellIsCaMFromN) }
%
%   Cell is a CaM or activated CaM from west. There is a particle 'in front'.
%
rule : 93 10 { #macro(CellIsCaMFromW)and #macro(CellToEIsFluid) }
rule : { 31 + 0.4 } 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsWall) and #macro(HighCalciumContent) and random < 0.8 }
rule : 31 10 { #macro(CellIsCaMFromW) and #macro(CellToEIsWall) and random < 0.8 }
rule : { randInt(3) + 31 + 0.4 } 10 { #macro(CellIsCaMFromW) and #macro(HighCalciumContent) }
rule : { 31 + 0.4 } 10 { #macro(CellIsActivatedCaMFromW) and #macro(CellToEIsWall) and random < 0.8 }
rule : { randInt(3) + 31 + 0.4 } 10 { #macro(CellIsActivatedCaMFromW) }
rule : { randInt(3) + 31 } 10 { #macro(CellIsCaMFromW) }
%
%   Cell is a CaM or activated CaM from south. There is a particle 'in front'.
%
rule : 94 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsFluid) }
rule : { 32 + 0.4 } 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsWall) and #macro(HighCalciumContent) and random < 0.8 }
rule : 32 10 { #macro(CellIsCaMFromS) and #macro(CellToNIsWall) and random < 0.8 }
rule : { randInt(3) + 31 + 0.4 } 10 { #macro(CellIsCaMFromS) and #macro(HighCalciumContent) }
rule : { 32 + 0.4 } 10 { #macro(CellIsActivatedCaMFromS) and #macro(CellToNIsWall) and random < 0.8 }
rule : { randInt(3) + 31 + 0.4 } 10 { #macro(CellIsActivatedCaMFromS) }
rule : { randInt(3) + 31 } 10 { #macro(CellIsCaMFromS) }
%
% Rules for when cell is a CaMKII or activated CaMKII and there is no reaction. 
%
%   Cell is a CaMKII or activated CaMKII from east. Cell to west is Fluid. There are three other approaching particles to the Fluid.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromE) or #macro(CellIsActivatedCaMKIIFromE))  and #macro(CellToWIsFluid) 
          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS)
          and #macro(FromEWinsAtWOverNWS) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
                            and #macro(FromELosesAtWToNWS) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
                            and #macro(FromELosesAtWToNWS) }
%
%   Cell is a CaMKII or activated CaMKII from east. Cell to west is Fluid. There are two other approaching particles to the Fluid, from the west and south.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromE) or #macro(CellIsActivatedCaMKIIFromE)) and #macro(CellToWIsFluid) 
          and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
          and #macro(FromEWinsAtWOverWS) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
                            and #macro(FromELosesAtWToWS) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
                            and #macro(FromELosesAtWToWS) }
%
%   Cell is a CaMKII or activated CaMKII from east. Cell to west is Fluid. There are two other approaching particles to the Fluid, from the north and south.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromE) or #macro(CellIsActivatedCaMKIIFromE)) and #macro(CellToWIsFluid) 
          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromS) 
          and #macro(FromEWinsAtWOverNS) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromS) 
                            and #macro(FromELosesAtWToNS) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromS) 
                            and #macro(FromELosesAtWToNS) }
%
%   Cell is a CaMKII or activated CaMKII from east. Cell to west is Fluid. There are two other approaching particles to the Fluid, from the north and west.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromE) or #macro(CellIsActivatedCaMKIIFromE)) and #macro(CellToWIsFluid) 
          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) 
          and #macro(FromEWinsAtWOverNW) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) 
                            and #macro(FromELosesAtWToNW) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) 
                            and #macro(FromELosesAtWToNW) }
%
%   Cell is a CaMKII or activated CaMKII from east. Cell to west is Fluid. There is one other approaching particle to the Fluid, from the north.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromE) or #macro(CellIsActivatedCaMKIIFromE)) and #macro(CellToWIsFluid) 
          and #macro(ParticleApproachingAtWFromN) 
          and #macro(FromEWinsAtWOverN) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromN) 
                            and #macro(FromELosesAtWToN) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromN) 
                            and #macro(FromELosesAtWToN) }
%
%   Cell is a CaMKII or activated CaMKII from east. Cell to west is Fluid. There is one other approaching particle to the Fluid, from the west.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromE) or #macro(CellIsActivatedCaMKIIFromE)) and #macro(CellToWIsFluid) 
          and #macro(ParticleApproachingAtWFromW) 
          and #macro(FromEWinsAtWOverW) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromW) 
                            and #macro(FromELosesAtWToW) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromW) 
                            and #macro(FromELosesAtWToW) }
%
%   Cell is a CaMKII or activated CaMKII from east. Cell to west is Fluid. There is one other approaching particle to the Fluid, from the south.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromE) or #macro(CellIsActivatedCaMKIIFromE)) and #macro(CellToWIsFluid) 
          and #macro(ParticleApproachingAtWFromS) 
          and #macro(FromEWinsAtWOverS) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromS) 
                            and #macro(FromELosesAtWToS) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromE) and #macro(CellToWIsFluid) 
                            and #macro(ParticleApproachingAtWFromS) 
                            and #macro(FromELosesAtWToS) }
%
%   Cell is a CaMKII or activated CaMKII from east. Cell to west is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromE) or #macro(CellIsActivatedCaMKIIFromE)) and #macro(CellToWIsFluid) }
%
%   Cell is a CaMKII or activated CaMKII from north. Cell to south is Fluid. There are three other approaching particles to the Fluid.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromN) or #macro(CellIsActivatedCaMKIIFromN)) and #macro(CellToSIsFluid) 
          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
          and #macro(FromNWinsAtSOverEWS) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                            and #macro(FromNLosesAtSToEWS) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                            and #macro(FromNLosesAtSToEWS) }
%
%   Cell is a CaMKII or activated CaMKII from north. Cell to south is Fluid. There are two other approaching particles to the Fluid, from the west and south.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromN) or #macro(CellIsActivatedCaMKIIFromN)) and #macro(CellToSIsFluid) 
          and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
          and #macro(FromNWinsAtSOverWS) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                            and #macro(FromNLosesAtSToWS) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                            and #macro(FromNLosesAtSToWS) }
%
%   Cell is a CaMKII or activated CaMKII from north. Cell to south is Fluid. There are two other approaching particles to the Fluid, from the east and south.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromN) or #macro(CellIsActivatedCaMKIIFromN)) and #macro(CellToSIsFluid) 
          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromS) 
          and #macro(FromNWinsAtSOverES) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromS) 
                            and #macro(FromNLosesAtSToES) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromS) 
                            and #macro(FromNLosesAtSToES) }
%
%   Cell is a CaMKII or activated CaMKII from north. Cell to south is Fluid. There are two other approaching particles to the Fluid, from the east and west.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromN) or #macro(CellIsActivatedCaMKIIFromN)) and #macro(CellToSIsFluid) 
          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) 
          and #macro(FromNWinsAtSOverEW) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) 
                            and #macro(FromNLosesAtSToEW) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) 
                            and #macro(FromNLosesAtSToEW) }
%
%   Cell is a CaMKII or activated CaMKII from north. Cell to south is Fluid. There is one other approaching particle to the Fluid, from the east.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromN) or #macro(CellIsActivatedCaMKIIFromN)) and #macro(CellToSIsFluid) 
          and #macro(ParticleApproachingAtSFromE) 
          and #macro(FromNWinsAtSOverE) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromE) 
                            and #macro(FromNLosesAtSToE) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromE) 
                            and #macro(FromNLosesAtSToE) }
%
%   Cell is a CaMKII or activated CaMKII from north. Cell to south is Fluid. There is one other approaching particle to the Fluid, from the west.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromN) or #macro(CellIsActivatedCaMKIIFromN)) and #macro(CellToSIsFluid) 
          and #macro(ParticleApproachingAtSFromW) 
          and #macro(FromNWinsAtSOverW) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromW) 
                            and #macro(FromNLosesAtSToW) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromW) 
                            and #macro(FromNLosesAtSToW) }
%
%   Cell is a CaMKII or activated CaMKII from north. Cell to south is Fluid. There is one other approaching particle to the Fluid, from the south.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromN) or #macro(CellIsActivatedCaMKIIFromN)) and #macro(CellToSIsFluid) 
          and #macro(ParticleApproachingAtSFromS) 
          and #macro(FromNWinsAtSOverS) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromS) 
                            and #macro(FromNLosesAtSToS) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromN) and #macro(CellToSIsFluid) 
                            and #macro(ParticleApproachingAtSFromS) 
                            and #macro(FromNLosesAtSToS) }
%
%   Cell is a CaMKII or activated CaMKII from north. Cell to south is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromN) or #macro(CellIsActivatedCaMKIIFromN)) and #macro(CellToSIsFluid) }
%
%   Cell is a CaMKII or activated CaMKII from west. Cell to east is Fluid. There are three other approaching particles to the Fluid.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromW) or #macro(CellIsActivatedCaMKIIFromW)) and #macro(CellToEIsFluid) 
          and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
          and #macro(FromWWinsAtEOverENS) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                            and #macro(FromWLosesAtEToENS) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                            and #macro(FromWLosesAtEToENS) }
%
%   Cell is a CaMKII or activated CaMKII from west. Cell to east is Fluid. There are two other approaching particles to the Fluid, from the north and south.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromW) or #macro(CellIsActivatedCaMKIIFromW)) and #macro(CellToEIsFluid) 
          and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
          and #macro(FromWWinsAtEOverNS) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                            and #macro(FromWLosesAtEToNS) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                            and #macro(FromWLosesAtEToNS) }
%
%   Cell is a CaMKII or activated CaMKII from west. Cell to east is Fluid. There are two other approaching particles to the Fluid, from the east and south.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromW) or #macro(CellIsActivatedCaMKIIFromW)) and #macro(CellToEIsFluid) 
          and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromS) 
          and #macro(FromWWinsAtEOverES) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromS) 
                            and #macro(FromWLosesAtEToES) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromS) 
                            and #macro(FromWLosesAtEToES) }
%
%   Cell is a CaMKII or activated CaMKII from west. Cell to east is Fluid. There are two other approaching particles to the Fluid, from the east and north.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromW) or #macro(CellIsActivatedCaMKIIFromW)) and #macro(CellToEIsFluid) 
          and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) 
          and #macro(FromWWinsAtEOverEN) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) 
                            and #macro(FromWLosesAtEToEN) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) 
                            and #macro(FromWLosesAtEToEN) }
%
%   Cell is a CaMKII or activated CaMKII from west. Cell to east is Fluid. There is one other approaching particle to the Fluid, from the east.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromW) or #macro(CellIsActivatedCaMKIIFromW)) and #macro(CellToEIsFluid) 
          and #macro(ParticleApproachingAtEFromE) 
          and #macro(FromWWinsAtEOverE) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) 
                            and #macro(FromWLosesAtEToE) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) 
                            and #macro(FromWLosesAtEToE) }
%
%   Cell is a CaMKII or activated CaMKII from west. Cell to east is Fluid. There is one other approaching particle to the Fluid, from the north.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromW) or #macro(CellIsActivatedCaMKIIFromW)) and #macro(CellToEIsFluid) 
          and #macro(ParticleApproachingAtEFromN) 
          and #macro(FromWWinsAtEOverN) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromN) 
                            and #macro(FromWLosesAtEToN) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromN) 
                            and #macro(FromWLosesAtEToN) }
%
%   Cell is a CaMKII or activated CaMKII from west. Cell to east is Fluid. There is one other approaching particle to the Fluid, from the south.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromW) or #macro(CellIsActivatedCaMKIIFromW)) and #macro(CellToEIsFluid) 
          and #macro(ParticleApproachingAtEFromS) 
          and #macro(FromWWinsAtEOverS) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromS) 
                            and #macro(FromWLosesAtEToS) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromS) 
                            and #macro(FromWLosesAtEToS) }
%
%   Cell is a CaMKII or activated CaMKII from west. Cell to east is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromW) or #macro(CellIsActivatedCaMKIIFromW)) and #macro(CellToEIsFluid) }
%
%   Cell is a CaMKII or activated CaMKII from south. Cell to north is Fluid. There are three other approaching particles to the Fluid.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromS) or #macro(CellIsActivatedCaMKIIFromS)) and #macro(CellToNIsFluid) 
          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
          and #macro(FromSWinsAtNOverENW) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                            and #macro(FromSLosesAtNToENW) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                            and #macro(FromSLosesAtNToENW) }
%
%   Cell is a CaMKII or activated CaMKII from south. Cell to north is Fluid. There are two other approaching particles to the Fluid, from the north and west.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromS) or #macro(CellIsActivatedCaMKIIFromS)) and #macro(CellToNIsFluid) 
          and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
          and #macro(FromSWinsAtNOverNW) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                            and #macro(FromSLosesAtNToNW) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                            and #macro(FromSLosesAtNToNW) }
%
%   Cell is a CaMKII or activated CaMKII from south. Cell to north is Fluid. There are two other approaching particles to the Fluid, from the east and west.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromS) or #macro(CellIsActivatedCaMKIIFromS)) and #macro(CellToNIsFluid) 
          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromW) 
          and #macro(FromSWinsAtNOverEW) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromW) 
                            and #macro(FromSLosesAtNToEW) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromW) 
                            and #macro(FromSLosesAtNToEW) }
%
%   Cell is a CaMKII or activated CaMKII from south. Cell to north is Fluid. There are two other approaching particles to the Fluid, from the east and north.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromS) or #macro(CellIsActivatedCaMKIIFromS)) and #macro(CellToNIsFluid) 
          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) 
          and #macro(FromSWinsAtNOverEN) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) 
                            and #macro(FromSLosesAtNToEN) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) 
                            and #macro(FromSLosesAtNToEN) }
%
%   Cell is a CaMKII or activated CaMKII from south. Cell to north is Fluid. There is one other approaching particle to the Fluid, from the east.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromS) or #macro(CellIsActivatedCaMKIIFromS)) and #macro(CellToNIsFluid) 
          and #macro(ParticleApproachingAtNFromE) 
          and #macro(FromSWinsAtNOverE) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromE) 
                            and #macro(FromSLosesAtNToE) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromE) 
                            and #macro(FromSLosesAtNToE) }
%
%   Cell is a CaMKII or activated CaMKII from south. Cell to north is Fluid. There is one other approaching particle to the Fluid, from the north.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromS) or #macro(CellIsActivatedCaMKIIFromS)) and #macro(CellToNIsFluid) 
          and #macro(ParticleApproachingAtNFromN) 
          and #macro(FromSWinsAtNOverN) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromN) 
                            and #macro(FromSLosesAtNToN) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromN) 
                            and #macro(FromSLosesAtNToN) }
%
%   Cell is a CaMKII or activated CaMKII from south. Cell to north is Fluid. There is one other approaching particle to the Fluid, from the west.
%   There is no reaction.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromS) or #macro(CellIsActivatedCaMKIIFromS)) and #macro(CellToNIsFluid) 
          and #macro(ParticleApproachingAtNFromW) 
          and #macro(FromSWinsAtNOverW) }
rule : { 41 + randInt(3) } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromW) 
                            and #macro(FromSLosesAtNToW) }
rule : { 41 + randInt(3) + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromS) and #macro(CellToNIsFluid) 
                            and #macro(ParticleApproachingAtNFromW) 
                            and #macro(FromSLosesAtNToW) }
%
%   Cell is a CaMKII or activated CaMKII from south. Cell to north is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { (#macro(CellIsCaMKIIFromS) or #macro(CellIsActivatedCaMKIIFromS)) and #macro(CellToNIsFluid) }
%
%   Cell is a CaMKII or activated CaMKII from east. There is a particle 'in front'.
%
rule : 95 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsFluid) }
rule : 43 10 { #macro(CellIsCaMKIIFromE) and #macro(CellToWIsWall) and random < 0.8 }
rule : { randInt(3) + 41 } 10 { #macro(CellIsCaMKIIFromE) }
rule : { 43 + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromE) and #macro(CellToWIsWall) and random < 0.8 }
rule : { randInt(3) + 41 + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromE) }
%
%   Cell is a CaMKII or activated CaMKII from north. There is a particle 'in front'.
%
rule : 96 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsFluid) }
rule : 44 10 { #macro(CellIsCaMKIIFromN) and #macro(CellToSIsWall) and random < 0.8 }
rule : { randInt(3) + 41 } 10 { #macro(CellIsCaMKIIFromN) }
rule : { 44 + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromN) and #macro(CellToSIsWall) and random < 0.8 }
rule : { randInt(3) + 41 + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromN) }
%
%   Cell is a CaMKII or activated CaMKII from west. There is a particle 'in front'.
%
rule : 97 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsFluid) }
rule : 41 10 { #macro(CellIsCaMKIIFromW) and #macro(CellToEIsWall) and random < 0.8 }
rule : { randInt(3) + 41 } 10 { #macro(CellIsCaMKIIFromW) }
rule : { 41 + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromW) and #macro(CellToEIsWall) and random < 0.8 }
rule : { randInt(3) + 41 + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromW) }
%
%   Cell is a CaMKII or activated CaMKII from south. There is a particle 'in front'.
%
rule : 98 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsFluid) }
rule : 42 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsWall) and random < 0.8 }
rule : { randInt(3) + 41 } 10 { #macro(CellIsCaMKIIFromS) and #macro(CellToNIsNotFluid) }
rule : { 42 + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromS) and #macro(CellToNIsWall) and random < 0.8 }
rule : { randInt(3) + 41 + 0.4 } 10 { #macro(CellIsActivatedCaMKIIFromS) }
%
% Rules for Synapsin. It is already phosphorylated.
%
%   Cell is a Synapsin from east. Cell to west is Fluid. There are three other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
          and #macro(FromEWinsAtWOverNWS) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) }
%
%   Cell is a Synapsin from east. Cell to west is Fluid. There are two other approaching particles to the Fluid, from the west and south.
%
rule : 0 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
                           and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) 
                           and #macro(FromEWinsAtWOverWS) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromW) and #macro(ParticleApproachingAtWFromS) }
%
%   Cell is a Synapsin from east. Cell to west is Fluid. There are two other approaching particles to the Fluid, from the north and south.
%
rule : 0 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
                           and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromS) 
                           and #macro(FromEWinsAtWOverNS) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromS) }
%
%   Cell is a Synapsin from east. Cell to west is Fluid. There are two other approaching particles to the Fluid, from the north and west.
%
rule : 0 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
                           and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) 
                           and #macro(FromEWinsAtWOverNW) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) and #macro(ParticleApproachingAtWFromW) }
%
%   Cell is a Synapsin from east. Cell to west is Fluid. There is one other approaching particle to the Fluid, from the north.
%
rule : 0 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid)
                           and #macro(ParticleApproachingAtWFromN) 
                           and #macro(FromEWinsAtWOverN) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromN) }
%
%   Cell is a Synapsin from east. Cell to west is Fluid. There is one other approaching particle to the Fluid, from the west.
%
rule : 0 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid)
                           and #macro(ParticleApproachingAtWFromW) 
                           and #macro(FromEWinsAtWOverW) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromW) }
%
%   Cell is a Synapsin from east. Cell to west is Fluid. There is one other approaching particle to the Fluid, from the south.
%
rule : 0 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
                           and #macro(ParticleApproachingAtWFromS) 
                           and #macro(FromEWinsAtWOverS) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) 
                          and #macro(ParticleApproachingAtWFromS) }
%
%   Cell is a Synapsin from east. Cell to west is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsFluid) }
%
%   Cell is a Synapsin from north. Cell to south is Fluid. There are three other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                           and #macro(FromNWinsAtSOverEWS) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) }
%
%   Cell is a Synapsin from north. Cell to south is Fluid. There are two other approaching particles to the Fluid, from the west and south.
%
rule : 0 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) 
                           and #macro(FromNWinsAtSOverWS) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromW) and #macro(ParticleApproachingAtSFromS) }
%
%   Cell is a Synapsin from north. Cell to south is Fluid. There are two other approaching particles to the Fluid, from the east and south.
%
rule : 0 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromS) 
                           and #macro(FromNWinsAtSOverES) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromS) }
%
%   Cell is a Synapsin from north. Cell to south is Fluid. There are two other approaching particles to the Fluid, from the east and west.
%
rule : 0 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) 
                           and #macro(FromNWinsAtSOverEW) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) and #macro(ParticleApproachingAtSFromW) }
%
%   Cell is a Synapsin from north. Cell to south is Fluid. There is one other approaching particle to the Fluid, from the east.
%
rule : 0 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromE) 
                           and #macro(FromNWinsAtSOverE) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromE) }
%
%   Cell is a Synapsin from north. Cell to south is Fluid. There is one other approaching particle to the Fluid, from the west.
%
rule : 0 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromW) 
                           and #macro(FromNWinsAtSOverW) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromW) }
%
%   Cell is a Synapsin from north. Cell to south is Fluid. There is one other approaching particle to the Fluid, from the south.
%
rule : 0 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                           and #macro(ParticleApproachingAtSFromS) 
                           and #macro(FromNWinsAtSOverS) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) 
                          and #macro(ParticleApproachingAtSFromS) }
%
%   Cell is a Synapsin from north. Cell to south is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsFluid) }
%
%   Cell is a Synapsin from west. Cell to east is Fluid. There are three other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                           and #macro(FromWWinsAtEOverENS) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) }
%
%   Cell is a Synapsin from west. Cell to east is Fluid. There are two other approaching particles to the Fluid, from the north and south.
%
rule : 0 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) 
                           and #macro(FromWWinsAtEOverNS) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromN) and #macro(ParticleApproachingAtEFromS) }
%
%   Cell is a Synapsin from west. Cell to east is Fluid. There are two other approaching particles to the Fluid, from the east and south.
%
rule : 0 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromS) 
                           and #macro(FromWWinsAtEOverES) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromS) }
%
%   Cell is a Synapsin from west. Cell to east is Fluid. There are two other approaching particles to the Fluid, from the east and north.
%
rule : 0 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) 
                           and #macro(FromWWinsAtEOverEN) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) and #macro(ParticleApproachingAtEFromN) }
%
%   Cell is a Synapsin from west. Cell to east is Fluid. There is one other approaching particle to the Fluid, from the east.
%
rule : 0 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromE) 
                           and #macro(FromWWinsAtEOverE) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                            and #macro(ParticleApproachingAtEFromE) }
%
%   Cell is a Synapsin from west. Cell to east is Fluid. There is one other approaching particle to the Fluid, from the north.
%
rule : 0 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromN) 
                           and #macro(FromWWinsAtEOverN) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromN) }
%
%   Cell is a Synapsin from west. Cell to east is Fluid. There is one other approaching particle to the Fluid, from the south.
%
rule : 0 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromS) 
                           and #macro(FromWWinsAtEOverS) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) 
                           and #macro(ParticleApproachingAtEFromS) }
%
%   Cell is a Synapsin from west. Cell to east is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsFluid) }
%
%   Cell is a Synapsin from south. Cell to north is Fluid. There are three other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                           and #macro(FromSWinsAtNOverENW) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) }
%
%   Cell is a Synapsin from south. Cell to north is Fluid. There are two other approaching particles to the Fluid, from the north and west.
%
rule : 0 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) 
                           and #macro(FromSWinsAtNOverNW) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromN) and #macro(ParticleApproachingAtNFromW) }
%
%   Cell is a Synapsin from south. Cell to north is Fluid. There are two other approaching particles to the Fluid, from the east and west.
%
rule : 0 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromW) 
                           and #macro(FromSWinsAtNOverEW) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromW) }
%
%   Cell is a Synapsin from south. Cell to north is Fluid. There are two other approaching particles to the Fluid, from the east and north.
%
rule : 0 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) 
                           and #macro(FromSWinsAtNOverEN) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) and #macro(ParticleApproachingAtNFromN) }
%
%   Cell is a Synapsin from south. Cell to north is Fluid. There is one other approaching particle to the Fluid, from the east.
%
rule : 0 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromE) 
                           and #macro(FromSWinsAtNOverE) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromE) }
%
%   Cell is a Synapsin from south. Cell to north is Fluid. There is one other approaching particle to the Fluid, from the north.
%
rule : 0 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromN) 
                           and #macro(FromSWinsAtNOverN) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromN) }
%
%   Cell is a Synapsin from south. Cell to north is Fluid. There is one other approaching particle to the Fluid, from the west.
%
rule : 0 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                           and #macro(ParticleApproachingAtNFromW) 
                           and #macro(FromSWinsAtNOverW) }
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) 
                          and #macro(ParticleApproachingAtNFromW) }
%
%   Cell is a Synapsin from south. Cell to east is Fluid. There are no other approaching particles to the Fluid.
%
rule : 0 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsFluid) }
%
% Rules for Synapsin with a particle 'in front'.
%
%   Cell is a Synapsin from east and there is a particle 'in front'.
%
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromE) and #macro(CellToWIsNotFluid) }
%
%   Cell is a Synapsin from north and there is a particle 'in front'.
%
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromN) and #macro(CellToSIsNotFluid) }
%
%   Cell is a Synapsin from west and there is a particle 'in front'.
%
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromW) and #macro(CellToEIsNotFluid) }
%
%   Cell is a Synapsin from south and there is a particle 'in front'.
%
rule : { 21 + randInt(3) } 10 { #macro(CellIsSynapsinFromS) and #macro(CellToNIsNotFluid) }
%
% Rules for stationary Vesicles and Synapsins.
%
rule : { (0,0,0) } 10 { (0,0,0) = 19 and cellPos(2) = 0 }
rule : { (0,0,0) } 10 { (0,0,0) = 29 and cellPos(2) = 0 }
%
% Rule for cells in active zone.
%
rule : { (0,0,0) } 10 { #macro(CellIsInActiveZone) }
%
% Rules for remaining layers.
%
rule : 90 10 { cellPos(2) = 0 }
rule : { random } 10 { cellPos(2) = 1 }
rule : { (0,0,0) } 10 { cellPos(2) = 2 }
rule : { random } 10 { cellPos(2) = 3 }
rule : { random } 10 { cellPos(2) = 4 }
rule : { (0,0,0) + 1 } 10 { cellPos(2) = 5 }
rule : -1 10 { t }