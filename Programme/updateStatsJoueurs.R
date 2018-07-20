library("sqldf")

source(paste0(getwd(), "/Programme/BaseDonnee.R"))
source(paste0(getwd(), "/Programme/ImportJoueurGardienStats.R"))

shell.exec(paste0(getwd(), "/Data/NHL/runUpdate.bat"))

updateJoueurGardienStats<-function(){
  statsJoueurs<- reqStatsJoueursNHL()
  statsGardien<- reqStatsGardienNHL()
  
  dbWriteTable(con, "Stats Joueurs", statsJoueurs, overwrite = T)
  dbWriteTable(con, "Stats Gardiens", statsGardien, overwrite = T)
}

dbCreateTable(con, "Test", c(a = "char"))

sqldf(" drop table if exists Info Poolers", connection = con)

dbAppendTable(con, "InfoPoolers", value = colnames(as.data.frame("allo"))<- "a")

if (dbExistsTable(con, c("Info Poolers")) == T){
  
  
}

