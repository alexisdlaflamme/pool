dbListTables(con)

test<-dbReadTable(con, "statsJoueurs")

dbListTables(con)

dbReadTable(con,"infoPoolers")
#dbRemoveTable(con,"infoPoolers")
dbExistsTable(con,"statsGardienRich")

dbReadTable(con, "statsDefRich")
dbReadTable(con, "statsAttRich")
dbReadTable(con, "statsGardiensRich")

dbWriteTable()