
source(paste(DirrPGM,"/ImportJoueurGardienStats.R", sep = ""))
library(jsonlite)

#Brief: Permet de mettre à jour les points des joueurs des poolers
#param(poolerName): Un string qui correspond au nom du pooler dont on veux actualiser le nom des joueurs
miseAJourPtsPoolers<-function(poolerName){
  
  #Import stats joueurs et gardien poolers dernière modif 
  pathStatsPooler<- paste(getwd(), "/Data/Poolers/dataPooler", poolerName, ".json", sep = "")
  statsJGPoolerJson<- fromJSON(pathStatsPooler)
  
  #Mise à jours des stats des joueurs du pooler 
  statsJoueursNHL<- reqStatsJoueursNHL()
  statsJoueursPoolers<-statsJoueursNHL[which((statsJoueursNHL$Joueurs %in% statsJGPoolerJson[[1]]$Joueurs)),]
  statsJoueursPoolers<- as.data.frame(statsJoueursPoolers[!duplicated(statsJoueursPoolers$Joueurs),])
  
  positionAinB<-match(statsJGPoolerJson[[1]]$Joueurs,statsJoueursPoolers$Joueurs)
  
  j<-1
  for (i in positionAinB){
    if (statsJGPoolerJson[[1]][j,]$Statues == "Actif"){
      statsJGPoolerJson[[1]][j,]$GP <- statsJoueursPoolers[i,]$GP
      statsJGPoolerJson[[1]][j,]$Buts <-  statsJoueursPoolers[i,]$Buts
      statsJGPoolerJson[[1]][j,]$Passes <-  statsJoueursPoolers[i,]$Passes
      statsJGPoolerJson[[1]][j,]$DateDerniereModif<- as.character(Sys.Date( ))
      j<- j + 1 
    }
  }
  
  #Mise à jour des stats des gardiens
  statsGardiensNHL<- reqStatsGardienNHL()
  statsGardiensPoolers <- statsGardiensNHL[which((statsGardiensNHL$Joueurs %in% statsJGPoolerJson[[2]]$Joueurs)),]
  statsGardiensPoolers<- as.data.frame(statsGardiensPoolers[!duplicated(statsGardiensPoolers$Joueurs),])

  positionAinB<-match(statsJGPoolerJson[[2]]$Joueurs, statsGardiensPoolers$Joueurs)
  
  j<-1
  for (i in positionAinB){
    if (statsJGPoolerJson[[2]][j,]$Statues == "Actif"){
      statsJGPoolerJson[[2]][j,]$GP <- statsGardiensPoolers[i,]$GP
      statsJGPoolerJson[[2]][j,]$Win <-  statsGardiensPoolers[i,]$Win
      statsJGPoolerJson[[2]][j,]$OL <-  statsGardiensPoolers[i,]$OL
      statsJGPoolerJson[[2]][j,]$BL <-  statsGardiensPoolers[i,]$BL
      statsJGPoolerJson[[2]][j,]$Buts <-  statsGardiensPoolers[i,]$Buts
      statsJGPoolerJson[[2]][j,]$Passes <-  statsGardiensPoolers[i,]$Passes
      statsJGPoolerJson[[2]][j,]$DateDerniereModif<- as.character(Sys.Date( ))
      j<- j + 1 
    }
  }
  
  #Enregistrement des stats misent ? jour
  statsJGPoolerJson<- toJSON(statsJGPoolerJson, pretty = TRUE)
  write(statsJGPoolerJson, pathStatsPooler)
}

miseAJourPtsPoolers("Xav")

