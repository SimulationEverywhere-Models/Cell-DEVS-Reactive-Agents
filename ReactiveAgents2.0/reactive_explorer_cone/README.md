To run simulations:
-------------------
Step 1: Navigate to this folder
Step 2: Use a Linux environment or the Ubuntu app in Windows

step 3: run using the command: (without the quotes)
			"../cd++ -mreactiveagent.ma -t00:00:10:000 -lresults/reactiveagent.log"


To view results:
----------------
Step 1: Navigate to the results directory inside this directory
Step 2: Open CD-WebViewer-2.0 using the url 
			"https://simulationeverywhere.github.io/CD-WebViewer-2.0/index.html"
Step 3: Upload the "reactiveagent.log01" and the "ra_explore_grey.json" 
		files in the results folder or drag and drop them to visualize the simulations


To perform different experiments:
---------------------------------
Step 1: Copy the the .val files found in the results/expXX folder to the model folder 
		to perform the XXth experiment.
Step 2: change weights for elements in the "macro_comfort.inc" file according to table II
		to model different agent types (Human, monster, alien, etc.)
Step 3: Run the simulation!