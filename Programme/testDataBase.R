dbListTables(con)

test<-dbReadTable(con, "statsJoueurs")

dbListTables(con)

dbReadTable(con,"infoPoolers")
#dbRemoveTable(con,"infoPoolers")
#dbExistsTable(con,"statsGardiens")

dbReadTable(con, "statsDefRich")
dbReadTable(con, "statsAttMaurice")

dbWriteTable()