DirPGM<-paste(getwd(), "/Programme/", sep = "")


library(dplyr)
library(readxl)
library(jsonlite)

##Fonction temporaire pour le temps qu'on puisse se faire une ?quipe avec l'interface
createAleatoireTeam<-function(){
  
  statsJoueurs<-dbReadTable(con, "statsJoueurs")
  nomAtt<-sample_n(subset(statsJoueurs, (Position == "LW" | Position == "RW" | Position == "C") & GP >= 50 , c(Joueurs, Equipe)),12)
  nomDef<-sample_n(subset(statsJoueurs, Position == "D" &  GP >= 50 , c(Joueurs, Equipe)),6)
  statsGardiens<- dbReadTable(con, "statsGardiens")
  nomGardien<-sample_n(subset(statsGardiens, GP >= 40 , c(Joueurs, Equipe)),3)
  POS<-c(rep("Att",12), rep("Def",6), rep("G",3))
  Statue<- c(rep("Actif", 12), rep("Actif", 6), rep("Actif", 2), "Backup")
  equipe <- rbind(nomAtt,nomDef,nomGardien)
  equipe <- cbind(equipe, Statue, POS)
  return(equipe[order(Statue, POS),])
}

##Permet de générer un fichier json qui contiendra les informations des joueur d'un poolers tout au long de la saison
createPoolers <- function(poolerName, poolerColor, infoAlignement, password){

  if (!dbExistsTable(con,"infoPoolers") | is.na(dbReadTable(con,"infoPoolers")[1,1])){
    infoPooler<- as.data.frame(matrix(c(poolerName, poolerColor, paste0("statsAtt", poolerName), 
                                        paste0("statsDef", poolerName), paste0("statsGardien", poolerName), 
                                        paste0("evoPosition", poolerName), password),
                                        nrow = 1, ncol = 7))
    
    colnames(infoPooler)<- c("Nom", "Couleur", "tabStatsAtt", "tabStatsDef", "tabStatsGardien" ,"tabEvoPosition", "password")
    dbWriteTable(con, "infoPoolers", infoPooler, overwrite = T)
    
  } else{
    
    infoPooler<- as.data.frame(matrix(c(poolerName, poolerColor, paste0("statsAtt", poolerName), 
                                        paste0("statsDef", poolerName), paste0("statsGardien", poolerName), 
                                        paste0("evoPosition", poolerName), password),
                                        nrow = 1, ncol = 7))
    
    colnames(infoPooler)<- c("Nom", "Couleur", "tabStatsAtt", "tabStatsDef", "tabStatsGardien" ,"tabEvoPosition", "password")
    dbWriteTable(con, "infoPoolers", infoPooler, append = T)
  }
  
  
  infoAtt<- subset(infoAlignement, POS == "Att")
  infoDef<- subset(infoAlignement, POS == "Def")
  infoGardien<- subset(infoAlignement, POS == "G")
  
  infoAttInit <- data.frame(cbind(infoAtt, matrix(rep(0,72),12,6),matrix(rep(as.character(Sys.Date( )),24),12,2)))
  colnames(infoAttInit) <- c("Joueurs", "Equipe" ,"Statues","Position", "GP" ,"Buts", "Passes", 
                                "Parties_Init", "Buts_Init", "Passes_Init", "DateDerniereModif", "DateEntreeAlignement")
  
  infoDefInit <- data.frame(cbind(infoDef, matrix(rep(0,36),6,6),matrix(rep(as.character(Sys.Date( )),12),6,2)))
  colnames(infoDefInit) <- c("Joueurs", "Equipe" ,"Statues","Position", "GP" ,"Buts", "Passes", 
                             "Parties_Init", "Buts_Init", "Passes_Init", "DateDerniereModif", "DateEntreeAlignement")
  
  
  infoGardienInit <- data.frame(cbind(infoGardien, matrix(rep(0,36),3,12), matrix(rep(as.character(Sys.Date( )),6),3,2)))
  colnames(infoGardienInit) <- c("Joueurs", "Equipe" ,"Statues","Position", "GP", "Win", "OL", "BL", "Buts", "Passes", 
                                "GP_Init", "Win_Init", "OL_Init", "BL_Init", "Buts_Init", "Passes_Init" ,"DateDerniereModif", "DateEntreeAlignement")
  
  dbWriteTable(con, paste0("statsAtt", poolerName), infoAttInit)
  dbWriteTable(con, paste0("statsDef", poolerName), infoDefInit)
  dbWriteTable(con, paste0("statsGardiens", poolerName), infoGardienInit)
  
}


#infoAlignement<- createAleatoireTeam()
#createPoolers("Xav", "Rouge" , infoAlignement)

#infoAlignement<- createAleatoireTeam()
#createJsonPoolers("Alex", "Bleu" , infoAlignement)

#infoAlignement<- createAleatoireTeam()
#createJsonPoolers("Rich", "Orange" , infoAlignement)
