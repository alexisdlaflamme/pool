#Initialise Tableau InfoPoolers

if (!dbExistsTable(con, "infoPoolers")){

  infoPooler<- as.data.frame(matrix(c(rep(NA,7)), nrow = 1, ncol = 7))
  colnames(infoPooler)<- c("Nom", "Couleur", "tabStatsAtt", "tabStatsDef", "tabStatsGardien" ,"tabEvoPosition", "password")
  dbWriteTable(con, "infoPoolers", infoPooler, overwrite = T)

}

#Initialise Tableau infoEchange

if (!dbExistsTable(con,"infoEchange")){

  infoEchanges<- data.frame(matrix(rep(NA,8),1,8))
  colnames(infoEchanges)<- c("Num", "Poolers1", "Joueurs_offert_1", "Echange", "Joueurs_offert_2", "Poolers2", "Date", "Statue") 
  dbWriteTable(con, "infoEchange" ,infoEchanges, overwrite = T )

}