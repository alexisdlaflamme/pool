dbListTables(con)

dbReadTable(con, "statsJoueurs")

dbListTables(con)
dbReadTable(con, "infoPoolers")

#dbRemoveTable(con,"infoPoolers")
dbReadTable(con,"statsGardiensRich")

dbReadTable(con, "statsJoueurs")

#modif<- dbReadTable(con, "statsAttXavier")
#modif[9,3]<- "Actif"
#modif[9,c(5:10)]<- c(3,3,3,3,3,3)
#dbWriteTable(con, "statsAttXavier" ,modif, overwrite = T )

dbReadTable(con, "statsDefXavier")
dbReadTable(con, "statsGardiensAlexis")



dbReadTable(con,"ConfirmeEchange1")

##Initialisation table infoEchange

statsAttAlexis<- dbReadTable(con,"statsAttAlexis")



#Joueurs<- c("John Tavares", "Aleksander Barkov", "Artemi Panarin", "Patrick Kane", "Nicklas Backstrom", "Leon Draisaitl", "Jonathan Huberdeau",
#            "Brock Boeser", "Clayton Keller", "Brayden Point", "Matthew Tkachuk", "William Nylander", "Nico Hischier", "Bryan Little", "Reilly Smith")
#statsAttAlexis[,3]<- c(rep("Actif",11), "Backup", "Actif", "Backup", "Backup")
#dbWriteTable(con, "statsAttAlexis" ,statsAttAlexis, overwrite = T )
#dbWriteTable(con, "infoEchange" ,infoEchanges, overwrite = T )

!dbExistsTable(con, "Allo")

##Ajout password temp

#test<- dbReadTable(con,"infoPoolers")[,-7]
#a<-matrix(c("allo1", "allo2", "allo3", 'allo4', "allo5"),5, 1)
#colnames(a)<- c("password")
#dbWriteTable(con, "infoPoolers", cbind(test,a), overwrite = T)



a<-matrix(c(1,2,3,4),2,2)

colnames(a)<- c("Allo1", "Allo2")
rownames(a)<- c("Yolo1", "Yolo2")

a<-as.data.frame(a)

dbReadTable(con,"test")
dbReadTable(con, "evoPointsTotal")


a<- matrix(c("!updatePool2."))
colnames(a)<- "password"
a
as.data
#dbWriteTable(con, "UpdatePassword", as.data.frame(a))
