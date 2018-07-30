source(paste0(DirPGM,"CreatePooler.R"))
source(paste0(DirPGM,"MiseAJourPtsPoolers.R"))
source(paste0(DirPGM,"updateStatsJoueur.R"))

#Création de poolers fictif
infoAlignement<- createAleatoireTeam()
createPoolers("Xav", "Rouge" , infoAlignement)

infoAlignement<- createAleatoireTeam()
createPoolers("Alex", "Bleu" , infoAlignement)

infoAlignement<- createAleatoireTeam()
createPoolers("Rich", "Orange" , infoAlignement)

#Mise à jour de leur pts

miseAJourPtsPoolers("Rich")
miseAJourPtsPoolers("Alex")
miseAJourPtsPoolers("Xav")
