interfaceGestionAlignement<-function(){
  #évantuellement remplacer c("Alexis", "Rich", "Xav") par une liste de poolers de la base de données
  
  for (j in c("Alexis", "Rich", "Xav")){
    do.call(function(i){
      tabPanel("Allo")
    
    
      }, 
     list(j))
  }
}
  