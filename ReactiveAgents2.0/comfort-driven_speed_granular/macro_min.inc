% Contains functions to calculate the minimum of all neighbors

%******************************************* For Human Agents ************************************************
% Minimum of all surrounding neighbors of active human agent
#BeginMacro(MIN_NBR_HUMAN)
min( min( min( min( min( min( min( min((-1,1)~comfort_human,(0,1)~comfort_human), (1,1)~comfort_human ), (-1,0)~comfort_human ), 
(1,0)~comfort_human ), (-1,-1)~comfort_human ), (1,-1)~comfort_human ), (0,-1)~comfort_human ), 0.99)
#EndMacro

% Receiver is the East Cell: Minimum of all the surrounding cell of the incoming agent
#BeginMacro(MIN_RCVR_E_HUMAN)
min( min( min( min( min( min( min( min((0,0)~comfort_human,(-1,0)~comfort_human), (-1,-1)~comfort_human ), (-1,-2)~comfort_human ), 
(1,0)~comfort_human ), (1,-1)~comfort_human ), (1,-2)~comfort_human ), (0,-2)~comfort_human ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_NE_HUMAN)
min( min( min( min( min( min( min( min((0,0)~comfort_human,(0,-1)~comfort_human), (0,-2)~comfort_human ), (1,0)~comfort_human ), 
(2,0)~comfort_human ), (2,-1)~comfort_human ), (2,-2)~comfort_human ), (1,-2)~comfort_human ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SE_HUMAN)
min( min( min( min( min( min( min( min((0,0)~comfort_human,(0,-1)~comfort_human), (0,-2)~comfort_human ), (-1,0)~comfort_human ), 
(-2,0)~comfort_human ), (-2,-1)~comfort_human ), (-2,-2)~comfort_human ), (-1,-2)~comfort_human ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SE_HUMAN)
min( min( min( min( min( min( min( min((0,0)~comfort_human,(0,-1)~comfort_human), (0,-2)~comfort_human ), (-1,0)~comfort_human ), 
(-2,0)~comfort_human ), (-2,-1)~comfort_human ), (-2,-2)~comfort_human ), (-1,-2)~comfort_human ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_N_HUMAN)
min( min( min( min( min( min( min( min((0,0)~comfort_human,(0,-1)~comfort_human), (0,1)~comfort_human ), (1,-1)~comfort_human ), 
(2,-1)~comfort_human ), (2,0)~comfort_human ), (1,1)~comfort_human ), (2,1)~comfort_human ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_S_HUMAN)
min( min( min( min( min( min( min( min((0,0)~comfort_human,(0,-1)~comfort_human), (0,1)~comfort_human ), (-1,-1)~comfort_human ), 
(-2,-1)~comfort_human ), (-2,0)~comfort_human ), (-1,1)~comfort_human ), (-2,1)~comfort_human ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_NW_HUMAN)
min( min( min( min( min( min( min( min((0,0)~comfort_human,(0,1)~comfort_human), (0,2)~comfort_human ), (1,0)~comfort_human ), 
(2,0)~comfort_human ), (1,2)~comfort_human ), (2,1)~comfort_human ), (2,2)~comfort_human ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SW_HUMAN)
min( min( min( min( min( min( min( min((0,0)~comfort_human,(0,1)~comfort_human), (0,2)~comfort_human ), (-1,0)~comfort_human ), 
(-2,0)~comfort_human ), (-1,2)~comfort_human ), (-2,1)~comfort_human ), (-2,2)~comfort_human ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_W_HUMAN)
min( min( min( min( min( min( min( min((0,0)~comfort_human,(0,2)~comfort_human), (-1,0)~comfort_human ), (-1,1)~comfort_human ), 
(-1,2)~comfort_human ), (1,0)~comfort_human ), (1,1)~comfort_human ), (1,2)~comfort_human ), 0.99)
#EndMacro
%***************************************************************************************************************


%******************************************* For Monster Agents ************************************************
% Minimum of all surrounding neighbors of active monster agent
#BeginMacro(MIN_NBR_MONS)
min( min( min( min( min( min( min( min((-1,1)~comfort_mons,(0,1)~comfort_mons), (1,1)~comfort_mons ), (-1,0)~comfort_mons ), 
(1,0)~comfort_mons ), (-1,-1)~comfort_mons ), (1,-1)~comfort_mons ), (0,-1)~comfort_mons ), 0.99)
#EndMacro

% Receiver is the East Cell: Minimum of all the surrounding cell of the incoming agent
#BeginMacro(MIN_RCVR_E_MONS)
min( min( min( min( min( min( min( min((0,0)~comfort_mons,(-1,0)~comfort_mons), (-1,-1)~comfort_mons ), (-1,-2)~comfort_mons ), 
(1,0)~comfort_mons ), (1,-1)~comfort_mons ), (1,-2)~comfort_mons ), (0,-2)~comfort_mons ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_NE_MONS)
min( min( min( min( min( min( min( min((0,0)~comfort_mons,(0,-1)~comfort_mons), (0,-2)~comfort_mons ), (1,0)~comfort_mons ), 
(2,0)~comfort_mons ), (2,-1)~comfort_mons ), (2,-2)~comfort_mons ), (1,-2)~comfort_mons ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SE_MONS)
min( min( min( min( min( min( min( min((0,0)~comfort_mons,(0,-1)~comfort_mons), (0,-2)~comfort_mons ), (-1,0)~comfort_mons ), 
(-2,0)~comfort_mons ), (-2,-1)~comfort_mons ), (-2,-2)~comfort_mons ), (-1,-2)~comfort_mons ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SE_MONS)
min( min( min( min( min( min( min( min((0,0)~comfort_mons,(0,-1)~comfort_mons), (0,-2)~comfort_mons ), (-1,0)~comfort_mons ), 
(-2,0)~comfort_mons ), (-2,-1)~comfort_mons ), (-2,-2)~comfort_mons ), (-1,-2)~comfort_mons ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_N_MONS)
min( min( min( min( min( min( min( min((0,0)~comfort_mons,(0,-1)~comfort_mons), (0,1)~comfort_mons ), (1,-1)~comfort_mons ), 
(2,-1)~comfort_mons ), (2,0)~comfort_mons ), (1,1)~comfort_mons ), (2,1)~comfort_mons ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_S_MONS)
min( min( min( min( min( min( min( min((0,0)~comfort_mons,(0,-1)~comfort_mons), (0,1)~comfort_mons ), (-1,-1)~comfort_mons ), 
(-2,-1)~comfort_mons ), (-2,0)~comfort_mons ), (-1,1)~comfort_mons ), (-2,1)~comfort_mons ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_NW_MONS)
min( min( min( min( min( min( min( min((0,0)~comfort_mons,(0,1)~comfort_mons), (0,2)~comfort_mons ), (1,0)~comfort_mons ), 
(2,0)~comfort_mons ), (1,2)~comfort_mons ), (2,1)~comfort_mons ), (2,2)~comfort_mons ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SW_MONS)
min( min( min( min( min( min( min( min((0,0)~comfort_mons,(0,1)~comfort_mons), (0,2)~comfort_mons ), (-1,0)~comfort_mons ), 
(-2,0)~comfort_mons ), (-1,2)~comfort_mons ), (-2,1)~comfort_mons ), (-2,2)~comfort_mons ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_W_MONS)
min( min( min( min( min( min( min( min((0,0)~comfort_mons,(0,2)~comfort_mons), (-1,0)~comfort_mons ), (-1,1)~comfort_mons ), 
(-1,2)~comfort_mons ), (1,0)~comfort_mons ), (1,1)~comfort_mons ), (1,2)~comfort_mons ), 0.99)
#EndMacro
%***************************************************************************************************************


%******************************************* For Alien Agents **************************************************
% Minimum of all surrounding neighbors of active alien agent
#BeginMacro(MIN_NBR_ALIEN)
min( min( min( min( min( min( min( min((-1,1)~comfort_alien,(0,1)~comfort_alien), (1,1)~comfort_alien ), (-1,0)~comfort_alien ), 
(1,0)~comfort_alien ), (-1,-1)~comfort_alien ), (1,-1)~comfort_alien ), (0,-1)~comfort_alien ), 0.99)
#EndMacro

% Receiver is the East Cell: Minimum of all the surrounding cell of the incoming agent
#BeginMacro(MIN_RCVR_E_ALIEN)
min( min( min( min( min( min( min( min((0,0)~comfort_alien,(-1,0)~comfort_alien), (-1,-1)~comfort_alien ), (-1,-2)~comfort_alien ), 
(1,0)~comfort_alien ), (1,-1)~comfort_alien ), (1,-2)~comfort_alien ), (0,-2)~comfort_alien ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_NE_ALIEN)
min( min( min( min( min( min( min( min((0,0)~comfort_alien,(0,-1)~comfort_alien), (0,-2)~comfort_alien ), (1,0)~comfort_alien ), 
(2,0)~comfort_alien ), (2,-1)~comfort_alien ), (2,-2)~comfort_alien ), (1,-2)~comfort_alien ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SE_ALIEN)
min( min( min( min( min( min( min( min((0,0)~comfort_alien,(0,-1)~comfort_alien), (0,-2)~comfort_alien ), (-1,0)~comfort_alien ), 
(-2,0)~comfort_alien ), (-2,-1)~comfort_alien ), (-2,-2)~comfort_alien ), (-1,-2)~comfort_alien ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SE_ALIEN)
min( min( min( min( min( min( min( min((0,0)~comfort_alien,(0,-1)~comfort_alien), (0,-2)~comfort_alien ), (-1,0)~comfort_alien ), 
(-2,0)~comfort_alien ), (-2,-1)~comfort_alien ), (-2,-2)~comfort_alien ), (-1,-2)~comfort_alien ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_N_ALIEN)
min( min( min( min( min( min( min( min((0,0)~comfort_alien,(0,-1)~comfort_alien), (0,1)~comfort_alien ), (1,-1)~comfort_alien ), 
(2,-1)~comfort_alien ), (2,0)~comfort_alien ), (1,1)~comfort_alien ), (2,1)~comfort_alien ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_S_ALIEN)
min( min( min( min( min( min( min( min((0,0)~comfort_alien,(0,-1)~comfort_alien), (0,1)~comfort_alien ), (-1,-1)~comfort_alien ), 
(-2,-1)~comfort_alien ), (-2,0)~comfort_alien ), (-1,1)~comfort_alien ), (-2,1)~comfort_alien ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_NW_ALIEN)
min( min( min( min( min( min( min( min((0,0)~comfort_alien,(0,1)~comfort_alien), (0,2)~comfort_alien ), (1,0)~comfort_alien ), 
(2,0)~comfort_alien ), (1,2)~comfort_alien ), (2,1)~comfort_alien ), (2,2)~comfort_alien ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SW_ALIEN)
min( min( min( min( min( min( min( min((0,0)~comfort_alien,(0,1)~comfort_alien), (0,2)~comfort_alien ), (-1,0)~comfort_alien ), 
(-2,0)~comfort_alien ), (-1,2)~comfort_alien ), (-2,1)~comfort_alien ), (-2,2)~comfort_alien ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_W_ALIEN)
min( min( min( min( min( min( min( min((0,0)~comfort_alien,(0,2)~comfort_alien), (-1,0)~comfort_alien ), (-1,1)~comfort_alien ), 
(-1,2)~comfort_alien ), (1,0)~comfort_alien ), (1,1)~comfort_alien ), (1,2)~comfort_alien ), 0.99)
#EndMacro
%***************************************************************************************************************