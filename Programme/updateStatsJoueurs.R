

source(paste0(getwd(), "/Programme/BaseDonnee.R"))
source(paste0(getwd(), "/Programme/ImportJoueurGardienStats.R"))

shell.exec(paste0(getwd(), "/Data/NHL/runUpdate.bat"))

updateJoueurGardienStats<-function(){
  statsJoueurs<- reqStatsJoueursNHL()
  statsGardien<- reqStatsGardienNHL()
  
  dbWriteTable(con, "statsJoueurs", statsJoueurs, overwrite = T)
  dbWriteTable(con, "statsGardiens", statsGardien, overwrite = T)
}

updateJoueurGardienStats()



