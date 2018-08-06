source(paste0(DirPGM,"CreatePooler.R"))
source(paste0(DirPGM,"MiseAJourPtsPoolers.R"))
source(paste0(DirPGM,"updateStatsJoueur.R"))

#Création de poolers fictif
infoAlignement<- createAleatoireTeam()
createPoolers("Xav", "red" , infoAlignement)

infoAlignement<- createAleatoireTeam()
createPoolers("Alex", "blue" , infoAlignement)

infoAlignement<- createAleatoireTeam()
createPoolers("Rich", "orange" , infoAlignement)

#Mise à jour de leur pts

miseAJourPtsPoolers("Rich")
miseAJourPtsPoolers("Alex")
miseAJourPtsPoolers("Xav")
