dbListTables(con)

dbReadTable(con, "statsJoueurs")

dbListTables(con)
dbReadTable(con, "infoPoolers")

#dbRemoveTable(con,"infoPoolers")
dbExistsTable(con,"statsGardienRich")

dbReadTable(con, "statsJoueurs")
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



a<-matrix(c(1,2,3,4),2,2)

colnames(a)<- c("Allo1", "Allo2")
rownames(a)<- c("Yolo1", "Yolo2")

a<-as.data.frame(a)

dbWriteTable(con, "test", a)
dbReadTable(con,"test")
dbReadTable(con, "evoPointsTotal")


a<- matrix(c("!updatePool2."))
colnames(a)<- "password"
a
as.data
dbWriteTable(con, "UpdatePassword", as.data.frame(a))
