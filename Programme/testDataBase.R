dbListTables(con)

test<-dbReadTable(con, "statsJoueurs")

dbListTables(con)


#dbRemoveTable(con,"infoPoolers")
dbExistsTable(con,"statsGardienRich")

dbReadTable(con, "statsDefAlex")
dbReadTable(con, "statsAttRich")
dbReadTable(con, "statsDefRich")
dbReadTable(con, "statsAttXav")
dbReadTable(con, "statsGardiensXav")

dbReadTable(con, "infoEchange")

dbReadTable(con,"ConfirmeEchange1")

##Initialisation table infoEchange

infoEchanges<- data.frame(matrix(rep(NA,8),1,8))
colnames(infoEchanges)<- c("Num", "Poolers1", "Joueurs_offert_1", "Echange", "Joueurs_offert_2", "Poolers2", "Date", "Statue") 
infoEchanges
#dbWriteTable(con, "infoEchange" ,infoEchanges, overwrite = T )

!dbExistsTable(con, "Allo")

##Ajout password temp

test<- dbReadTable(con,"infoPoolers")[,-7]
a<-matrix(c("allo1", "allo2", "allo3", 'allo4', "allo5"),5, 1)
colnames(a)<- c("password")
dbWriteTable(con, "infoPoolers", cbind(test,a), overwrite = T)
