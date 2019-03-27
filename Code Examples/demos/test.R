#---------------------------------------------------------------------------
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

source("../methods/Expand Node.R")
source("../methods/Analyze Results.R")
source("../methods/Plot Results.R")

source("../methods/Breadth First Search.R")
source("../problems/River_crossing_puzzle.R")
problem = initialize.problem()
res1 = Breadth.First.Search(problem)
res2 = Breadth.First.Search(problem, graph.search = T)
analyze.results(list(res1,res2),problem)

source("../methods/Depth First Search.R")
source("../problems/Sudoku.R")
problem = initialize.problem("../data/sudoku-1.txt")
res1 = Depth.First.Search(problem, count.limit = 1000)
res2 = Depth.First.Search(problem, graph.search = T, count.limit = 1000)
analyze.results(list(res1,res2),problem)

source("../methods/Depth Limited Search.R")
source("../problems/8Puzzle.R")
problem = initialize.problem(3,3,c(1,2,5,3,4,8,0,6,7)) # 6 steps needed to be solved
res1 = Depth.Limited.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 5)
res2 = Depth.Limited.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 5)
res3 = Depth.Limited.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 10)
res4 = Depth.Limited.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 10)
res5 = Depth.Limited.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 25)
res6 = Depth.Limited.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 25)
analyze.results(list(res1, res2, res3, res4, res5, res6),problem)

source("../methods/Iterative Deepening Search.R")
source("../problems/8Puzzle.R")
problem = initialize.problem(3,3,c(1,2,5,3,4,8,0,6,7)) # 6 steps needed to be solved
res1 = Iterative.Deepening.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 5)
res2 = Iterative.Deepening.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 5)
res3 = Iterative.Deepening.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 10)
res4 = Iterative.Deepening.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 10)
res5 = Iterative.Deepening.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 25)
res6 = Iterative.Deepening.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 25)
analyze.results(list(res1, res2, res3, res4, res5, res6),problem)

source("../methods/Depth Limited Search.R")
source("../problems/8Puzzle.R")
problem = initialize.problem(3,3,c(1,2,5,3,4,8,0,6,7)) # 6 steps needed to be solved
res1 = Depth.Limited.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 5)
res2 = Depth.Limited.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 5)
res3 = Depth.Limited.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 10)
res4 = Depth.Limited.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 10)
res5 = Depth.Limited.Search(problem, graph.search = T, count.limit = 25000, depth.limit = 25)
res6 = Depth.Limited.Search(problem, graph.search = F, count.limit = 25000, depth.limit = 25)
analyze.results(list(res1, res2, res3, res4, res5, res6),problem)

source("../methods/Iterative Deepening Search.R")
source("../problems/8Puzzle.R")
problem = initialize.problem(3,3,c(1,2,5,3,4,8,0,6,7)) # 6 steps needed to be solved
res1 = Iterative.Deepening.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 5)
res2 = Iterative.Deepening.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 5)
res3 = Iterative.Deepening.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 10)
res4 = Iterative.Deepening.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 10)
res5 = Iterative.Deepening.Search(problem, graph.search = T, count.limit = 2500, depth.limit = 25)
res6 = Iterative.Deepening.Search(problem, graph.search = F, count.limit = 2500, depth.limit = 25)
analyze.results(list(res1, res2, res3, res4, res5, res6),problem)

source("../methods/Breadth First Search.R")
source("../methods/Uniform Cost Search.R")
source("../problems/8Puzzle.R")
problem = initialize.problem(3,3,c(1,2,5,3,4,8,0,6,7)) # 6 steps needed to be solved
res1 = Breadth.First.Search(problem, count.limit = 2500)
res2 = Uniform.Cost.Search(problem, count.limit = 2500)
get.cost = function(action,state){
  if (action == "Up")   {return(4)}
  if (action == "Down") {return(16)}
  if (action == "Right"){return(25)}
  if (action == "Left") {return(16)}
}
res3 = Uniform.Cost.Search(problem, count.limit = 2500)
analyze.results(list(res1, res2, res3),problem)
# In this particular case, no differences in the solution, but yes in the costs