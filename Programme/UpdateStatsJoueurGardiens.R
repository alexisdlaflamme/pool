library(XML)
library(RCurl)
library(rlist)

UpdateStatsAttDefNHL<- function(){

  theurl <- getURL("https://www.hockey-reference.com/leagues/NHL_2018_skaters.html",.opts = list(ssl.verifypeer = FALSE) )
  tables <- readHTMLTable(theurl)
  tables <- list.clean(tables, fun = is.null, recursive = FALSE)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  
  stats<-as.data.frame(tables[[which.max(n.rows)]])
  stats<- subset(stats, Player != "Player")[,c(2:11)]
  colnames(stats) = c("Joueurs", "Age", "Position", "Equipe", "GP", "Buts", "Passes", "PTS", "PlusMois", "PIM")
  stats[,c(2,5:10)] <-sapply(sapply(stats[,c(2,5:10)], as.character), as.numeric)
  
  dbWriteTable(con, "statsJoueurs", stats, overwrite = T)
  
}

UpdateStatsGardiens<- function(){
  
  theurl <- getURL("https://www.hockey-reference.com/leagues/NHL_2018_goalies.html",.opts = list(ssl.verifypeer = FALSE) )
  tables <- readHTMLTable(theurl)
  tables <- list.clean(tables, fun = is.null, recursive = FALSE)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  
  stats<-as.data.frame(tables[[which.max(n.rows)]])
  stats<- subset(stats, Player != "Player")[,c(2:9, 15, 23:25)]
  colnames(stats)<- c("Joueurs", "Age", "Equipe", "GP", "GS", "Win", "RL", "OL", "BL", "Buts", "Passes", "PTS")
  stats[,c(2,4:12)] <-sapply(sapply(stats[,c(2,4:12)], as.character), as.numeric)
  
  dbWriteTable(con, "statsGardiens", stats, overwrite = T)
}

