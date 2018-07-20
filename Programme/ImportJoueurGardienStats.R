library(readxl)

#Mise en forme du jeux de donn?es pour les stats des joueurs
reqStatsJoueursNHL<-function(){
  
  statsJoueursNHL<- paste(getwd(), "/Data/NHL/dataBaseStatsJoueur.xlsm", sep = "")

  ColTypesJoueurs = c("skip", rep("text",10) , rep("skip",17))
  ColNamesJoueurs = c("Joueurs", "Age", "Position", "Equipe", "GP", "Buts", "Passes", "PTS", "PlusMois", "PIM")
  statsJoueurs <- read_excel(statsJoueursNHL, sheet = "Joueurs", col_types = ColTypesJoueurs, col_names = ColNamesJoueurs, skip = 1)
  statsJoueurs<-subset(statsJoueurs, Joueurs != "Player")
  statsJoueurs[,c(2,5:10)] <-sapply(statsJoueurs[,c(2,5:10)], as.numeric)
  
  return (statsJoueurs)
}
#Mise en forme du jeux de donn?es pour les stats des gardiens

reqStatsGardienNHL<-function(){
  statsJoueursNHL<- paste(getwd(), "/Data/NHL/dataBaseStatsJoueur.xlsm", sep = "")
  
  ColTypesGardiens = c("skip", rep("text",8) , rep("skip",5),"text", rep("skip", 7), rep("text",3), "skip")
  ColNamesGardiens = c("Joueurs", "Age", "Equipe", "GP", "GS", "Win", "RL", "OL", "BL", "Buts", "Passes", "PTS")
  statsGardiens <- read_excel(statsJoueursNHL, sheet = "Gardiens", col_types = ColTypesGardiens, col_names = ColNamesGardiens, skip = 1)
  statsGardiens<-subset(statsGardiens, Joueurs != "Player")
  statsGardiens[,c(2,4:12)] <-sapply(statsGardiens[,c(2,4:12)], as.numeric)
  
  return (statsGardiens)
}


