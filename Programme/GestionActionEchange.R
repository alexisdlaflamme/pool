
nomPooler<- "Xav"
numEchange<-4
password<- "allo1"

echangeAccepter<- function(nomPooler, numEchange, password){
  

  if (nomPooler %in% dbReadTable(con, "infoEchange")[numEchange,]){
    posPooler<- match(nomPooler, dbReadTable(con,"infoPoolers")$Nom)
    
    if (dbReadTable(con, "infoPoolers")[posPooler, 7] == password){
      tabConfirtmTemp<- dbReadTable(con, paste0("ConfirmeEchange", numEchange))
      
      if (nrow(tabConfirtmTemp) == 1){
        tabConfirtmTemp[1,1]<- 1
        tabConfirtmTemp[2,1]<- nomPooler
        
      }else{
        
        if(nomPooler %in% tabConfirtmTemp$Confirmation){ 
          showNotification("Vous avez deja accepter cette transaction")
        }else{
          
          trade(numEchange) ## T'es rendu là!!!! lâche pas
        }
      } 
      
    }else{
     showNotification("Le mot de passe est incorrecte") 
    }
  }else{
    showNotification("Vous n'etes pas impliquer dans cette echange")
  }
  
  which(dbReadTable(con,"infoPoolers") == "Alex", arr.ind = T)
  
  rowTrade<- dbReadTable(con, "infoEchange")[numEchange,]
  
  
  
  
  
}

echangeRefuser<- function(nomPooler, numEchange, password){
  
  
  
  
}


i<- 1
numEchange<-4
j<-3

trade<- function(numEchange){

  tabTrades<- dbReadTable(con, "infoEchange")
  listJoueursImpliquer<- list(list(), list())
  
  
  for (i in 1:2){
    strJoueurs<- tabTrades[numEchange,][[paste0("Joueurs_offert_",i)]]
    positionVirgule<- which(strsplit(strJoueurs, "")[[1]]==",")
    nbJoueurs<- length(positionVirgule) + 1 
    
      lastVirgule <- 0
      for (j in 1:nbJoueurs){
        
        if (is.na(positionVirgule[j])){
          
          listJoueursImpliquer[[i]][j]<- substr(strJoueurs, lastVirgule + 1, nchar(strJoueurs))
          
        }else{
          
          listJoueursImpliquer[[i]][j]<- substr(strJoueurs, lastVirgule + 1, positionVirgule[j] - 1)
          lastVirgule<- positionVirgule[j] + 1
        }
          
      }
  }
}

  