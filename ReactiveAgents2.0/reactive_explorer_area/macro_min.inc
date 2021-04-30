% Contains functions to calculate the minimum of all neighbors


% Minimum of all surrounding neighbors of active agent
#BeginMacro(MIN_NBR)
min( min( min( min( min( min( min( min((-1,1)~comfort,(0,1)~comfort), (1,1)~comfort ), (-1,0)~comfort ), 
(1,0)~comfort ), (-1,-1)~comfort ), (1,-1)~comfort ), (0,-1)~comfort ), 0.99)
#EndMacro

% Receiver is the East Cell: Minimum of all the surrounding cell of the incoming agent
#BeginMacro(MIN_RCVR_E)
min( min( min( min( min( min( min( min((0,0)~comfort,(-1,0)~comfort), (-1,-1)~comfort ), (-1,-2)~comfort ), 
(1,0)~comfort ), (1,-1)~comfort ), (1,-2)~comfort ), (0,-2)~comfort ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_NE)
min( min( min( min( min( min( min( min((0,0)~comfort,(0,-1)~comfort), (0,-2)~comfort ), (1,0)~comfort ), 
(2,0)~comfort ), (2,-1)~comfort ), (2,-2)~comfort ), (1,-2)~comfort ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SE)
min( min( min( min( min( min( min( min((0,0)~comfort,(0,-1)~comfort), (0,-2)~comfort ), (-1,0)~comfort ), 
(-2,0)~comfort ), (-2,-1)~comfort ), (-2,-2)~comfort ), (-1,-2)~comfort ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SE)
min( min( min( min( min( min( min( min((0,0)~comfort,(0,-1)~comfort), (0,-2)~comfort ), (-1,0)~comfort ), 
(-2,0)~comfort ), (-2,-1)~comfort ), (-2,-2)~comfort ), (-1,-2)~comfort ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_N)
min( min( min( min( min( min( min( min((0,0)~comfort,(0,-1)~comfort), (0,1)~comfort ), (1,-1)~comfort ), 
(2,-1)~comfort ), (2,0)~comfort ), (1,1)~comfort ), (2,1)~comfort ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_S)
min( min( min( min( min( min( min( min((0,0)~comfort,(0,-1)~comfort), (0,1)~comfort ), (-1,-1)~comfort ), 
(-2,-1)~comfort ), (-2,0)~comfort ), (-1,1)~comfort ), (-2,1)~comfort ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_NW)
min( min( min( min( min( min( min( min((0,0)~comfort,(0,1)~comfort), (0,2)~comfort ), (1,0)~comfort ), 
(2,0)~comfort ), (1,2)~comfort ), (2,1)~comfort ), (2,2)~comfort ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_SW)
min( min( min( min( min( min( min( min((0,0)~comfort,(0,1)~comfort), (0,2)~comfort ), (-1,0)~comfort ), 
(-2,0)~comfort ), (-1,2)~comfort ), (-2,1)~comfort ), (-2,2)~comfort ), 0.99)
#EndMacro

#BeginMacro(MIN_RCVR_W)
min( min( min( min( min( min( min( min((0,0)~comfort,(0,2)~comfort), (-1,0)~comfort ), (-1,1)~comfort ), 
(-1,2)~comfort ), (1,0)~comfort ), (1,1)~comfort ), (1,2)~comfort ), 0.99)
#EndMacro