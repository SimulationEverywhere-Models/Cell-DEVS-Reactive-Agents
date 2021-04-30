#include(macro_directions.inc)
#include(macro_min.inc)
#include(macro_comfort.inc)
#include(macro_desirability.inc)
#include(macro_weights.inc)


[top]
components : ReactiveAgents

[ReactiveAgents]
type : cell
width : 10
height : 10
delay : transport
defaultDelayTime : 100
border : wrapped

%****************CELL NEIGHBORHOOD*****************%
neighbors : ReactiveAgents(-2,-2) ReactiveAgents(-2,-1) ReactiveAgents(-2,0) ReactiveAgents(-2,1) ReactiveAgents(-2,2)
neighbors : ReactiveAgents(-1,-2) ReactiveAgents(-1,-1) ReactiveAgents(-1,0) ReactiveAgents(-1,1) ReactiveAgents(-1,2)
neighbors : ReactiveAgents(0,-2)  ReactiveAgents(0,-1)  ReactiveAgents(0,0)  ReactiveAgents(0,1)  ReactiveAgents(0,2) 
neighbors : ReactiveAgents(1,-2)  ReactiveAgents(1,-1)  ReactiveAgents(1,0)  ReactiveAgents(1,1)  ReactiveAgents(1,2) 
neighbors : ReactiveAgents(2,-2)  ReactiveAgents(2,-1)	ReactiveAgents(2,0)  ReactiveAgents(2,1)  ReactiveAgents(2,2)
%**************************************************%

%****************INITIAL CELL SPACE****************%
initialvalue : 0
%**************************************************%

%*****************NEIGHBOR PORTS*******************%
neighborports : occ celltype comfort desire preference
% occ 		--> occupancy information
% celltype	--> the type of cell
% comfort 	--> comfort_level
% desire 	--> desirability
%**************************************************%

%****************STATE VARIABLES*******************%
statevariables : agent cell heat pressure wetness desirability inclination
statevalues : 0 0 0 0 0 0 0
initialvariablesvalue : reactiveagent.val
%**************************************************%

%******************STATE VALUES********************%
% $agent = 0 --> no agent present/empty cell
% $agent = 1 --> human agent in cell
%**************************************************%


localtransition : AgentBehavior
		
		
[AgentBehavior]		
%***************************************RULE 0******************************************%
%*********** The Instadeath Rule ***********%
rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability;
		~preference:= $inclination;
		~occ:= $inclination; } { $agent:= 0; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100
							{ (0,0)~occ >= 1 and (0,0)~occ < 2				% cell is occupied
							and (0,0)~comfort >= 0.80					% 80 percent discomfort
							}

%***************************************RULE 1******************************************%
%*********** Move to the EAST(E) comfortable cell ***********%
rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability;
		~preference:= $inclination; 
		~occ:= $agent + $inclination; } { $agent:= 0; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (0,0)~comfort < 0.80
							and (0,1)~occ < 1			% East cell is unoccupied
							and #macro(MIN_NBR) = #macro(E)		% East cell is the most comfortable
							}

rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 1; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100
							{ (0,0)~occ < 1
							and (0,-1)~occ >= 1 and (0,-1)~occ < 2			% An agent is trying to move from the west cell
							and (0,-1)~comfort < 0.80
							and #macro(MIN_RCVR_E) = (0,0)~preference
							}
							
							
%***************************************RULE 2******************************************%
%*********** Move to the NORTHEAST(NE) comfortable cell ***********%
rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 0; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (0,0)~comfort < 0.80
							and (-1,1)~occ < 1			% Northeast cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) = #macro(NE)	% Northeast cell is the most comfortable
							and (-1,0)~occ < 1			% no other right-moving agent vying for the same cell
							}

rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability;
		~preference:= $inclination; 
		~occ:= $agent + $inclination; } { $agent:= 1; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100
							{ (0,0)~occ < 1
							and (1,-1)~occ >= 1 and (1,-1)~occ < 2
							and (1,-1)~comfort < 0.80
							and #macro(MIN_RCVR_NE) != (1,0)~preference
							and #macro(MIN_RCVR_NE) = (0,0)~preference
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							}
							
%***************************************RULE 3******************************************%
%*********** Move to the SOUTHEAST(SE) comfortable cell ***********%
rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 0; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100  	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (0,0)~comfort < 0.80
							and (1,1)~occ < 1			% Southeast cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) = #macro(SE)
							and (1,0)~occ < 1			% no other right-moving agent vying for the same cell
							and (2,0)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							}

rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 1; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100
							{ (0,0)~occ < 1
							and (-1,-1)~occ >= 1 and (-1,-1)~occ < 2
							and (-1,-1)~comfort < 0.80
							and #macro(MIN_RCVR_SE) != (-1,0)~preference
							and #macro(MIN_RCVR_SE) != (-2,0)~preference
							and #macro(MIN_RCVR_SE) = (0,0)~preference
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							}		

%***************************************RULE 4******************************************%
%*********** Move to the NORTH(N) comfortable cell ***********%
rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 0; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (0,0)~comfort < 0.80
							and (-1,0)~occ < 1		% North cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) != #macro(SE)
							and #macro(MIN_NBR) = #macro(N)
							and (-1,-1)~occ < 1		% no other right-moving agent vying for the same cell
							and (0,-1)~occ < 1		% no other right-moving (diagonally up) agent vying for the same cell
							and (-2,-1)~occ < 1		% no other right-moving (diagonally down) agent vying for the same cell
							}

rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 1; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100
							{ (0,0)~occ < 1
							and (1,0)~occ >= 1 and (1,0)~occ < 2
							and (1,0)~comfort < 0.80
							and #macro(MIN_RCVR_N) != (1,1)~preference
							and #macro(MIN_RCVR_N) != (0,1)~preference
							and #macro(MIN_RCVR_N) != (2,1)~preference
							and #macro(MIN_RCVR_N) = (0,0)~preference
							and (0,-1)~occ < 1		% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1		% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1		% no other right-moving (diagonally down) agent vying for the same cell
							}		

%***************************************RULE 5******************************************%
%*********** Move to the SOUTH(S) comfortable cell ***********%
rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 0; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100 	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (0,0)~comfort < 0.80
							and (1,0)~occ < 1		% South cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) != #macro(SE)
							and #macro(MIN_NBR) != #macro(N)
							and #macro(MIN_NBR) = #macro(S)
							and (1,-1)~occ < 1		% no other right-moving agent vying for the same cell
							and (2,-1)~occ < 1		% no other right-moving (diagonally up) agent vying for the same cell
							and (0,-1)~occ < 1		% no other right-moving (diagonally down) agent vying for the same cell
							and (2,0)~occ < 1		% no other up-moving agent vying for the same cell
							}

rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 1; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100
							{ (0,0)~occ < 1
							and (-1,0)~occ >= 1 and (-1,0)~occ < 2
							and (-1,0)~comfort < 0.80
							and #macro(MIN_RCVR_S) != (-1,1)~preference
							and #macro(MIN_RCVR_S) != (-2,1)~preference
							and #macro(MIN_RCVR_S) != (0,1)~preference
							and #macro(MIN_RCVR_S) != (-2,0)~preference
							and #macro(MIN_RCVR_S) = (0,0)~preference
							and (0,-1)~occ < 1		% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1		% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1		% no other right-moving (diagonally up) agent vying for the same cell
							and (1,0)~occ < 1		% no other up-moving agent vying for the same cell
							}	

%***************************************RULE 6******************************************%
%*********** Move to the NORTHWEST(NW) comfortable cell ***********%
rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 0; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (0,0)~comfort < 0.80
							and (-1,-1)~occ < 1		% Northwest cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) != #macro(SE)
							and #macro(MIN_NBR) != #macro(N)
							and #macro(MIN_NBR) != #macro(S)
							and #macro(MIN_NBR) = #macro(NW)
							and (-1,-2)~occ < 1		% no other right-moving agent vying for the same cell
							and (0,-2)~occ < 1		% no other right-moving (diagonally up) agent vying for the same cell
							and (-2,-2)~occ < 1		% no other right-moving (diagonally down) agent vying for the same cell
							and (0,-1)~occ < 1		% no other up-moving agent vying for the same cell
							and (-2,-1)~occ < 1		% no other down-moving agent vying for the same cell
							}

rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 1; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100
							{ (0,0)~occ < 1
							and (1,1)~occ >= 1 and (1,1)~occ < 2
							and (1,1)~comfort < 0.80
							and #macro(MIN_RCVR_NW) != (1,2)~preference
							and #macro(MIN_RCVR_NW) != (0,2)~preference
							and #macro(MIN_RCVR_NW) != (2,2)~preference
							and #macro(MIN_RCVR_NW) != (0,1)~preference
							and #macro(MIN_RCVR_NW) != (2,1)~preference
							and #macro(MIN_RCVR_NW) = (0,0)~preference
							and (0,-1)~occ < 1		% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1		% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1		% no other right-moving (diagonally down) agent vying for the same cell
							and (1,0)~occ < 1		% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1		% no other down-moving agent vying for the same cell
							}		
							
%***************************************RULE 7******************************************%
%*********** Move to the SOUTHWEST(SW) comfortable cell ***********%
rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 0; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (0,0)~comfort < 0.80
							and (1,-1)~occ < 1		% Northwest cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) != #macro(SE)
							and #macro(MIN_NBR) != #macro(N)
							and #macro(MIN_NBR) != #macro(S)
							and #macro(MIN_NBR) != #macro(NW)
							and #macro(MIN_NBR) = #macro(SW)
							and (1,-2)~occ < 1		% no other right-moving agent vying for the same cell
							and (0,-2)~occ < 1		% no other right-moving (diagonally up) agent vying for the same cell
							and (2,-2)~occ < 1		% no other right-moving (diagonally down) agent vying for the same cell
							and (0,-1)~occ < 1		% no other up-moving agent vying for the same cell
							and (2,-1)~occ < 1		% no other down-moving agent vying for the same cell
							and (2,0)~occ < 1		% no other left-moving (diagonally up) agent vying for the same cell
							}

rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 1; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100
							{ (0,0)~occ < 1
							and (-1,1)~occ >= 1 and (-1,1)~occ < 2
							and (-1,1)~comfort < 0.80
							and #macro(MIN_RCVR_SW) != (-1,2)~preference
							and #macro(MIN_RCVR_SW) != (-2,2)~preference
							and #macro(MIN_RCVR_SW) != (0,2)~preference
							and #macro(MIN_RCVR_SW) != (-2,1)~preference
							and #macro(MIN_RCVR_SW) != (0,1)~preference
							and #macro(MIN_RCVR_SW) != (-2,0)~preference
							and #macro(MIN_RCVR_SW) = (0,0)~preference
							and (0,-1)~occ < 1		% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1		% no other right-moving agent diagonally(up) vying for the same cell
							and (1,-1)~occ < 1		% no other right-moving agent diagonally(down) vying for the same cell
							and (1,0)~occ < 1		% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1		% no other down-moving agent vying for the same cell
							and (1,1)~occ < 1		% no other left-moving (diagonally up) agent vying for the same cell
							}	
							
%***************************************RULE 8******************************************%
%*********** Move to the WEST(W) comfortable cell ***********%
rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 0; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100 	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (0,0)~comfort < 0.80
							and (0,-1)~occ < 1		% West cell is unoccupied
							and #macro(MIN_NBR) != #macro(E)
							and #macro(MIN_NBR) != #macro(NE)
							and #macro(MIN_NBR) != #macro(SE)
							and #macro(MIN_NBR) != #macro(N)
							and #macro(MIN_NBR) != #macro(S)
							and #macro(MIN_NBR) != #macro(NW)
							and #macro(MIN_NBR) != #macro(SW)
							and #macro(MIN_NBR) = #macro(W)
							and (0,-2)~occ < 1		% no other right-moving agent vying for the same cell
							and (1,-2)~occ < 1		% no other right-moving (diagonally up) agent vying for the same cell
							and (-1,2)~occ < 1		% no other right-moving (diagonally down) agent vying for the same cell
							and (1,-1)~occ < 1		% no other up-moving agent vying for the same cell
							and (-1,-1)~occ < 1		% no other down-moving agent vying for the same cell
							and (1,0)~occ < 1		% no other left-moving (diagonally up) agent vying for the same cell
							and (-1,0)~occ < 1		% no other left-moving (diagonally down) agent vying for the same cell
							}

rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $agent:= 1; $desirability:= #macro(SPREAD_DESIRE); 
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100
							{ (0,0)~occ < 1
							and (0,1)~occ >= 1 and (0,1)~occ < 2
							and (0,1)~comfort < 0.80
							and #macro(MIN_RCVR_W) != (0,2)~preference
							and #macro(MIN_RCVR_W) != (-1,2)~preference
							and #macro(MIN_RCVR_W) != (1,2)~preference
							and #macro(MIN_RCVR_W) != (-1,1)~preference
							and #macro(MIN_RCVR_W) != (1,1)~preference
							and #macro(MIN_RCVR_W) != (-1,0)~preference
							and #macro(MIN_RCVR_W) != (1,0)~preference
							and #macro(MIN_RCVR_W) = (0,0)~preference
							and (0,-1)~occ < 1		% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1		% no other right-moving agent diagonally(up) vying for the same cell
							and (1,-1)~occ < 1		% no other right-moving agent diagonally(down) vying for the same cell
							and (1,0)~occ < 1		% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1		% no other down-moving agent vying for the same cell
							and (1,1)~occ < 1		% no other left-moving (diagonally up) agent vying for the same cell
							and (-1,1)~occ < 1		% no other left-moving (diagonally down) agent vying for the same cell
							}	

%*******************DEFAULT RULE*******************%
% Do not move
rule : { ~celltype:= $cell;
		~comfort:= #macro(COMFORT_LEVEL);
		~desire:=  $desirability; 
		~preference:= $inclination;
		~occ:= $agent + $inclination; } { $desirability:= #macro(SPREAD_DESIRE);  
		$inclination:= #macro(W_COMFORT)*#macro(COMFORT_LEVEL) + #macro(W_DESIRE)*#macro(DESIRABILITY); } 100 { t }