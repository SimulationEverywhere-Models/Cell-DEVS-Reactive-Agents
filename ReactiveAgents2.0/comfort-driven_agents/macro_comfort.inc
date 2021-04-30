% Contains macros to calculate the comfort level of certain agents
% the weight values can be altered to observe different agent behavior

% ***************************** The Comfort Function ******************************/
% Overall comfort level for a human agent in a cell
#BeginMacro(COMFORT_LEVEL)
( $heat*0.0033 + $pressure*0.0033 + $wetness*0.0033 )
#EndMacro
% *********************************************************************************/