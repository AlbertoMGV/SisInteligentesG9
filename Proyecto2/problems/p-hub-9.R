# =======================================================================
# Names: Alberto Miranda & Danel Lorente
# Group Number: 
# Assignment: Sistemas Inteligentes
# Date: 27/03/2019
# =======================================================================
# 1. Be sure to include, with this template, any necessary files
#    for execution, including datasets (problem.R, methodXXX.R, ...)
#    (submission of the entire template folder is recommended)
# 2. If you use a function of a certain package, do not forget to include the
#    corresponding call to the "library ()" function
# 3. Do not forget to comment on the code, especially those non-trivial commands
#    (remember that part of the rating depends on the cleaning of the code)
# 4. It is strongly recommended to test any implemented function in order to 
#    check for its proper operation
# =======================================================================
# (This is a general code, you must adapt it)
# =======================================================================

# This function must return a list with the information needed to 
# solve the problem.
# (Depending on the problem, it should receive or not parameters)
initialize.problem = function(Pnum){
  problem = list()
#Aqui eligo los dos principales aleatorios para empesar lel
  problem$state.initial = c(4,10)
  problem$name = "PHub40"
  problem$mapa = read.csv("../data/AP10.txt", header = F, skip=42, dec = ".", sep = " ")
  problem$Pnum = Pnum
  return(problem)
}
#Le paso el numero de aeropueropuertos principales
problema = initialize.problem(3)
print(problem$mapa[problem$state.initial[1],problem$state.initial[2]])
# =======================================================================
# Must return TRUE or FALSE according with if the action can be done or not
# over the specific state
is.applicable = function (state,action,problem){
  result = FALSE
  #
  
  return(result)
}

# =======================================================================
# Must return the state resulting on applying the action over the state
effect = function (state,action){
  result = state
  # <insert code here in order to modify the resulting state> 
  return(result)
}


# =======================================================================
# Must return TRUE or FALSE according with the state is final or not
# * In case the final state is stablished by a condition, second argument
#   could be omited
is.final.state = function (state, finalstate=problem$state.final){
  # <insert code here in order to modify the resulting state> 
  return(state[1]==finalstate[1] && state[2]==finalstate[2])
}

# =======================================================================
# Must print the state in console (in a legible way)
to.string = function (state){
  print(state)
}

# =======================================================================
# Return the cost of applying an action over a state
get.cost = function (action,state){
  # Return the cost of applying an action over a state
  return(1)
}

# =======================================================================
# (Used for Informed Algorithms)
# Heuristic function used in Informed algorithms
get.evaluation = function(state,problem){
  
  
	return(1)
}