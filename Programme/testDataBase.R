dbListTables(con)

test<-dbReadTable(con, "statsJoueurs")

dbListTables(con)

dbReadTable(con,"infoPoolers")
#dbRemoveTable(con,"infoPoolers")
dbExistsTable(con,"statsGardienRich")

dbReadTable(con, "statsDefAlex")
dbReadTable(con, "statsAttRich")
dbReadTable(con, "statsDefRich")
dbReadTable(con, "statsAttAlex")

dbReadTable(con, "infoEchange")





##Initialisation table infoEchange
infoEchanges<- data.frame(matrix(rep(NA,8),1,8))
colnames(infoEchanges)<- c("Num", "Poolers1", "Joueurs acquis 1", "Echange", "Joueurs acquis 2", "Poolers2", "Date", "Statue") 
infoEchanges
#dbWriteTable(con, "infoEchange" ,infoEchanges, overwrite = T )