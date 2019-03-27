#---------------------------------------------------------------------------
# Expanding Nodes and maintainig Frontier
# Intelligent Systems - University of Deusto
# Enrique Onieva Caracuel
#---------------------------------------------------------------------------
# 
#---------------------------------------------------------------------------
# Preliminaries: Cleaning, importing...
rm(list=ls())
cat("\014")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
dir()

#---------------------------------------------------------------------------
# The problem "Wolf, goat, and cabbage"
# https://en.wikipedia.org/wiki/River_crossing_puzzle
# A farmer must transport a Wolf, a goat and cabbage from one side of a river to another using 
# a boat which can only hold one item in addition to the farmer, 
# subject to the constraints that the wolf cannot be left alone with the goat, 
# and the goat cannot be left alone with the cabbage

#---------------------------------------------------------------------------
# State: initial and final state comprobation
# the state will be defined as a 4-elements (boolean) vector, representing each one of them
# the position of the elements:
# 1st position: location of the farmer  (TRUE: left / FALSE: right)
# 2nd position: location of the wolf    (TRUE: left / FALSE: right)
# 3rd position: location of the goat    (TRUE: left / FALSE: right)
# 4th position: location of the cabbage (TRUE: left / FALSE: right)

state.initial = data.frame(farmer = TRUE, wolf = TRUE, goat = TRUE, cabbage = TRUE)
print(state.initial)

# Given a state, 
state1 = data.frame(farmer = TRUE, wolf = TRUE, goat = TRUE, cabbage = TRUE)
state2 = data.frame(farmer = FALSE, wolf = TRUE, goat = FALSE, cabbage = TRUE)
state3 = data.frame(farmer = FALSE, wolf = FALSE, goat = FALSE, cabbage = FALSE)

# the comprobation of the final state can be done by checking all the elements are FALSE
# (or, in a simpler way, adding the elements of the vector, and comparing with 0)
(!state1$farmer && !state1$wolf && !state1$goat && !state1$cabbage)
(!state2$farmer && !state2$wolf && !state2$goat && !state2$cabbage)
(!state3$farmer && !state3$wolf && !state3$goat && !state3$cabbage)

# (or, in a simpler way, "adding" the elements of the vector, and comparing with 0)
sum(as.numeric(state1))==0
sum(as.numeric(state2))==0
sum(as.numeric(state3))==0

# (or, checking if all of them are equal to false)
all(state1==FALSE)
all(state2==FALSE)
all(state3==FALSE)

#---------------------------------------------------------------------------
# Actions: actions possible, their conditions and effects
# 4 different actions can be done
# 1: "farmer"  -> changes the side of the farmer (alone) 
# 2: "wolf"    -> changes the side of the wolf (and also the farmer)
# 3: "goat"    -> changes the side of the goat (and also the farmer)
# 4: "cabbage" -> changes the side of the cabbage (and also the farmer)

# 1: moving the farmer can be done if no restrictions are violated 
# 2-4: moving another element can be done if no restrictions are violated and the element is
# in the same side of the river than the farmer

# So, we can check if moving the farmer can be done as:
(state1$wolf != state1$goat) && (state1$goat != state1$cabbage)
(state2$wolf != state2$goat) && (state2$goat != state2$cabbage)

# So, we can check if moving the goat can be done as:
(state1$goat == state1$farmer)
(state2$goat == state2$farmer)
# Or moving the cabbage (wolf and goat cannot be in similar place)
(state1$wolf != state1$goat) && (state1$cabbage == state1$farmer)
(state1$wolf != state1$goat) && (state2$cabbage == state2$farmer)

# And the effect of applying an action (goat, for instance) over a state is inverting the corresponding positions:
newstate = state2
newstate$farmer = !newstate$farmer
newstate$goat = !newstate$goat
newstate

#---------------------------------------------------------------------------
# Putting all Toghether
# Defining a problem and its initialization
rm(list=ls())
cat("\014")
problem = list()
problem$state.initial = data.frame(farmer = TRUE, wolf = TRUE, goat = TRUE, cabbage = TRUE)
problem$actions.possible = data.frame(action=c("farmer","wolf","goat","cabbage"), stringsAsFactors = F)

initialize.problem = function() {
  problem = list()
  problem$state.initial = data.frame(farmer = TRUE, wolf = TRUE, goat = TRUE, cabbage = TRUE)
  problem$actions.possible = data.frame(action=c("farmer","wolf","goat","cabbage"), stringsAsFactors = F)
  problem$name = paste0("River crossing puzzle")
  return(problem)
}

is.applicable = function (state, action, problem) {
  if (action == "farmer") {
    result = (state$wolf != state$goat) && (state$goat != state$cabbage)
  }
  if (action == "wolf") {
    result = (state$goat != state$cabbage) && (state$farmer == state$wolf)
  }
  if (action == "goat") {
    result = (state$farmer == state$goat)
  }
  if (action == "cabbage") {
    result = (state$goat != state$cabbage) && (state$farmer == state$cabbage)
  }
  return(result)
}

effect = function (state,action) {
  result = state
  result$farmer = !result$farmer
  
  if (action == "wolf") {
    result$wolf = !result$wolf
  }
  
  if (action == "goat") {
    result$goat = !result$goat
  }
  
  if (action == "cabbage") {
    result$cabbage = !result$cabbage
  }
  
  return(result)
}

is.final.state = function(state) {
  return(all(state==FALSE))
}

# Solving a problem
# I start from an initial state of a problem
problem = initialize.problem()
state = problem$state.initial
actions = problem$actions.possible

# Define a frontier with nodes pending of "expansion"
frontier = list(state)

# For the first state in the frontier, 
# I have to extract it and check if it is a final state.
# if not, I have to check which of the actions are applicable
current.state = frontier[[1]]
frontier[[1]] = NULL
current.state
is.final.state(current.state)
applicable.actions = sapply(actions$action, function (x) is.applicable(current.state,x,problem))
applicable.actions

# and apply those actions
res = lapply(actions$action[applicable.actions], function(x) effect(current.state,x))
res
frontier = append(frontier, res)
frontier
# AND REPEAT THE PROCEDURE... UNTIL FINAL STATE FOUND!!!