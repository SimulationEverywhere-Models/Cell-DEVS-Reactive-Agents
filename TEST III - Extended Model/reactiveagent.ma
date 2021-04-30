#include(macro_directions.inc)
#include(macro_min.inc)

[top]
components : ReactiveAgents

[ReactiveAgents]
type : cell
width : 20
height : 20
delay : inertial
defaultDelayTime : 100
border : wrapped

%****************CELL NEIGHBORHOOD*****************%
neighbors : ReactiveAgents(-2,-2) ReactiveAgents(-2,-1) ReactiveAgents(-2,0) ReactiveAgents(-2,1) ReactiveAgents(-2,2)
neighbors : ReactiveAgents(-1,-2) ReactiveAgents(-1,-1) ReactiveAgents(-1,0) ReactiveAgents(-1,1) ReactiveAgents(-1,2) 
neighbors : ReactiveAgents(0,-2)  ReactiveAgents(0,-1)  ReactiveAgents(0,0)  ReactiveAgents(0,1)  ReactiveAgents(0,2) 
neighbors : ReactiveAgents(1,-2)  ReactiveAgents(1,-1)  ReactiveAgents(1,0)  ReactiveAgents(1,1)  ReactiveAgents(1,2) 
neighbors : ReactiveAgents(2,-2)  ReactiveAgents(2,-1)	ReactiveAgents(2,0)	 ReactiveAgents(2,1)  ReactiveAgents(2,2)
%**************************************************%

%******************STATE VALUES********************%
%   0 = Normal Cell (no discomfort)
% 100 = Warm Cell (minor discomfort)
% 200 = Heated Cell (major discomfort)
% 300 = Lava Cell (Unbearable and causes death)
% 400 = Magma Cell (even hotter than Lava)
% 500 = Plasma Cell (Insanely hot)

%   1 = Normal Cell occupied by a reactive agent
% 101 = Warm Cell occupied by a reactive agent
% 201 = Heated Cell occupied by a reactive agent
% 301 = Lava Cell occupied by a reactive agent
% 401 = Magma Cell occupied by a reactive agent
% 501 = Plasma Cell occupied by a reactive agent
%**************************************************%

%****************INITIAL CELL SPACE****************%
initialvalue : 0
initialCellsValue : reactiveagent.val
%**************************************************%


localtransition : AgentBehavior

[AgentBehavior]		

%***************************************RULE 1******************************************%
%*********** Move to the EAST(E) comfortable cell ***********%
rule : { (0,0) - 1 } 100 	{remainder( (0,0),100 ) = 1
							and remainder( (0,1),100 ) = 0			% East cell is unoccupied
							and #macro(MIN_NBR) = #macro(E)			% East cell is the most comfortable
							}

rule : { (0,0) + 1 } 100 	{remainder( (0,0),100 ) = 0
							and remainder( (0,-1),100 ) = 1
							and #macro(MIN_RCVR_E) = (0,0)
							}
							
%***************************************RULE 2******************************************%
%*********** Move to the NORTHEAST(NE) comfortable cell ***********%
rule : { (0,0) - 1 } 100 	{remainder( (0,0),100 ) = 1
							and remainder( (-1,1),100 ) = 0			% Northeast cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) = #macro(NE)		% Northeast cell is the most comfortable
							and remainder( (-1,0),100 ) != 1		% no other right-moving agent vying for the same cell
							}

rule : { (0,0) + 1 } 100 	{remainder( (0,0),100 ) = 0
							and remainder( (1,-1),100 ) = 1
							and #macro(MIN_RCVR_NE) != (1,0)
							and #macro(MIN_RCVR_NE) = (0,0)
							and remainder( (0,-1),100 ) != 1		% no other right-moving agent vying for the same cell
							}
							
%***************************************RULE 3******************************************%
%*********** Move to the SOUTHEAST(SE) comfortable cell ***********%
rule : { (0,0) - 1 } 100 	{remainder( (0,0),100 ) = 1
							and remainder( (1,1),100 ) = 0			% Southeast cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) = #macro(SE)
							and remainder( (1,0),100 ) != 1			% no other right-moving agent vying for the same cell
							and remainder( (2,0),100 ) != 1			% no other right-moving (diagonally up) agent vying for the same cell
							}

rule : { (0,0) + 1 } 100 	{remainder( (0,0),100 ) = 0
							and remainder( (-1,-1),100 ) = 1
							and #macro(MIN_RCVR_SE) != (-1,0)
							and #macro(MIN_RCVR_SE) != (-2,0)
							and #macro(MIN_RCVR_SE) = (0,0)
							and remainder( (0,-1),100 ) != 1		% no other right-moving agent vying for the same cell
							and remainder( (1,-1),100 ) != 1		% no other right-moving (diagonally up) agent vying for the same cell
							}		

%***************************************RULE 4******************************************%
%*********** Move to the NORTH(N) comfortable cell ***********%
rule : { (0,0) - 1 } 100 	{remainder( (0,0),100 ) = 1
							and remainder( (-1,0),100 ) = 0			% North cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) != #macro(SE)
							and #macro(MIN_NBR) = #macro(N)
							and remainder( (-1,-1),100 ) != 1		% no other right-moving agent vying for the same cell
							and remainder( (0,-1),100 ) != 1		% no other right-moving (diagonally up) agent vying for the same cell
							and remainder( (-2,-1),100 ) != 1		% no other right-moving (diagonally down) agent vying for the same cell
							}

rule : { (0,0) + 1 } 100 	{remainder( (0,0),100 ) = 0
							and remainder( (1,0),100 ) = 1
							and #macro(MIN_RCVR_N) != (1,1)
							and #macro(MIN_RCVR_N) != (0,1)
							and #macro(MIN_RCVR_N) != (2,1)
							and #macro(MIN_RCVR_N) = (0,0)
							and remainder( (0,-1),100 ) != 1		% no other right-moving agent vying for the same cell
							and remainder( (-1,-1),100 ) != 1		% no other right-moving (diagonally up) agent vying for the same cell
							and remainder( (1,-1),100 ) != 1		% no other right-moving (diagonally down) agent vying for the same cell
							}		

%***************************************RULE 5******************************************%
%*********** Move to the SOUTH(S) comfortable cell ***********%
rule : { (0,0) - 1 } 100 	{remainder( (0,0),100 ) = 1
							and remainder( (1,0),100 ) = 0			% South cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) != #macro(SE)
							and #macro(MIN_NBR) != #macro(N)
							and #macro(MIN_NBR) = #macro(S)
							and remainder( (1,-1),100 ) != 1		% no other right-moving agent vying for the same cell
							and remainder( (2,-1),100 ) != 1		% no other right-moving (diagonally up) agent vying for the same cell
							and remainder( (0,-1),100 ) != 1		% no other right-moving (diagonally down) agent vying for the same cell
							and remainder( (2,0),100 ) != 1			% no other up-moving agent vying for the same cell
							}

rule : { (0,0) + 1 } 100 	{remainder( (0,0),100 ) = 0
							and remainder( (-1,0),100 ) = 1
							and #macro(MIN_RCVR_S) != (-1,1)
							and #macro(MIN_RCVR_S) != (-2,1)
							and #macro(MIN_RCVR_S) != (0,1)
							and #macro(MIN_RCVR_S) != (-2,0)
							and #macro(MIN_RCVR_S) = (0,0)
							and remainder( (0,-1),100 ) != 1		% no other right-moving agent vying for the same cell
							and remainder( (-1,-1),100 ) != 1		% no other right-moving (diagonally up) agent vying for the same cell
							and remainder( (1,-1),100 ) != 1		% no other right-moving (diagonally up) agent vying for the same cell
							and remainder( (1,0),100 ) != 1			% no other up-moving agent vying for the same cell
							}	

%***************************************RULE 6******************************************%
%*********** Move to the NORTHWEST(NW) comfortable cell ***********%
rule : { (0,0) - 1 } 100 	{remainder( (0,0),100 ) = 1
							and remainder( (-1,-1),100 ) = 0		% Northwest cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) != #macro(SE)
							and #macro(MIN_NBR) != #macro(N)
							and #macro(MIN_NBR) != #macro(S)
							and #macro(MIN_NBR) = #macro(NW)
							and remainder( (-1,-2),100 ) != 1		% no other right-moving agent vying for the same cell
							and remainder( (0,-2),100 ) != 1		% no other right-moving (diagonally up) agent vying for the same cell
							and remainder( (-2,-2),100 ) != 1		% no other right-moving (diagonally down) agent vying for the same cell
							and remainder( (0,-1),100 ) != 1		% no other up-moving agent vying for the same cell
							and remainder( (-2,-1),100 ) != 1		% no other down-moving agent vying for the same cell
							}

rule : { (0,0) + 1 } 100 	{remainder( (0,0),100 ) = 0
							and remainder( (1,1),100 ) = 1
							and #macro(MIN_RCVR_NW) != (1,2)
							and #macro(MIN_RCVR_NW) != (0,2)
							and #macro(MIN_RCVR_NW) != (2,2)
							and #macro(MIN_RCVR_NW) != (0,1)
							and #macro(MIN_RCVR_NW) != (2,1)
							and #macro(MIN_RCVR_NW) = (0,0)
							and remainder( (0,-1),100 ) != 1		% no other right-moving agent vying for the same cell
							and remainder( (-1,-1),100 ) != 1		% no other right-moving (diagonally up) agent vying for the same cell
							and remainder( (1,-1),100 ) != 1		% no other right-moving (diagonally down) agent vying for the same cell
							and remainder( (1,0),100 ) != 1			% no other up-moving agent vying for the same cell
							and remainder( (-1,0),100 ) != 1		% no other down-moving agent vying for the same cell
							}		
							
%***************************************RULE 7******************************************%
%*********** Move to the SOUTHWEST(SW) comfortable cell ***********%
rule : { (0,0) - 1 } 100 	{remainder( (0,0),100 ) = 1
							and remainder( (1,-1),100 ) = 0		% Northwest cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) != #macro(SE)
							and #macro(MIN_NBR) != #macro(N)
							and #macro(MIN_NBR) != #macro(S)
							and #macro(MIN_NBR) != #macro(NW)
							and #macro(MIN_NBR) = #macro(SW)
							and remainder( (1,-2),100 ) != 1		% no other right-moving agent vying for the same cell
							and remainder( (0,-2),100 ) != 1		% no other right-moving (diagonally up) agent vying for the same cell
							and remainder( (2,-2),100 ) != 1		% no other right-moving (diagonally down) agent vying for the same cell
							and remainder( (0,-1),100 ) != 1		% no other up-moving agent vying for the same cell
							and remainder( (2,-1),100 ) != 1		% no other down-moving agent vying for the same cell
							and remainder( (2,0),100 ) != 1			% no other left-moving (diagonally up) agent vying for the same cell
							}

rule : { (0,0) + 1 } 100 	{remainder( (0,0),100 ) = 0
							and remainder( (-1,1),100 ) = 1
							and #macro(MIN_RCVR_SW) != (-1,2)
							and #macro(MIN_RCVR_SW) != (-2,2)
							and #macro(MIN_RCVR_SW) != (0,2)
							and #macro(MIN_RCVR_SW) != (-2,1)
							and #macro(MIN_RCVR_SW) != (0,1)
							and #macro(MIN_RCVR_SW) != (-2,0)
							and #macro(MIN_RCVR_SW) = (0,0)
							and remainder( (0,-1),100 ) != 1		% no other right-moving agent vying for the same cell
							and remainder( (-1,-1),100 ) != 1		% no other right-moving agent diagonally(up) vying for the same cell
							and remainder( (1,-1),100 ) != 1		% no other right-moving agent diagonally(down) vying for the same cell
							and remainder( (1,0),100 ) != 1			% no other up-moving agent vying for the same cell
							and remainder( (-1,0),100 ) != 1		% no other down-moving agent vying for the same cell
							and remainder( (1,1),100 ) != 1			% no other left-moving (diagonally up) agent vying for the same cell
							}	
							
%***************************************RULE 8******************************************%
%*********** Move to the WEST(W) comfortable cell ***********%
rule : { (0,0) - 1 } 100 	{remainder( (0,0),100 ) = 1
							and remainder( (0,-1),100 ) = 0			% West cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) != #macro(SE)
							and #macro(MIN_NBR) != #macro(N)
							and #macro(MIN_NBR) != #macro(S)
							and #macro(MIN_NBR) != #macro(NW)
							and #macro(MIN_NBR) != #macro(SW)
							and #macro(MIN_NBR) = #macro(W)
							and remainder( (0,-2),100 ) != 1		% no other right-moving agent vying for the same cell
							and remainder( (1,-2),100 ) != 1		% no other right-moving (diagonally up) agent vying for the same cell
							and remainder( (-1,2),100 ) != 1		% no other right-moving (diagonally down) agent vying for the same cell
							and remainder( (1,-1),100 ) != 1		% no other up-moving agent vying for the same cell
							and remainder( (-1,-1),100 ) != 1		% no other down-moving agent vying for the same cell
							and remainder( (1,0),100 ) != 1			% no other left-moving (diagonally up) agent vying for the same cell
							and remainder( (-1,0),100 ) != 1		% no other left-moving (diagonally down) agent vying for the same cell
							}

rule : { (0,0) + 1 } 100 	{remainder( (0,0),100 ) = 0
							and remainder( (0,1),100 ) = 1
							and #macro(MIN_RCVR_W) != (0,2)
							and #macro(MIN_RCVR_W) != (-1,2)
							and #macro(MIN_RCVR_W) != (1,2)
							and #macro(MIN_RCVR_W) != (-1,1)
							and #macro(MIN_RCVR_W) != (1,1)
							and #macro(MIN_RCVR_W) != (-1,0)
							and #macro(MIN_RCVR_W) != (1,0)
							and #macro(MIN_RCVR_W) = (0,0)
							and remainder( (0,-1),100 ) != 1		% no other right-moving agent vying for the same cell
							and remainder( (-1,-1),100 ) != 1		% no other right-moving agent diagonally(up) vying for the same cell
							and remainder( (1,-1),100 ) != 1		% no other right-moving agent diagonally(down) vying for the same cell
							and remainder( (1,0),100 ) != 1			% no other up-moving agent vying for the same cell
							and remainder( (-1,0),100 ) != 1		% no other down-moving agent vying for the same cell
							and remainder( (1,1),100 ) != 1			% no other left-moving (diagonally up) agent vying for the same cell
							and remainder( (-1,1),100 ) != 1		% no other left-moving (diagonally down) agent vying for the same cell
							}	

%*******************DEFAULT RULE*******************%
% Do not move
rule : { (0,0) } 100 { t }