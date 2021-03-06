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
  problem$state.initial = c(12,32)
  problem$name = "PHub40"
  problem$aeropuertos = read.csv("../data/AP40.txt", header = F, skip=42, dec = ".", sep = " ")
  problem$actions.possible = data.frame(action=c(1:40))
  problem$Pnum = Pnum
  return(problem)
}

#Le paso el numero de aeropueropuertos principales



# =======================================================================
# Must return TRUE or FALSE according with if the action can be done or not
# over the specific state
is.applicable = function (state,action,problem){
  #La unica comprobacion que hago es que no sean el mismo aeropuerto principal
  result = FALSE
  if (state[1]!=action) {
    result= TRUE
  }
  return(result)
}

# =======================================================================
# Must return the state resulting on applying the action over the state
effect = function (state,action){
  #Unicamente hago que se cambie el aeropuerto B, como nos dijiste en clase 
  #para que fuese mas corto el problem <3
  result = state
  result[2]=action
  return(result)
}


# =======================================================================
# Must return TRUE or FALSE according with the state is final or not
# * In case the final state is stablished by a condition, second argument
#   could be omited
is.final.state = function (state, finalstate=problem$state.final){
  # <insert code here in order to modify the resulting state> 
  return(FALSE)
}

# =======================================================================
# Must print the state in console (in a legible way)
to.string = function (state){
  print(state)
}

# =======================================================================
# Return the cost of applying an action over a state
get.cost = function (action,state){
  # Toda accion tendra como coste 1
  return(1)
}

# =======================================================================
# (Used for Informed Algorithms)
# Heuristic function used in Informed algorithms
get.evaluation = function(state,problem){
  total=0
  aPorts=list()
  bPorts=list()
  #SEPARO LOS AEROPUERTOS POR CERCANIA CON LOS PRINCIPALES
  for (airP in 1:40) {
    if (airP!=state[1]&&airP!=state[2]) {
      if(problem$aeropuertos[airP,state[1]]<problem$aeropuertos[airP,state[2]]){
        #print(paste0("A�adido a la lista A el aeropuerto N� ", airP))
        aPorts = c(aPorts,airP)
      } else {
        #print(paste0("A�adido a la lista B el aeropuerto N� ", airP))
        bPorts = c(bPorts,airP)
      }
    }
  }
  #HAGO DE A A TODOS LOS Bs
  for (airA in aPorts) {
    for (airB in bPorts) {
      total = total + problem$aeropuertos[airA,state[1]] + problem$aeropuertos[state[1],state[2]] + problem$aeropuertos[state[1],airB]
    }
  }
  #HAGO DE A A TODOS LOS As [No esta del todo bien por que duplica vuelos]
  for (airA in aPorts) {
    for (airA2 in aPorts) {
      if (airA2!=airA) {
        total = total + problem$aeropuertos[airA,state[1]] + problem$aeropuertos[state[1],airA2]
      }
    }
  }
  #HAGO DE B A TODOS LOS Bs [No esta del todo bien por que duplica vuelos]
  for (airB in bPorts) {
    for (airB2 in bPorts) {
      if (airB2!=airB) {
        total = total + problem$aeropuertos[airB,state[1]] + problem$aeropuertos[state[1],airB2]
      }
    }
  }
  #HAGO DE TODOS LOS As AL PRIMER PRINCIPAL Y AL SEGUNDO PRINCI
  for (airA in aPorts) {
    total = total + (problem$aeropuertos[airA,state[1]]*2)+problem$aeropuertos[state[1],state[2]]
  }
  #HAGO DE TODOS LOS Bs AL SEGUNDO PRINCI Y AL PRIMERO PRINCI
  for (airB in bPorts) {
    total = total + (problem$aeropuertos[airB,state[2]]*2)+problem$aeropuertos[state[2],state[1]]
  }
  
  return(total)
}