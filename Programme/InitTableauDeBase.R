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

if (!dbExistsTable(con,"UpdatePassword")){
  
  password<- matrix(c("!updatePool2."))
  colnames(password)<- "password"
  dbWriteTable(con, "UpdatePassword", as.data.frame(password), overwrite = T)
  
}

if (!dbExistsTable(con, "evoPointsTotal")){
  listNomPoolers <- dbReadTable(con, "infoPoolers")$Nom
  evoPointsTotal<- data.frame(matrix(listNomPoolers, ncol = 1))
  colnames(evoPointsTotal)<- c("nomPoolers")
  dbWriteTable(con, "evoPointsTotal", evoPointsTotal, overwrite = T)
}

if(!dbExistsTable(con, "evoPtsJours")){
  listNomPoolers <- dbReadTable(con, "infoPoolers")$Nom
  evoPtsJours<- evoPointsTotal<- data.frame(matrix(c(listNomPoolers,rep(0, length(listNomPoolers))), ncol = 2))
  colnames(evoPtsJours)<- c("nomPoolers", as.character(Sys.Date( )))
  dbWriteTable(con, "evoPtsJours", evoPtsJours, overwrite = T)
}