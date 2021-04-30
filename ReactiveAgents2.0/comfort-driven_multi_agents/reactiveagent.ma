#include(macro_directions.inc)
#include(macro_min.inc)
#include(macro_comfort.inc)
#include(macro_desirability.inc)

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

%*****************NEIGHBOR PORTS*******************%
neighborports : occ celltype comfort_human comfort_mons comfort_alien desire
% occ 			--> occupancy information
% comfort_human 	--> comfort_level of a human
% comfort_mons 		--> comfort_level of a fiery moster
% comfort_alien 	--> comfort_level of a vapor alien
% desire 		--> desirability
%**************************************************%

%****************STATE VARIABLES*******************%
initialvalue : 0
statevariables : agent cell heat pressure wetness desirability
statevalues : 0 0 0 0 0 0
initialvariablesvalue : reactiveagent.val
%**************************************************%

%******************STATE VALUES********************%
% $agent = 0 --> no agent present/empty cell
% $agent = 1 --> human agent in cell
% $agent = 2 --> fiery monster in cell
% $agent = 3 --> vapor alien in cell
%**************************************************%

localtransition : AgentBehavior		
		
[AgentBehavior]		
%***************************************RULE 1******************************************%
%*********** Move to the EAST(E) comfortable cell ***********%
% Human Agent: Highest priority among agents
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100
							{ (0,0)~occ >= 1 and (0,0)~occ < 2		% cell occupied by a human agent
							and (0,1)~occ < 1						% East cell is unoccupied
							and #macro(MIN_NBR_HUMAN) = #macro(E_HUMAN)	% East cell is the most comfortable
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 1; } 100  
							{ (0,0)~occ < 1
							and (0,-1)~occ >= 1	 and (0,-1)~occ < 2		% A human agent is trying to move from the west cell
							and #macro(MIN_RCVR_E_HUMAN) = (0,0)~comfort_human
							}
							
% Monster Agent: Moderate priority
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100 
							{ (0,0)~occ >= 2 and (0,0)~occ < 3		% cell occupied by a monster agent
							and (0,1)~occ < 1						% East cell is unoccupied
							and #macro(MIN_NBR_MONS) = #macro(E_MONS)	% East cell is the most comfortable
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 2; } 100  
							{ (0,0)~occ < 1
							and (0,-1)~occ >= 2	 and (0,-1)~occ < 3		% A monster agent is trying to move from the west cell
							and #macro(MIN_RCVR_E_MONS) = (0,0)~comfort_mons
							}
							
% Alien Agent: Lowest priority among agents
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100
							{ (0,0)~occ >= 3 and (0,0)~occ < 4		% cell occupied by an alien agent
							and (0,1)~occ < 1						% East cell is unoccupied
							and #macro(MIN_NBR_ALIEN) = #macro(E_ALIEN)	% East cell is the most comfortable
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 3; } 100 
							{ (0,0)~occ < 1
							and (0,-1)~occ >= 3	 and (0,-1)~occ < 4		% An alien agent is trying to move from the west cell
							and #macro(MIN_RCVR_E_ALIEN) = (0,0)~comfort_alien
							}
							
%***************************************RULE 2******************************************%
%*********** Move to the NORTHEAST(NE) comfortable cell ***********%
% Human Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100 	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (-1,1)~occ < 1					% Northeast cell is unoccupied
							and #macro(MIN_NBR_HUMAN) != #macro(E_HUMAN)
							and #macro(MIN_NBR_HUMAN) = #macro(NE_HUMAN)	% Northeast cell is the most comfortable
							and (-1,0)~occ < 1			% no other right-moving agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 1; } 100 	
							{ (0,0)~occ < 1
							and (1,-1)~occ >= 1 and (1,-1)~occ < 2
							and #macro(MIN_RCVR_NE_HUMAN) != (1,0)~comfort_human
							and #macro(MIN_RCVR_NE_HUMAN) = (0,0)~comfort_human
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							}
							
% Monster Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100  	
							{ (0,0)~occ >= 2 and (0,0)~occ < 3
							and (-1,1)~occ < 1					% Northeast cell is unoccupied
							and #macro(MIN_NBR_MONS) != #macro(E_MONS)
							and #macro(MIN_NBR_MONS) = #macro(NE_MONS)	% Northeast cell is the most comfortable
							and (-1,0)~occ < 1			% no other right-moving agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 2; } 100	
							{ (0,0)~occ < 1
							and (1,-1)~occ >= 2 and (1,-1)~occ < 3
							and #macro(MIN_RCVR_NE_MONS) != (1,0)~comfort_mons
							and #macro(MIN_RCVR_NE_MONS) = (0,0)~comfort_mons
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							}
							
% Alien Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100	
							{ (0,0)~occ >= 3 and (0,0)~occ < 4
							and (-1,1)~occ < 1					% Northeast cell is unoccupied
							and #macro(MIN_NBR_ALIEN) != #macro(E_ALIEN)
							and #macro(MIN_NBR_ALIEN) = #macro(NE_ALIEN)	% Northeast cell is the most comfortable
							and (-1,0)~occ < 1			% no other right-moving agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 3; } 100	
							{ (0,0)~occ < 1
							and (1,-1)~occ >= 3 and (1,-1)~occ < 4
							and #macro(MIN_RCVR_NE_ALIEN) != (1,0)~comfort_alien
							and #macro(MIN_RCVR_NE_ALIEN) = (0,0)~comfort_alien
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							}
							
%***************************************RULE 3******************************************%
%*********** Move to the SOUTHEAST(SE) comfortable cell ***********%
% Human Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100 	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (1,1)~occ < 1			% Southeast cell is unoccupied
							and #macro(MIN_NBR_HUMAN) != #macro(E_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(NE_HUMAN)
							and #macro(MIN_NBR_HUMAN) = #macro(SE_HUMAN)
							and (1,0)~occ < 1			% no other right-moving agent vying for the same cell
							and (2,0)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 1; } 100 	
							{ (0,0)~occ < 1
							and (-1,-1)~occ >= 1 and (-1,-1)~occ < 2
							and #macro(MIN_RCVR_SE_HUMAN) != (-1,0)~comfort_human
							and #macro(MIN_RCVR_SE_HUMAN) != (-2,0)~comfort_human
							and #macro(MIN_RCVR_SE_HUMAN) = (0,0)~comfort_human
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							}	

% Monster Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100  	
							{ (0,0)~occ >= 2 and (0,0)~occ < 3
							and (1,1)~occ < 1			% Southeast cell is unoccupied
							and #macro(MIN_NBR_MONS) != #macro(E_MONS)
							and #macro(MIN_NBR_MONS) != #macro(NE_MONS)
							and #macro(MIN_NBR_MONS) = #macro(SE_MONS)
							and (1,0)~occ < 1			% no other right-moving agent vying for the same cell
							and (2,0)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 2; } 100 	
							{ (0,0)~occ < 1
							and (-1,-1)~occ >= 2 and (-1,-1)~occ < 3
							and #macro(MIN_RCVR_SE_MONS) != (-1,0)~comfort_mons
							and #macro(MIN_RCVR_SE_MONS) != (-2,0)~comfort_mons
							and #macro(MIN_RCVR_SE_MONS) = (0,0)~comfort_mons
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							}	

% Alien Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100	
							{ (0,0)~occ >= 3 and (0,0)~occ < 4
							and (1,1)~occ < 1			% Southeast cell is unoccupied
							and #macro(MIN_NBR_ALIEN) != #macro(E_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(NE_ALIEN)
							and #macro(MIN_NBR_ALIEN) = #macro(SE_ALIEN)
							and (1,0)~occ < 1			% no other right-moving agent vying for the same cell
							and (2,0)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 3; } 100 	
							{ (0,0)~occ < 1
							and (-1,-1)~occ >= 3 and (-1,-1)~occ < 4
							and #macro(MIN_RCVR_SE_ALIEN) != (-1,0)~comfort_alien
							and #macro(MIN_RCVR_SE_ALIEN) != (-2,0)~comfort_alien
							and #macro(MIN_RCVR_SE_ALIEN) = (0,0)~comfort_alien
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							}		

%***************************************RULE 4******************************************%
%*********** Move to the NORTH(N) comfortable cell ***********%
% Human Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (-1,0)~occ < 1			% North cell is unoccupied
							and #macro(MIN_NBR_HUMAN) != #macro(E_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(NE_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(SE_HUMAN)
							and #macro(MIN_NBR_HUMAN) = #macro(N_HUMAN)
							and (-1,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (0,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (-2,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 1; } 100 	
							{ (0,0)~occ < 1
							and (1,0)~occ >= 1 and (1,0)~occ < 2
							and #macro(MIN_RCVR_N_HUMAN) != (1,1)~comfort_human
							and #macro(MIN_RCVR_N_HUMAN) != (0,1)~comfort_human
							and #macro(MIN_RCVR_N_HUMAN) != (2,1)~comfort_human
							and #macro(MIN_RCVR_N_HUMAN) = (0,0)~comfort_human
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							}		

% Monster Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100	
							{ (0,0)~occ >= 2 and (0,0)~occ < 3
							and (-1,0)~occ < 1			% North cell is unoccupied
							and #macro(MIN_NBR_MONS) != #macro(E_MONS)
							and #macro(MIN_NBR_MONS) != #macro(NE_MONS)
							and #macro(MIN_NBR_MONS) != #macro(SE_MONS)
							and #macro(MIN_NBR_MONS) = #macro(N_MONS)
							and (-1,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (0,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (-2,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 2; } 100	
							{ (0,0)~occ < 1
							and (1,0)~occ >= 2 and (1,0)~occ < 3
							and #macro(MIN_RCVR_N_MONS) != (1,1)~comfort_mons
							and #macro(MIN_RCVR_N_MONS) != (0,1)~comfort_mons
							and #macro(MIN_RCVR_N_MONS) != (2,1)~comfort_mons
							and #macro(MIN_RCVR_N_MONS) = (0,0)~comfort_mons
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							}
							
% Alien Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100	
							{ (0,0)~occ >= 3 and (0,0)~occ < 4
							and (-1,0)~occ < 1			% North cell is unoccupied
							and #macro(MIN_NBR_ALIEN) != #macro(E_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(NE_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(SE_ALIEN)
							and #macro(MIN_NBR_ALIEN) = #macro(N_ALIEN)
							and (-1,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (0,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (-2,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 3; } 100	
							{ (0,0)~occ < 1
							and (1,0)~occ >= 3 and (1,0)~occ < 4
							and #macro(MIN_RCVR_N_ALIEN) != (1,1)~comfort_alien
							and #macro(MIN_RCVR_N_ALIEN) != (0,1)~comfort_alien
							and #macro(MIN_RCVR_N_ALIEN) != (2,1)~comfort_alien
							and #macro(MIN_RCVR_N_ALIEN) = (0,0)~comfort_alien
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							}
							
%***************************************RULE 5******************************************%
%*********** Move to the SOUTH(S) comfortable cell ***********%
% Human Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100 	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (1,0)~occ < 1			% South cell is unoccupied
							and #macro(MIN_NBR_HUMAN) != #macro(E_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(NE_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(SE_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(N_HUMAN)
							and #macro(MIN_NBR_HUMAN) = #macro(S_HUMAN)
							and (1,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (2,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (0,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (2,0)~occ < 1			% no other up-moving agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 1; } 100  	
							{ (0,0)~occ < 1
							and (-1,0)~occ >= 1 and (-1,0)~occ < 2
							and #macro(MIN_RCVR_S_HUMAN) != (-1,1)~comfort_human
							and #macro(MIN_RCVR_S_HUMAN) != (-2,1)~comfort_human
							and #macro(MIN_RCVR_S_HUMAN) != (0,1)~comfort_human
							and #macro(MIN_RCVR_S_HUMAN) != (-2,0)~comfort_human
							and #macro(MIN_RCVR_S_HUMAN) = (0,0)~comfort_human
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							}	
							
% Monster Agent
rule : { ~occ:= $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100  	
							{ (0,0)~occ >= 2 and (0,0)~occ < 3
							and (1,0)~occ < 1			% South cell is unoccupied
							and #macro(MIN_NBR_MONS) != #macro(E_MONS)
							and #macro(MIN_NBR_MONS) != #macro(NE_MONS)
							and #macro(MIN_NBR_MONS) != #macro(SE_MONS)
							and #macro(MIN_NBR_MONS) != #macro(N_MONS)
							and #macro(MIN_NBR_MONS) = #macro(S_MONS)
							and (1,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (2,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (0,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (2,0)~occ < 1			% no other up-moving agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 2; } 100  	
							{ (0,0)~occ < 1
							and (-1,0)~occ >= 2 and (-1,0)~occ < 3
							and #macro(MIN_RCVR_S_MONS) != (-1,1)~comfort_mons
							and #macro(MIN_RCVR_S_MONS) != (-2,1)~comfort_mons
							and #macro(MIN_RCVR_S_MONS) != (0,1)~comfort_mons
							and #macro(MIN_RCVR_S_MONS) != (-2,0)~comfort_mons
							and #macro(MIN_RCVR_S_MONS) = (0,0)~comfort_mons
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							}	
							
% Alien Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100	
							{ (0,0)~occ >= 3 and (0,0)~occ < 4
							and (1,0)~occ < 1			% South cell is unoccupied
							and #macro(MIN_NBR_ALIEN) != #macro(E_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(NE_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(SE_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(N_ALIEN)
							and #macro(MIN_NBR_ALIEN) = #macro(S_ALIEN)
							and (1,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (2,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (0,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (2,0)~occ < 1			% no other up-moving agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 3; } 100 	
							{ (0,0)~occ < 1
							and (-1,0)~occ >= 3 and (-1,0)~occ < 4
							and #macro(MIN_RCVR_S_ALIEN) != (-1,1)~comfort_alien
							and #macro(MIN_RCVR_S_ALIEN) != (-2,1)~comfort_alien
							and #macro(MIN_RCVR_S_ALIEN) != (0,1)~comfort_alien
							and #macro(MIN_RCVR_S_ALIEN) != (-2,0)~comfort_alien
							and #macro(MIN_RCVR_S_ALIEN) = (0,0)~comfort_alien
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							}	

%***************************************RULE 6******************************************%
%*********** Move to the NORTHWEST(NW) comfortable cell ***********%
% Human Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (-1,-1)~occ < 1		% Northwest cell is unoccupied
							and #macro(MIN_NBR_HUMAN) != #macro(E_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(NE_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(SE_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(N_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(S_HUMAN)
							and #macro(MIN_NBR_HUMAN) = #macro(NW_HUMAN)
							and (-1,-2)~occ < 1			% no other right-moving agent vying for the same cell
							and (0,-2)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (-2,-2)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (0,-1)~occ < 1			% no other up-moving agent vying for the same cell
							and (-2,-1)~occ < 1			% no other down-moving agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 1; } 100  	
							{ (0,0)~occ < 1
							and (1,1)~occ >= 1 and (1,1)~occ < 2
							and #macro(MIN_RCVR_NW_HUMAN) != (1,2)~comfort_human
							and #macro(MIN_RCVR_NW_HUMAN) != (0,2)~comfort_human
							and #macro(MIN_RCVR_NW_HUMAN) != (2,2)~comfort_human
							and #macro(MIN_RCVR_NW_HUMAN) != (0,1)~comfort_human
							and #macro(MIN_RCVR_NW_HUMAN) != (2,1)~comfort_human
							and #macro(MIN_RCVR_NW_HUMAN) = (0,0)~comfort_human
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1			% no other down-moving agent vying for the same cell
							}		
							
% Monster Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100 	
							{ (0,0)~occ >= 2 and (0,0)~occ < 3
							and (-1,-1)~occ < 1		% Northwest cell is unoccupied
							and #macro(MIN_NBR_MONS) != #macro(E_MONS)
							and #macro(MIN_NBR_MONS) != #macro(NE_MONS)
							and #macro(MIN_NBR_MONS) != #macro(SE_MONS)
							and #macro(MIN_NBR_MONS) != #macro(N_MONS)
							and #macro(MIN_NBR_MONS) != #macro(S_MONS)
							and #macro(MIN_NBR_MONS) = #macro(NW_MONS)
							and (-1,-2)~occ < 1			% no other right-moving agent vying for the same cell
							and (0,-2)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (-2,-2)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (0,-1)~occ < 1			% no other up-moving agent vying for the same cell
							and (-2,-1)~occ < 1			% no other down-moving agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 2; } 100 	
							{ (0,0)~occ < 1
							and (1,1)~occ >= 2 and (1,1)~occ < 3
							and #macro(MIN_RCVR_NW_MONS) != (1,2)~comfort_mons
							and #macro(MIN_RCVR_NW_MONS) != (0,2)~comfort_mons
							and #macro(MIN_RCVR_NW_MONS) != (2,2)~comfort_mons
							and #macro(MIN_RCVR_NW_MONS) != (0,1)~comfort_mons
							and #macro(MIN_RCVR_NW_MONS) != (2,1)~comfort_mons
							and #macro(MIN_RCVR_NW_MONS) = (0,0)~comfort_mons
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1			% no other down-moving agent vying for the same cell
							}
							
% Alien Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100	
							{ (0,0)~occ >= 3 and (0,0)~occ < 4
							and (-1,-1)~occ < 1		% Northwest cell is unoccupied
							and #macro(MIN_NBR_ALIEN) != #macro(E_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(NE_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(SE_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(N_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(S_ALIEN)
							and #macro(MIN_NBR_ALIEN) = #macro(NW_ALIEN)
							and (-1,-2)~occ < 1			% no other right-moving agent vying for the same cell
							and (0,-2)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (-2,-2)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (0,-1)~occ < 1			% no other up-moving agent vying for the same cell
							and (-2,-1)~occ < 1			% no other down-moving agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 3; } 100 	
							{ (0,0)~occ < 1
							and (1,1)~occ >= 3 and (1,1)~occ < 4
							and #macro(MIN_RCVR_NW_ALIEN) != (1,2)~comfort_alien
							and #macro(MIN_RCVR_NW_ALIEN) != (0,2)~comfort_alien
							and #macro(MIN_RCVR_NW_ALIEN) != (2,2)~comfort_alien
							and #macro(MIN_RCVR_NW_ALIEN) != (0,1)~comfort_alien
							and #macro(MIN_RCVR_NW_ALIEN) != (2,1)~comfort_alien
							and #macro(MIN_RCVR_NW_ALIEN) = (0,0)~comfort_alien
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1			% no other down-moving agent vying for the same cell
							}
							
%***************************************RULE 7******************************************%
%*********** Move to the SOUTHWEST(SW) comfortable cell ***********%
% Human Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (1,-1)~occ < 1		% Northwest cell is unoccupied
							and #macro(MIN_NBR_HUMAN) != #macro(E_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(NE_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(SE_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(N_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(S_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(NW_HUMAN)
							and #macro(MIN_NBR_HUMAN) = #macro(SW_HUMAN)
							and (1,-2)~occ < 1			% no other right-moving agent vying for the same cell
							and (0,-2)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (2,-2)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (0,-1)~occ < 1			% no other up-moving agent vying for the same cell
							and (2,-1)~occ < 1			% no other down-moving agent vying for the same cell
							and (2,0)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 1; } 100	
							{ (0,0)~occ < 1
							and (-1,1)~occ >= 1 and (-1,1)~occ < 2
							and #macro(MIN_RCVR_SW_HUMAN) != (-1,2)~comfort_human
							and #macro(MIN_RCVR_SW_HUMAN) != (-2,2)~comfort_human
							and #macro(MIN_RCVR_SW_HUMAN) != (0,2)~comfort_human
							and #macro(MIN_RCVR_SW_HUMAN) != (-2,1)~comfort_human
							and #macro(MIN_RCVR_SW_HUMAN) != (0,1)~comfort_human
							and #macro(MIN_RCVR_SW_HUMAN) != (-2,0)~comfort_human
							and #macro(MIN_RCVR_SW_HUMAN) = (0,0)~comfort_human
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving agent diagonally(up) vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving agent diagonally(down) vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1			% no other down-moving agent vying for the same cell
							and (1,1)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							}	
							
% Monster Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100 	
							{ (0,0)~occ >= 2 and (0,0)~occ < 3
							and (1,-1)~occ < 1		% Northwest cell is unoccupied
							and #macro(MIN_NBR_MONS) != #macro(E_MONS)
							and #macro(MIN_NBR_MONS) != #macro(NE_MONS)
							and #macro(MIN_NBR_MONS) != #macro(SE_MONS)
							and #macro(MIN_NBR_MONS) != #macro(N_MONS)
							and #macro(MIN_NBR_MONS) != #macro(S_MONS)
							and #macro(MIN_NBR_MONS) != #macro(NW_MONS)
							and #macro(MIN_NBR_MONS) = #macro(SW_MONS)
							and (1,-2)~occ < 1			% no other right-moving agent vying for the same cell
							and (0,-2)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (2,-2)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (0,-1)~occ < 1			% no other up-moving agent vying for the same cell
							and (2,-1)~occ < 1			% no other down-moving agent vying for the same cell
							and (2,0)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 2; } 100 	
							{ (0,0)~occ < 1
							and (-1,1)~occ >= 2 and (-1,1)~occ < 3
							and #macro(MIN_RCVR_SW_MONS) != (-1,2)~comfort_mons
							and #macro(MIN_RCVR_SW_MONS) != (-2,2)~comfort_mons
							and #macro(MIN_RCVR_SW_MONS) != (0,2)~comfort_mons
							and #macro(MIN_RCVR_SW_MONS) != (-2,1)~comfort_mons
							and #macro(MIN_RCVR_SW_MONS) != (0,1)~comfort_mons
							and #macro(MIN_RCVR_SW_MONS) != (-2,0)~comfort_mons
							and #macro(MIN_RCVR_SW_MONS) = (0,0)~comfort_mons
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving agent diagonally(up) vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving agent diagonally(down) vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1			% no other down-moving agent vying for the same cell
							and (1,1)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							}	
							
% Alien Agent
rule : { ~occ:= $cell; 
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100	
							{ (0,0)~occ >= 3 and (0,0)~occ < 4
							and (1,-1)~occ < 1		% Northwest cell is unoccupied
							and #macro(MIN_NBR_ALIEN) != #macro(E_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(NE_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(SE_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(N_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(S_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(NW_ALIEN)
							and #macro(MIN_NBR_ALIEN) = #macro(SW_ALIEN)
							and (1,-2)~occ < 1			% no other right-moving agent vying for the same cell
							and (0,-2)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (2,-2)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (0,-1)~occ < 1			% no other up-moving agent vying for the same cell
							and (2,-1)~occ < 1			% no other down-moving agent vying for the same cell
							and (2,0)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 3; } 100	
							{ (0,0)~occ < 1
							and (-1,1)~occ >= 3 and (-1,1)~occ < 4
							and #macro(MIN_RCVR_SW_ALIEN) != (-1,2)~comfort_alien
							and #macro(MIN_RCVR_SW_ALIEN) != (-2,2)~comfort_alien
							and #macro(MIN_RCVR_SW_ALIEN) != (0,2)~comfort_alien
							and #macro(MIN_RCVR_SW_ALIEN) != (-2,1)~comfort_alien
							and #macro(MIN_RCVR_SW_ALIEN) != (0,1)~comfort_alien
							and #macro(MIN_RCVR_SW_ALIEN) != (-2,0)~comfort_alien
							and #macro(MIN_RCVR_SW_ALIEN) = (0,0)~comfort_alien
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving agent diagonally(up) vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving agent diagonally(down) vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1			% no other down-moving agent vying for the same cell
							and (1,1)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							}	
							
%***************************************RULE 8******************************************%
%*********** Move to the WEST(W) comfortable cell ***********%
% Human Agent
rule : { ~occ:= $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100 	
							{ (0,0)~occ >= 1 and (0,0)~occ < 2
							and (0,-1)~occ < 1			% West cell is unoccupied
							and #macro(MIN_NBR_HUMAN) != #macro(E_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(NE_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(SE_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(N_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(S_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(NW_HUMAN)
							and #macro(MIN_NBR_HUMAN) != #macro(SW_HUMAN)
							and #macro(MIN_NBR_HUMAN) = #macro(W_HUMAN)
							and (0,-2)~occ < 1			% no other right-moving agent vying for the same cell
							and (1,-2)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (-1,2)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (1,-1)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other down-moving agent vying for the same cell
							and (1,0)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							and (-1,0)~occ < 1			% no other left-moving (diagonally down) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 1; } 100	
							{ (0,0)~occ < 1
							and (0,1)~occ >= 1 and (0,1)~occ < 2
							and #macro(MIN_RCVR_W_HUMAN) != (0,2)~comfort_human
							and #macro(MIN_RCVR_W_HUMAN) != (-1,2)~comfort_human
							and #macro(MIN_RCVR_W_HUMAN) != (1,2)~comfort_human
							and #macro(MIN_RCVR_W_HUMAN) != (-1,1)~comfort_human
							and #macro(MIN_RCVR_W_HUMAN) != (1,1)~comfort_human
							and #macro(MIN_RCVR_W_HUMAN) != (-1,0)~comfort_human
							and #macro(MIN_RCVR_W_HUMAN) != (1,0)~comfort_human
							and #macro(MIN_RCVR_W_HUMAN) = (0,0)~comfort_human
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving agent diagonally(up) vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving agent diagonally(down) vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1			% no other down-moving agent vying for the same cell
							and (1,1)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							and (-1,1)~occ < 1			% no other left-moving (diagonally down) agent vying for the same cell
							}	
							
% Monster Agent
rule : { ~occ:= $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100  	
							{ (0,0)~occ >= 2 and (0,0)~occ < 3
							and (0,-1)~occ < 1			% West cell is unoccupied
							and #macro(MIN_NBR_MONS) != #macro(E_MONS)
							and #macro(MIN_NBR_MONS) != #macro(NE_MONS)
							and #macro(MIN_NBR_MONS) != #macro(SE_MONS)
							and #macro(MIN_NBR_MONS) != #macro(N_MONS)
							and #macro(MIN_NBR_MONS) != #macro(S_MONS)
							and #macro(MIN_NBR_MONS) != #macro(NW_MONS)
							and #macro(MIN_NBR_MONS) != #macro(SW_MONS)
							and #macro(MIN_NBR_MONS) = #macro(W_MONS)
							and (0,-2)~occ < 1			% no other right-moving agent vying for the same cell
							and (1,-2)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (-1,2)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (1,-1)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other down-moving agent vying for the same cell
							and (1,0)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							and (-1,0)~occ < 1			% no other left-moving (diagonally down) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 2; } 100	
							{ (0,0)~occ < 1
							and (0,1)~occ >= 2 and (0,1)~occ < 3
							and #macro(MIN_RCVR_W_MONS) != (0,2)~comfort_mons
							and #macro(MIN_RCVR_W_MONS) != (-1,2)~comfort_mons
							and #macro(MIN_RCVR_W_MONS) != (1,2)~comfort_mons
							and #macro(MIN_RCVR_W_MONS) != (-1,1)~comfort_mons
							and #macro(MIN_RCVR_W_MONS) != (1,1)~comfort_mons
							and #macro(MIN_RCVR_W_MONS) != (-1,0)~comfort_mons
							and #macro(MIN_RCVR_W_MONS) != (1,0)~comfort_mons
							and #macro(MIN_RCVR_W_MONS) = (0,0)~comfort_mons
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving agent diagonally(up) vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving agent diagonally(down) vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1			% no other down-moving agent vying for the same cell
							and (1,1)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							and (-1,1)~occ < 1			% no other left-moving (diagonally down) agent vying for the same cell
							}	
							
% Alien Agent
rule : { ~occ:= $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 0; } 100	
							{ (0,0)~occ >= 3 and (0,0)~occ < 4
							and (0,-1)~occ < 1			% West cell is unoccupied
							and #macro(MIN_NBR_ALIEN) != #macro(E_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(NE_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(SE_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(N_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(S_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(NW_ALIEN)
							and #macro(MIN_NBR_ALIEN) != #macro(SW_ALIEN)
							and #macro(MIN_NBR_ALIEN) = #macro(W_ALIEN)
							and (0,-2)~occ < 1			% no other right-moving agent vying for the same cell
							and (1,-2)~occ < 1			% no other right-moving (diagonally up) agent vying for the same cell
							and (-1,2)~occ < 1			% no other right-moving (diagonally down) agent vying for the same cell
							and (1,-1)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other down-moving agent vying for the same cell
							and (1,0)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							and (-1,0)~occ < 1			% no other left-moving (diagonally down) agent vying for the same cell
							}

rule : { ~occ:= $agent + $cell;
		~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); } { $agent:= 3; } 100	
							{ (0,0)~occ < 1
							and (0,1)~occ >= 3 and (0,1)~occ < 4
							and #macro(MIN_RCVR_W_ALIEN) != (0,2)~comfort_alien
							and #macro(MIN_RCVR_W_ALIEN) != (-1,2)~comfort_alien
							and #macro(MIN_RCVR_W_ALIEN) != (1,2)~comfort_alien
							and #macro(MIN_RCVR_W_ALIEN) != (-1,1)~comfort_alien
							and #macro(MIN_RCVR_W_ALIEN) != (1,1)~comfort_alien
							and #macro(MIN_RCVR_W_ALIEN) != (-1,0)~comfort_alien
							and #macro(MIN_RCVR_W_ALIEN) != (1,0)~comfort_alien
							and #macro(MIN_RCVR_W_ALIEN) = (0,0)~comfort_alien
							and (0,-1)~occ < 1			% no other right-moving agent vying for the same cell
							and (-1,-1)~occ < 1			% no other right-moving agent diagonally(up) vying for the same cell
							and (1,-1)~occ < 1			% no other right-moving agent diagonally(down) vying for the same cell
							and (1,0)~occ < 1			% no other up-moving agent vying for the same cell
							and (-1,0)~occ < 1			% no other down-moving agent vying for the same cell
							and (1,1)~occ < 1			% no other left-moving (diagonally up) agent vying for the same cell
							and (-1,1)~occ < 1			% no other left-moving (diagonally down) agent vying for the same cell
							}	

%*******************DEFAULT RULE*******************%
% Do not move
rule : { ~comfort_human:= #macro(COMFORT_LV_HUMAN);
		~comfort_mons:= #macro(COMFORT_LV_MONS);
		~comfort_alien:= #macro(COMFORT_LV_ALIEN);
		~desire:=  #macro(DESIRABILITY); 
		~occ:= $agent + $cell; } 100 { t }