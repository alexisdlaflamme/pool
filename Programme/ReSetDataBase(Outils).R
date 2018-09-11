source(paste0(DirPGM,"CreatePooler.R"))
source(paste0(DirPGM,"MiseAJourPtsPoolers.R"))
source(paste0(DirPGM,"UpdateStatsJoueurgardiens.R"))

source(paste0(DirPGM,"InitTableauDeBase.R"))

UpdateStatsAttDefNHL()
UpdateStatsGardiens()

#Création de poolers fictif
infoAlignement<- createAleatoireTeam()
createPoolers("Xav", "red" , infoAlignement, "allo1")

infoAlignement<- createAleatoireTeam()
createPoolers("Alex", "blue" , infoAlignement, "allo2")

infoAlignement<- createAleatoireTeam()
createPoolers("Rich", "orange" , infoAlignement, "allo3")

#Mise à jour de leur pts

miseAJourPtsPoolers("Rich")
miseAJourPtsPoolers("Alex")
miseAJourPtsPoolers("Xav")
