% ***************************** Explore Function *****************************/
% Single-cell exploration capability
#BeginMacro(EXPLORE_CELL)
$cell
#EndMacro
% ****************************************************************************/

% Area exploration capability
#BeginMacro(EXPLORE_AREA)
$cell; 
(0,1)~occ:= (0,1)~cell; 
(-1,1)~occ:= (-1,1)~cell; 
(1,1)~occ:= (1,1)~cell
#EndMacro
