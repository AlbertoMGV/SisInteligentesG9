#---------------------------------------------------------------------------
# Blind search over different problems
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
source("../methods/Breadth First Search.R")
source("../methods/Depth First Search.R")
source("../methods/Depth Limited Search.R")
source("../methods/Iterative Deepening Search.R")
source("../methods/Uniform Cost Search.R")

# And here, there are additional (needed) functions
source("../methods/Expand Node.R")
source("../methods/Analyze Results.R")
source("../methods/Plot Results.R")

# Uniform Cost Search
source("../problems/8Puzzle.R")
problem = initialize.problem(3,3,c(1,2,5,3,4,8,0,6,7)) # 6 steps needed to be solved
res.BFS = Breadth.First.Search(problem, count.limit = 2500)
res.UCS1 = Uniform.Cost.Search(problem, count.limit = 2500)
get.cost = function(action,state) {
  if (action == "Up")    { return(4) }
  if (action == "Down")  { return(16) }
  if (action == "Right") { return(25) }
  if (action == "Left")  { return(16) }
}
res.UCS2 = Uniform.Cost.Search(problem, count.limit = 2500)
analyze.results(list(res1, res2, res3),problem)
# In this particular case, no differences in the solution, but yes in the costs

# Crossing river problem 
source("../problems/River_crossing_puzzle.R")
problem = initialize.problem()
res.BFS = Breadth.First.Search(problem)
res.BFS.gs = Breadth.First.Search(problem, graph.search = T)
res.DFS = Depth.First.Search(problem)
res.DFS.gs = Depth.First.Search(problem, graph.search = T)
analyze.results(list(res.BFS,res.BFS.gs,res.DFS,res.DFS.gs),problem)

# Let's try with "harder" problem
source("../problems/8Puzzle.R")
problem = initialize.problem(3,3,c(1,2,5,3,4,8,0,6,7)) # 6 steps needed to be solved
res.BFS = Breadth.First.Search(problem, count.limit = 2500)
res.BFS.gs = Breadth.First.Search(problem, graph.search = T, count.limit = 2500)
res.DFS = Depth.First.Search(problem, count.limit = 2500)
res.DFS.gs = Depth.First.Search(problem, graph.search = T, count.limit = 2500)
analyze.results(list(res.BFS,res.BFS.gs,res.DFS,res.DFS.gs),problem)
# (For this problem, problem maximum deep tends to a high number, so DFS can 
# get lost, both using and not graph search)

# Let's try with the other problem
source("../problems/Sudoku.R")
problem = initialize.problem("../data/sudoku-1.txt")
res.BFS = Breadth.First.Search(problem, count.limit = 2500)
res.BFS.gs = Breadth.First.Search(problem, graph.search = T, count.limit = 2500)
res.DFS = Depth.First.Search(problem, count.limit = 2500)
res.DFS.gs = Depth.First.Search(problem, graph.search = T, count.limit = 2500)
analyze.results(list(res.BFS,res.BFS.gs,res.DFS,res.DFS.gs),problem)
# (This problem has "fixed" maximum depth, so DFS can "easily" the solution)

# Let's go back to 8 puzzle (including DLS)
source("../problems/8Puzzle.R")
problem = initialize.problem(3,3,c(1,2,5,3,4,8,0,6,7)) # 6 steps needed to be solved
res.BFS.gs = Breadth.First.Search(problem, graph.search = T, count.limit = 2500)
res.DFS.gs = Depth.First.Search(problem, graph.search = T, count.limit = 2500)
res.DLS.05.gs = Depth.Limited.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 5)
res.DLS.05    = Depth.Limited.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 5)
res.DLS.10.gs = Depth.Limited.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 10)
res.DLS.10    = Depth.Limited.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 10)
analyze.results(list(res.BFS.gs, 
                     res.DFS.gs, 
                     res.DLS.05,
                     res.DLS.05.gs,
                     res.DLS.10,
                     res.DLS.10.gs),problem)
# (DLS is effective, but for guaranty it finds good solution, the limit has to be
# carefully configured. )

# So let's include IDS
res.IDS.10.gs = Iterative.Deepening.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 10)
res.IDS.10 = Iterative.Deepening.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 10)
res.IDS.25.gs = Iterative.Deepening.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 25)
res.IDS.25 = Iterative.Deepening.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 25)
analyze.results(list(res.BFS.gs, 
                     res.DFS.gs, 
                     res.DLS.05,
                     res.DLS.05.gs,
                     res.DLS.10,
                     res.DLS.10.gs,
                     res.IDS.10,
                     res.IDS.10.gs,
                     res.IDS.25,
                     res.IDS.25.gs),problem)
analyze.results(list(res1, res2, res3, res4, res5, res6),problem)