% ***************************** Desirability Functions *****************************/
% How desire spreads left through the terrain
#BeginMacro(SPREAD_DESIRE)
if( $desirability!=0, $desirability, 0.7*max( max( max((0,1)~desire,(0,-1)~desire ), (1,0)~desire ), (-1,0)~desire ) )
#EndMacro

% Overall desirability of a cell for an agent
#BeginMacro(DESIRABILITY)
min( (1 - $desirability), 0.99 )
#EndMacro
% *********************************************************************************/


%****************************** Other Possible Spreads ***************************/
% How desire spreads left through the terrain
#BeginMacro(SPREAD_DESIRE_STRAIGHT)
if( $desirability!=0, $desirability, 0.7*(0,1)~desire )
#EndMacro

% Spread desire using the von_neumann neighborhood
#BeginMacro(SPREAD_DESIRE_CROSS)
if( $desirability!=0, $desirability, 0.7*max( max( max((0,1)~desire,(0,-1)~desire ), (1,0)~desire ), (-1,0)~desire ) )
#EndMacro

% Spread desire using the moore neighborhood
#BeginMacro(SPREAD_DESIRE_BOX)
if( $desirability!=0, $desirability, 0.7*max( max( max( max( max( max( max((-1,1)~desire,(0,1)~desire ), (1,1)~desire ), (-1,0)~desire ), 
(1,0)~desire ), (-1,-1)~desire ), (1,-1)~desire ), (0,-1)~desire ))
#EndMacro

