alignementSelectionAttaquant<- function(){

  lapply(1:3, function(i){
    column(4,
           lapply(1:5, function(j){
             textInput(paste0("att", 5*(i-1)+j), label = paste("Nom attaquant",5*(i-1)+j), width = "100%")
           })
    )
  })
}


alignementSelectionDefenseur<- function(){
  lapply(1:2, function(i){
    column(6,
           lapply(1:4, function(j){
             textInput(paste0("def", 4*(i-1)+j), label = paste("Nom defenseur",4*(i-1)+j), width = "100%")
           })
    )
  })
}



alignementSelectionGardien<- function(){
  lapply(1:3, function(i){
    column(4,
           lapply(1, function(j){
             textInput(paste0("goal", 1*(i-1)+j), label = paste("Nom gardien",1*(i-1)+j), width = "100%")
           })
    )
  })
}
