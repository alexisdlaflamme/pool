interfaceGestionAlignement<-function(){
  #évantuellement remplacer c("Alexis", "Rich", "Xav") par une liste de poolers de la base de données
  
  lapply(1:3, function(i){
      tabPanel(paste0("Allo",i))
    })
}
  