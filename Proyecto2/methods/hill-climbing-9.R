# =======================================================================
# Names: Alberto Miranda & Danel Lorente
# Group Number: 
# Assignment: Sistemas Inteligentes
# Date: 27/03/2019
# =======================================================================


Hill.Climbing.Busqueda = function(problem,
                                count.limit=100, 
                                count.print = 100, 
                                trace = FALSE, 
                                graph.search = FALSE){
  
  # Inisialiso
  name.method = paste0("Hill Climbing", ifelse(graph.search," + GS",""))
  state.initial    = problem$state.initial
  state.final      = problem$state.final
  actions.possible = problem$actions.possible
  initialNode.evaluation = get.evaluation(state.initial, problem)
  
  # Primer nodo con el estado inicial
  node = list(parent=c(),
              state=state.initial,
              actions=c(),
              depth=0,
              cost=0,
              evaluation=initialNode.evaluation)
  # Creo el frontier donde metere los nodes 
  frontier = list(node)
  
  # Expande la lista
  if (graph.search){
    expanded = list()     
  }
  count = 1
  end.reason = 0
  # No se que hase xd
  report = data.frame(iteration=numeric(),
                      nodes.frontier=numeric(),
                      depth.of.expanded=numeric(),
                      nodes.added.frontier=numeric())
  
  #El bucle con todas las iteraciones que definimos antes
  while (count<=count.limit){
    # Printeo cada 100 vueltas pa ver como va la cosa
    if (count%%count.print==0){
      print(paste0("Count: ",count,", Nodes in the frontier: ",length(frontier)), quote = F)
    }
    
    # Si el frontier esta vacio significa que he encotrado la "solucion"
    if (length(frontier)==0){
      end.reason = "Solution"
      break
    }
    
    # Take first node from the frontier and add it to the graph
    firstnode = frontier[[1]]
    #frontier[[1]] = NULL
    # Empty frontier
    frontier = list()
    if(graph.search){
      expanded = append(expanded,list(firstnode))
    }
    
    
    # For debugging
    if (trace){
      print(" ",quote = F)
      print("------------------------------", quote = F)
      print("State extracted from frontier:", quote = F)
      to.string(firstnode$state)
      print(paste0("(depth=",firstnode$depth,", cost=",firstnode$depth,")"),quote = F)
    }
    
    # End if it reaches final state
    if (is.final.state(firstnode$state,state.final)){
      end.reason = "Solution"
      break
    }
    
    # Expand from the firstnode (function in Expand Node.R)
    newnodes = expand.node(firstnode, actions.possible)
    
    
    if (!graph.search){
      frontier = c(frontier,newnodes)
      nodes.added.frontier = length(newnodes)
      if (length(newnodes)){
        for (i in 1:length(newnodes)){
          newnode = newnodes[[i]]		  
          if (trace){
            print(paste0("State added to frontier: - (depth=",newnode$depth,", cost=",newnode$depth,")"),quote = F)
            to.string(newnode$state)
          }
        }
      }
    }else{
      # This
      nodes.added.frontier = 0
      if (length(newnodes)){
        for (i in 1:length(newnodes)){
          newnode = newnodes[[i]]
          # Check every node in the frontier if its identical to the newnode
          if (!any(sapply(frontier,function (x) identical(x$state,newnode$state)))){
            # Check every node in the expanded if its identical to the newnode
            if (!any(sapply(expanded,function (x) identical(x$state,newnode$state)))){
              # Add new node to the frontier
              frontier = append(frontier,list(newnode))
              nodes.added.frontier = nodes.added.frontier + 1
              if (trace){
                print(paste0("State added to frontier: - (depth=",newnode$depth,", cost=",newnode$depth,")"),quote = F)
                to.string(newnode$state)
              }
            }
          }
        }
      }
    }
    
    if(trace){
      print(paste0("Total states in the frontier: ", length(frontier)),quote = F)
    }
    
    # When finished adding nodes, sort by evaluation
    frontier <- frontier[order(evaluation)]
    
    report = rbind(report,
                   data.frame(iteration = count,
                              nodes.frontier = length(frontier),
                              depth.of.expanded = firstnode$depth,
                              nodes.added.frontier = nodes.added.frontier))
    
    count = count+1
  }
  
  
  result = list()
  result$report = report
  result$name = name.method
  
  # Show the obtained (or not) final solution
  if (end.reason == "Solution"){
    print("Solution found!!", quote = F)
    to.string(firstnode$state)
    print("Actions: ", quote = F)
    print(firstnode$actions, quote = F)
    result$state.final = firstnode
  } else{
    if (end.reason == "Frontier"){
      print("Empty frontier. No sollution found", quote = F)
    } else{
      print("Maximum Number of iterations reached. No sollution found", quote = F)
    }
    result$state.final = NA
  }
  
  plot.results(report,name.method,problem)
  
  return(result)
}
