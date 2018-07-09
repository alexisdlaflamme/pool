source(file="C:\\Users\\Alexis\\Dropbox\\Pool 2017-2018\\Pool 2018-2019\\Programme\\ImportJoueurGardienStats.R")

library(dplyr)
library(jsonlite)

##Fonction temporaire pour le temps qu'on puisse se faire une équipe avec l'interface
createAleatoireTeam<-function(){
  statsJoueurs<-reqStatsJoueursNHL()
  nomAtt<-sample_n(subset(statsJoueurs, (Position == "LW" | Position == "RW" | Position == "C") & GP >= 50 , c(Joueurs, Equipe)),13)
  nomDef<-sample_n(subset(statsJoueurs, Position == "D" &  GP >= 50 , c(Joueurs, Equipe)),7)
  statsGardiens<- reqStatsGardienNHL()
  nomGardien<-sample_n(subset(statsGardiens, GP >= 40 , c(Joueurs, Equipe)),3)
  POS<-c(rep("Att",13), rep("Def",7), rep("G",3))
  Statue<- c(rep("Actif", 12), "Backup", rep("Actif", 6), "Backup", rep("Actif", 2), "Backup")
  equipe <- rbind(nomAtt,nomDef,nomGardien)
  equipe <- cbind(equipe, Statue, POS)
  return(equipe[order(Statue, POS),])
}

##Permet de générer un fichier json qui contiendra les informations des joueur d'un poolers tout au long de la saison
createJsonPoolers <- function(poolerName, infoAlignement){
  # init = À l'inilitiation
  infoJoueur<- subset(infoAlignement, POS == "Att" | POS == "Def")
  infoGardien<- subset(infoAlignement, POS == "G")
  
  infoJoueurInit <- data.frame(cbind(infoJoueur, matrix(rep(0,120),20,6),matrix(rep(as.character(Sys.Date( )),40),20,2)))
  colnames(infoJoueurInit) <- c("Joueurs", "Equipe" ,"Statues","Position", "GP" ,"Buts", "Passes", 
                                "Parties_Init", "Buts_Init", "Passes_Init", "DateDerniereModif", "DateEntreeAlignement")
  
  infoGardienInit <- data.frame(cbind(infoGardien, matrix(rep(0,36),3,12), matrix(rep(as.character(Sys.Date( )),6),3,2)))
  colnames(infoGardienInit) <- c("Joueurs", "Equipe" ,"Statues","Position", "GP", "Win", "OL", "BL", "Buts", "Passes", 
                                "GP_Inti", "Win_Inti", "OL_Inti", "BL_Inti", "Buts_Inti", "Passes_Inti" ,"DateDerniereModif", "DateEntreeAlignement")
  
  
  infoJson <- toJSON(list(infoJoueurInit, infoGardienInit), pretty = TRUE)
  savePath <- paste("C:\\Users\\Alexis\\Dropbox\\Pool 2017-2018\\Pool 2018-2019\\Data\\Poolers\\dataPooler", poolerName, ".json", sep = "")
  
  write(infoJson, savePath)
}


myTeam<- createAleatoireTeam()
test<-createJsonPoolers("Xav", myTeam)

