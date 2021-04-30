% ***************************** The Comfort Function ******************************/
% Overall comfort level for a human agent in a cell
#BeginMacro(COMFORT_LV_HUMAN)
( $heat*0.007 + $pressure*0.002 + $wetness*0.001 )
#EndMacro

% Overall comfort level for a fiery monster agent in a cell
#BeginMacro(COMFORT_LV_MONS)
( $heat*0.0 + $pressure*0.001 + $wetness*0.009 )
#EndMacro

% Overall comfort level for a vapor alien agent in a cell
#BeginMacro(COMFORT_LV_ALIEN)
( $heat*0.0 + $pressure*0.010 + $wetness*0.0 )
#EndMacro
% *********************************************************************************/