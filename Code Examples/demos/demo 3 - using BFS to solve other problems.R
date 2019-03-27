#---------------------------------------------------------------------------
# Breath First Search Implementation
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

# And here, there are additional (needed) functions
source("../methods/Expand Node.R")
source("../methods/Analyze Results.R")
source("../methods/Plot Results.R")

# Problem 1: River Crossing
source("../problems/River_crossing_puzzle.R")
problem = initialize.problem()
res1 = Breadth.First.Search(problem, count.limit = 5000) 
res2 = Breadth.First.Search(problem, count.limit = 5000, graph.search = T)   
analyze.results(list(res1,res2),problem) 

# Problem 2: 8-Puzzle (brief on Formulation)
# Initial State...
rows = 3
columns = 3
set.seed(1234)
perm = sample(0:(rows*columns-1))
state.initial = matrix(perm,nrow=rows,byrow = TRUE)
state.final   = matrix(0:(rows*columns-1),nrow=rows,byrow = TRUE)
actions.possible = data.frame(action=c("Up","Down","Left","Right"),cost=1)

# Is Applicable
which(state.initial==0, arr.ind=TRUE)
where = which(state.initial==0, arr.ind=TRUE)
row = where[1]
col = where[2]
# Now... only a set of ifs with code like:
#    if (action == "Up"){
#      result = row!=1
#    }

# For the effect, we only have to locate the "0" and interchange accordingly with the operation
# For the check of final state, just count the number of "matches" between the state and the final one
#  is equal to rows*columns
# (You can take a look to the code)

# Solving the problem (an easy configuration)
source("../problems/8Puzzle.R")
problem = initialize.problem(3,3,c(1,2,5,3,0,4,6,7,8))
res1 = Breadth.First.Search(problem, count.limit = 500) 
res2 = Breadth.First.Search(problem, count.limit = 500, graph.search = T)   
analyze.results(list(res1,res2),problem) 

# Try for Solving the problem (an easy configuration)
# Execution over a random 3x3 initial configuration
set.seed(1234)
problem = initialize.problem(3,3)
to.string(problem$state.initial)
res1 = Breadth.First.Search(problem, count.limit = 2500)   
res2 = Breadth.First.Search(problem, count.limit = 10000)   

# -> With limit=2500 we "only" reach deep 8. 
# -> With limit=10000 we "only" reach deep 9.
# Considering this problem has Branching factor of about 3, 
# ¿How many nodes do we need to explore to reach a solution at deep=10, 11, 12...?

# Let's try graph.search, but only up to 2000, since it is "slow"
res3 = Breadth.First.Search(problem,1000,graph.search = T)
res4 = Breadth.First.Search(problem,2000,graph.search = T)   
analyze.results(list(res1, res2, res3, res4)) 

# Problem 3: Sudoku (brief on Formulation)
# Initial State... read from a file
problem = list()
problem$state.initial = read.csv("../data/sudoku-1.txt", header = F)
problem$actions.possible = data.frame(value=1:9,cost=1)

# If applicable (to put a certain value)
state = problem$state.initial
state
value = 5
where.put = which(state==0, arr.ind = T)[1,]
where.is  = which(state==value, arr.ind = T)
where.is
where.put

# Conditions to row, column and square
app.row = any(where.is[,1] == where.put[1])
app.col = any(where.is[,2] == where.put[2])
square = floor((where.put-0.01)/3)
square = (square*3)+1
square = state[square[1]:(square[1]+2),square[2]:(square[2]+2)]
app.squ = any(square == value)
# Can I put it? (check with other values)
(!app.row & !app.col & !app.squ)

# Effect -> position where.put <- value
# Final State -> No zeros in the matriX!!
length(which(state==0))
# (You can take a look to the code)

# Solving the problem (an easy configuration)
source("../problems/Sudoku.R")

problem = initialize.problem("../data/sudoku-1.txt")
res1 = Breadth.First.Search(problem, count.limit = 1000)   
res2 = Breadth.First.Search(problem, count.limit = 1000, graph.search = T)   
analyze.results(list(res1, res2))
# which deep would we need??

# Conclusion... something more "intelligent" that BFS uses to be needed :)