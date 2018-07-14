library(dplyr)
library(dbplyr)
library(RSQLite)
library(DBI)

getwd()
pathBD<-"test.sqlite"
myBD<- src_sqlite(pathBD, create = TRUE)
joueur<- reqStatsJoueursNHL()
gardien<-reqStatsGardienNHL()

copy_to(myBD, joueur)
copy_to(myBD, gardien)


con = dbConnect(RSQLite::SQLite(), dbname="D:\\Projet Pool\\pool 2017-2018\\test.sqlite")
dbWriteTable(con, "joueur", joueur, overwrite = T)
dbWriteTable(con, "gardien", gardien, overwrite = T)

dbReadTable(con, table[1])

table<- dbListTables(con)
