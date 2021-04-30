## Instructions:
* Please move to specific model folders and follow the instructions found there.
* Folders may not appear in the same order as the project report.
* Use a Linux environment or the Ubuntu app in Windows


## Visualizing Simulations:
* Logfiles (.log01) and pallete files (.json) found in the each results folder
  can be uploaded to the CD-WebViewer-2.0 tool using the url
	"https://simulationeverywhere.github.io/CD-WebViewer-2.0/index.html"
* This will allow you to visualize the simulations in more detail.

## Recordings, log files, and input files
* Each experiment has its own folder inside the corresponding results folders
* Each experiment contains a recording of the simulations, the .log01 file produced,
  and occasionally an input file (.val) in case the default input file provided 
  needs to be replaced for that experiment


#### Anytime you're confused or need detailed information about each experiment
* Please see the project report.


## SPECIAL
* For all models, change weights for elements in the "macro_comfort.inc" file 
  according to table II to model different agent types (Humans, monsters, aliens, etc.)
* For the desire-driven model, 
	* change weights of desire and comfort preference of agents in the "macro_weights.inc" 
	  file to model different levels of desire-driven agents (table IV)
	* replace the "SPREAD_DESIRE" macro contents with the theree macros provided in the 
	  macro_desirability.inc" file to see varying spreads of desire.