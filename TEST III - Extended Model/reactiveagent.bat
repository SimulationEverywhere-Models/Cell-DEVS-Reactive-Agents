simu  -mreactiveagent.ma  -t00:00:10:000 -lreactiveagent.log
pause
drawlog  -mreactiveagent.ma  -cReactiveAgents  -lreactiveagent.log > reactiveagent.drw
pause
Graflog -v -e10  -freactiveagent.drw  -creactiveagent.col
pause

