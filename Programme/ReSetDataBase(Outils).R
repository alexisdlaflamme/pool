source(paste0(DirPGM,"CreatePooler.R"))
source(paste0(DirPGM,"MiseAJourPtsPoolers.R"))
source(paste0(DirPGM,"UpdateStatsJoueurgardiens.R"))

source(paste0(DirPGM,"InitTableauDeBase.R"))

UpdateStatsAttDefNHL()
UpdateStatsGardiens()

#Initialise Tableau InfoPoolers
infoPooler<- as.data.frame(matrix(c(rep(NA,7)), nrow = 1, ncol = 7))
colnames(infoPooler)<- c("Nom", "Couleur", "tabStatsAtt", "tabStatsDef", "tabStatsGardien" ,"tabEvoPosition", "password")
dbWriteTable(con, "infoPoolers", infoPooler, overwrite = T)

#Initialise Tableau infoEchange
infoEchanges<- data.frame(matrix(rep(NA,8),1,8))
colnames(infoEchanges)<- c("Num", "Poolers1", "Joueurs_offert_1", "Echange", "Joueurs_offert_2", "Poolers2", "Date", "Statue") 
infoEchanges
dbWriteTable(con, "infoEchange" ,infoEchanges, overwrite = T )


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
