##Brief: Permet de faire 3 tableaux qui seront utile pour l'interface (un tableau attaquants, un tableau defenseurs, tableau gardien)
##param(poolerName):  un string reprensentant le nom d'un pooler
miseEnFormeStatsPoolers<-function(poolerName){
  
  #Mise en forme tableau des attaquants
  infoAttaquantsPooler<- dbReadTable(con, paste0("statsAtt", poolerName))
  infoAttaquantsPooler$GP<- infoAttaquantsPooler$GP - infoAttaquantsPooler$Parties_Init
  infoAttaquantsPooler$Buts<- infoAttaquantsPooler$Buts - infoAttaquantsPooler$Buts_Init
  infoAttaquantsPooler$Passes<- infoAttaquantsPooler$Passes - infoAttaquantsPooler$Passes_Init
  PTS<- infoAttaquantsPooler$Buts + infoAttaquantsPooler$Passes
  infoAttaquantsPooler<- cbind(infoAttaquantsPooler[,c(1,2,3,5,6,7)], PTS)
  
  #Mise en forme tableau des defenseurs
  infoDefenseursPooler<- dbReadTable(con, paste0("statsDef", poolerName))
  infoDefenseursPooler$GP<- infoDefenseursPooler$GP - infoDefenseursPooler$Parties_Init
  infoDefenseursPooler$Buts<- infoDefenseursPooler$Buts * 2 - infoDefenseursPooler$Buts_Init * 2
  infoDefenseursPooler$Passes<- infoDefenseursPooler$Passes - infoDefenseursPooler$Passes_Init
  PTS<- infoDefenseursPooler$Buts + infoDefenseursPooler$Passes
  infoDefenseursPooler<- cbind(infoDefenseursPooler[,c(1,2,3,5,6,7)], PTS)
  
  #Mise en forme tableau des gardiens
  infoGardiensPooler<- dbReadTable(con, paste0("statsGardiens", poolerName))
  infoGardiensPooler$GP<- infoGardiensPooler$GP - infoGardiensPooler$GP_Init
  infoGardiensPooler$Win<- infoGardiensPooler$Win * 2 - infoGardiensPooler$Win_Init * 2
  infoGardiensPooler$OL<- infoGardiensPooler$OL - infoGardiensPooler$OL_Init
  infoGardiensPooler$BL<- infoGardiensPooler$BL - infoGardiensPooler$BL_Init
  infoGardiensPooler$Buts<- infoGardiensPooler$Buts * 3 - infoGardiensPooler$Buts_Init * 3
  infoGardiensPooler$Passes<- infoGardiensPooler$Passes * 2 - infoGardiensPooler$Passes_Init * 2
  PTS <- rowSums(infoGardiensPooler[,c(6:10)])
  infoGardiensPooler<- cbind(infoGardiensPooler[,c(1,2,3,5:10)], PTS)
  
  infoAttaquantsPooler <- infoAttaquantsPooler[order(infoAttaquantsPooler$PTS, decreasing = T),]
  infoDefenseursPooler <- infoDefenseursPooler[order(infoDefenseursPooler$PTS, decreasing = T),]
  infoGardiensPooler <- infoGardiensPooler[order(infoGardiensPooler$PTS, decreasing = T),]
  
  return (list(infoAttaquantsPooler, infoDefenseursPooler, infoGardiensPooler))
}


miseEnFormeStatsAttPoolers<- function(poolerName){
  #Mise en forme tableau des attaquants
  infoAttaquantsPooler<- dbReadTable(con, paste0("statsAtt", poolerName))
  infoAttaquantsPooler$GP<- infoAttaquantsPooler$GP - infoAttaquantsPooler$Parties_Init
  infoAttaquantsPooler$Buts<- infoAttaquantsPooler$Buts - infoAttaquantsPooler$Buts_Init
  infoAttaquantsPooler$Passes<- infoAttaquantsPooler$Passes - infoAttaquantsPooler$Passes_Init
  PTS<- infoAttaquantsPooler$Buts + infoAttaquantsPooler$Passes
  infoAttaquantsPooler<- cbind(infoAttaquantsPooler[,c(1,2,3,5,6,7)], PTS)
  infoAttaquantsPooler <- infoAttaquantsPooler[order(infoAttaquantsPooler$PTS, decreasing = T),]
  
  return(infoAttaquantsPooler)
}

miseEnFormeStatsDefPoolers<- function(poolerName){
  #Mise en forme tableau des defenseurs
  infoDefenseursPooler<- dbReadTable(con, paste0("statsDef", poolerName))
  infoDefenseursPooler$GP<- infoDefenseursPooler$GP - infoDefenseursPooler$Parties_Init
  infoDefenseursPooler$Buts<- infoDefenseursPooler$Buts * 2 - infoDefenseursPooler$Buts_Init * 2
  infoDefenseursPooler$Passes<- infoDefenseursPooler$Passes - infoDefenseursPooler$Passes_Init
  PTS<- infoDefenseursPooler$Buts + infoDefenseursPooler$Passes
  infoDefenseursPooler<- cbind(infoDefenseursPooler[,c(1,2,3,5,6,7)], PTS)
  infoDefenseursPooler <- infoDefenseursPooler[order(infoDefenseursPooler$PTS, decreasing = T),]
  
  return(infoDefenseursPooler)
}

miseEnFormeStatsGardiensPoolers<- function(poolerName){
  #Mise en forme tableau des gardiens
  infoGardiensPooler<- dbReadTable(con, paste0("statsGardiens", poolerName))
  infoGardiensPooler$GP<- infoGardiensPooler$GP - infoGardiensPooler$GP_Init
  infoGardiensPooler$Win<- infoGardiensPooler$Win * 2 - infoGardiensPooler$Win_Init * 2
  infoGardiensPooler$OL<- infoGardiensPooler$OL - infoGardiensPooler$OL_Init
  infoGardiensPooler$BL<- infoGardiensPooler$BL - infoGardiensPooler$BL_Init
  infoGardiensPooler$Buts<- infoGardiensPooler$Buts * 3 - infoGardiensPooler$Buts_Init * 3
  infoGardiensPooler$Passes<- infoGardiensPooler$Passes * 2 - infoGardiensPooler$Passes_Init * 2
  PTS <- rowSums(infoGardiensPooler[,c(6:10)])
  infoGardiensPooler<- cbind(infoGardiensPooler[,c(1,2,3,5:10)], PTS)
  infoGardiensPooler <- infoGardiensPooler[order(infoGardiensPooler$PTS, decreasing = T),]
  
  return(infoGardiensPooler)
}

