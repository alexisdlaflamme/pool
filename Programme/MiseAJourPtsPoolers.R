
#Brief: Permet de mettre à jour les points des joueurs des poolers
#param(poolerName): Un string qui correspond au nom du pooler dont on veux actualiser le nom des joueurs

miseAJourPtsPoolers<-function(poolerName){
  
  tabAttPooler<- dbReadTable(con, paste0("statsAtt", poolerName))
  tabDefPooler<- dbReadTable(con, paste0("statsDef", poolerName))
  tabGardiensPooler<- dbReadTable(con, paste0("statsGardiens", poolerName))
  
  statsJoueursNHL<- dbReadTable(con, "statsJoueurs")
  statsGardienNHL<- dbReadTable(con, "statsGardiens")
  
  statsAttPoolers<- rbind(statsJoueursNHL[which((statsJoueursNHL$Joueurs %in% tabAttPooler$Joueurs)),])
  statsAttPoolers<- as.data.frame(statsAttPoolers[!duplicated(statsAttPoolers$Joueurs),])
  positionAinB<- match(tabAttPooler$Joueurs,statsAttPoolers$Joueurs)
  
  j<-1
  for (i in positionAinB){
    if (tabAttPooler[j,]$Statues == "Actif"){
      tabAttPooler[j,]$GP <- statsAttPoolers[i,]$GP
      tabAttPooler[j,]$Buts <-  statsAttPoolers[i,]$Buts
      tabAttPooler[j,]$Passes <-  statsAttPoolers[i,]$Passes
      tabAttPooler[j,]$DateDerniereModif<- as.character(Sys.Date( ))
    }
    j<- j + 1
  }
  
  statsDefPoolers<- rbind(statsJoueursNHL[which((statsJoueursNHL$Joueurs %in% tabDefPooler$Joueurs)),])
  statsDefPoolers<- as.data.frame(statsDefPoolers[!duplicated(statsDefPoolers$Joueurs),])
  positionAinB<- match(tabDefPooler$Joueurs,statsDefPoolers$Joueurs)
  
  j<-1
  for (i in positionAinB){
    if (tabDefPooler[j,]$Statues == "Actif"){
      tabDefPooler[j,]$GP <- statsDefPoolers[i,]$GP
      tabDefPooler[j,]$Buts <-  statsDefPoolers[i,]$Buts
      tabDefPooler[j,]$Passes <-  statsDefPoolers[i,]$Passes
      tabDefPooler[j,]$DateDerniereModif<- as.character(Sys.Date( ))
    }
    j<- j + 1 
  }
  
  statsGardiensPoolers<- rbind(statsGardienNHL[which((statsGardienNHL$Joueurs %in% tabGardiensPooler$Joueurs)),])
  statsGardiensPoolers<- as.data.frame(statsGardiensPoolers[!duplicated(statsGardiensPoolers$Joueurs),])
  positionAinB<- match(tabGardiensPooler$Joueurs,statsGardiensPoolers$Joueurs)
  
  j<-1
  for (i in positionAinB){
    if (tabGardiensPooler[j,]$Statues == "Actif"){
      tabGardiensPooler[j,]$GP <- statsGardiensPoolers[i,]$GP
      tabGardiensPooler[j,]$Win <-  statsGardiensPoolers[i,]$Win
      tabGardiensPooler[j,]$OL <-  statsGardiensPoolers[i,]$OL
      tabGardiensPooler[j,]$BL <-  statsGardiensPoolers[i,]$BL
      tabGardiensPooler[j,]$Buts <-  statsGardiensPoolers[i,]$Buts
      tabGardiensPooler[j,]$Passes <-  statsGardiensPoolers[i,]$Passes
      tabGardiensPooler[j,]$DateDerniereModif<- as.character(Sys.Date( ))
    }
    j<- j + 1 
  }
  
  dbWriteTable(con, paste0("statsAtt", poolerName), tabAttPooler, overwrite = T)
  dbWriteTable(con, paste0("statsDef", poolerName), tabDefPooler, overwrite = T)
  dbWriteTable(con, paste0("statsGardiens", poolerName), tabGardiensPooler, overwrite = T)
}

#miseAJourPtsPoolers("Rich")
#miseAJourPtsPoolers("Alex")
#miseAJourPtsPoolers("Xav")
