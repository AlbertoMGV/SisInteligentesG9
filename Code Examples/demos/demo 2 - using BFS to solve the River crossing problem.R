#---------------------------------------------------------------------------
# River crossing puzzle + Breath First Search Implementation
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

# Here we have the set of functions that define a problem
# (Let's take a look to the functions)
source("../problems/River_crossing_puzzle.R")

# Here, you can see the Breadth First Search Procedure
source("../methods/Breadth First Search.R")

# And here, there are additional (needed) functions
source("../methods/Expand Node.R")
source("../methods/Analyze Results.R")
source("../methods/Plot Results.R")

# Execution of the method
problem = initialize.problem()
res = Breadth.First.Search(problem)   
res$state.final
analyze.results(list(res),problem) 

# All the methods have some "additional" parameters
res = Breadth.First.Search(problem, count.limit = 50)   
res$state.final
analyze.results(list(res),problem) 

# All the methods have some "additional" parameters
res = Breadth.First.Search(problem, count.print = 10)   
res$state.final
analyze.results(list(res),problem) 

# All the methods have some "additional" parameters
res = Breadth.First.Search(problem, trace = T, count.limit = 10)   
res$state.final
analyze.results(list(res),problem) 

# All the methods have some "additional" parameters
res = Breadth.First.Search(problem, graph.search = T)   
res$state.final
analyze.results(list(res),problem) 


# Let's see the difference between using and not using graph.search
res1 = Breadth.First.Search(problem, graph.search = T)   
res2 = Breadth.First.Search(problem, graph.search = F)   
analyze.results(list(res1,res2),problem)