source(paste0(DirPGM,"CreatePooler.R"))
source(paste0(DirPGM,"MiseAJourPtsPoolers.R"))
source(paste0(DirPGM,"updateStatsJoueur.R"))

#Création de poolers fictif
infoAlignement<- createAleatoireTeam()
createPoolers("Xav", "red" , infoAlignement, "allo")

infoAlignement<- createAleatoireTeam()
createPoolers("Alex", "blue" , infoAlignement, "allo")

infoAlignement<- createAleatoireTeam()
createPoolers("Rich", "orange" , infoAlignement, "allo")

#Mise à jour de leur pts

miseAJourPtsPoolers("Rich")
miseAJourPtsPoolers("Alex")
miseAJourPtsPoolers("Xav")
