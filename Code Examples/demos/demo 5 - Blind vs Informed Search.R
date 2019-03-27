#---------------------------------------------------------------------------
# Blind Search vs Informed Search
# Intelligent Systems - University of Deusto
# Enrique Onieva Caracuel
#---------------------------------------------------------------------------
# Preliminaries: Cleaning, importing...
rm(list=ls())
cat("\014")
graphics.off()
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
dir()

# Here, you can see the Breadth First Search Procedure
source("../methods/Iterative Deepening Search.R")
source("../methods/Greedy Best First Search.R")

# And here, there are additional (needed) functions
source("../methods/Expand Node.R")
source("../methods/Analyze Results.R")
source("../methods/Plot Results.R")

source("../problems/8Puzzle.R")

# Let's check different states
state0 = initialize.problem(3,3,c(0,1,2,3,4,5,6,7,8))$state.initial
to.string(state0)
state1 = initialize.problem(3,3,c(1,2,5,3,0,4,6,7,8))$state.initial
to.string(state1)
state2 = initialize.problem(3,3,c(1,2,5,3,4,8,0,6,7))$state.initial
to.string(state2)
state3 = initialize.problem(3,3,c(1,2,3,0,4,5,6,7,8))$state.initial
to.string(state3)

problem = initialize.problem(3,3)
# Defining an heuristic... Number of misplaced tiles
state1!=problem$state.final
sum(state1!=problem$state.final)

# Put it inside a function
misplaced = function(state,problem) {
  return(sum(state!=problem$state.final))
}

misplaced(state0,problem)
misplaced(state1,problem)
misplaced(state2,problem)
misplaced(state3,problem)

# Override the function in the file
get.evaluation = misplaced

# Comparison of the method versus Iterative Deepening Search on a instance of the problem
problem = initialize.problem(3,3,c(1,2,5,3,4,8,0,6,7)) 
gbfs    = Greedy.Best.First.Search(problem,2500)
ids     = Iterative.Deepening.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 100)
analyze.results(list(gbfs,ids), problem)