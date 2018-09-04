
echangeAccepter<- function(nomPooler, numEchange, password){
  

  if (nomPooler %in% dbReadTable(con, "infoEchange")[numEchange,]){
    infoEchangeTemp<- dbReadTable(con, "infoEchange")
    posPooler<- match(nomPooler, dbReadTable(con,"infoPoolers")$Nom)
    
    if (dbReadTable(con, "infoPoolers")[posPooler, 7] == password){
      tabConfirtmTemp<- dbReadTable(con, paste0("ConfirmeEchange", numEchange))
      
      if (nrow(tabConfirtmTemp) == 1){
        tabConfirtmTemp[1,1]<- 1
        tabConfirtmTemp[2,1]<- nomPooler
        dbWriteTable(con, paste0("ConfirmeEchange", numEchange), tabConfirtmTemp, overwrite = T)
        
      }else{
        
        if(nomPooler %in% tabConfirtmTemp$Confirmation){ 
          showNotification("Vous avez deja accepter cette transaction")
        }else{
          
          trade(numEchange) ## T'es rendu là!!!! lâche pas
          dbRemoveTable(con, paste0("ConfirmeEchange", numEchange))
          infoEchangeTemp[numEchange,]$Statue<- "Accepter"
          dbWriteTable(con, "infoEchange", infoEchangeTemp, overwrite = T)
          showNotification("L'echange a bien ete accepter")
        }
      } 
      
    }else{
     showNotification("Le mot de passe est incorrecte") 
    }
  }else{
    showNotification("Vous n'etes pas impliquer dans cette echange")
  }

}

echangeRefuser<- function(nomPooler, numEchange, password){
  
  
  if (nomPooler %in% dbReadTable(con, "infoEchange")[numEchange,]){
    infoEchangeTemp<- dbReadTable(con, "infoEchange")
    posPooler<- match(nomPooler, dbReadTable(con,"infoPoolers")$Nom)
    
    if (dbReadTable(con, "infoPoolers")[posPooler, 7] == password){
      
      dbRemoveTable(con, paste0("ConfirmeEchange", numEchange))
      infoEchangeTemp[numEchange,]$Statue<- "Refuser"
      dbWriteTable(con, "infoEchange", infoEchangeTemp, overwrite = T)
      showNotification("L'echange a bien ete refuser")
      
    }else{
      showNotification("Le mot de passe est incorrecte") 
    }
  }else{
    showNotification("Vous n'etes pas impliquer dans cette echange")
  }
  
}

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
  
  for (i in 1:2){
    if (i == 1){j <- 2}else if (i == 2){j<- 1}
    
    for (joueur in 1:length(listJoueursImpliquer[[1]])){
      for (pos in c("statsAtt", "statsDef", "statsGardiens")){
        tabPositionDonneur<- dbReadTable(con, paste0(pos, tabTrades[numEchange,][[paste0("Poolers", i)]]))

        if (listJoueursImpliquer[[i]][joueur] %in% tabPositionDonneur$Joueurs){
          tabPositionReceveur<- dbReadTable(con, paste0(pos, tabTrades[numEchange,][[paste0("Poolers", j)]]))
          
          posInTable<- match(listJoueursImpliquer[[i]][joueur], tabPositionDonneur$Joueurs)
          tabPositionDonneur[posInTable, ]$Statues <- "Trade"
          
          newLineTabPosReceveur<- tabPositionDonneur[posInTable,]
          newLineTabPosReceveur[,c(3,11:12)]<- c("New", as.character(Sys.Date( )), as.character(Sys.Date( )))
          newLineTabPosReceveur[,c(8:10)]<- c(as.numeric(newLineTabPosReceveur$GP), newLineTabPosReceveur$Buts, 
                                              newLineTabPosReceveur$Passes)
          
          
          tabPositionReceveur<- rbind(tabPositionReceveur, newLineTabPosReceveur)
          tabPositionReceveur[,5:10]<- as.numeric(as.character(unlist(tabPositionReceveur[,5:10])))
          
          dbWriteTable(con, paste0(pos, tabTrades[numEchange,][[paste0("Poolers", i)]]), 
                       tabPositionDonneur, overwrite = T)
          dbWriteTable(con, paste0(pos, tabTrades[numEchange,][[paste0("Poolers", j)]]), 
                       tabPositionReceveur, overwrite = T)

        }
        
      }
    }
  }
}

  