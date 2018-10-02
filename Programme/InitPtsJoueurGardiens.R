InitAttDefPtsAtToday<- function(ligneJoueur){
    
    if (!dbExistsTable(con, "statsJoueurs")){
      statsJoueursNHL<- dbReadTable(con, "statsJoueurs")
      posJoueurInStatsJoueursNHL<- match(ligneJoueur$Joueurs, statsJoueursNHL$Joueurs)
      
      if (!is.na(posJoueurInStatsJoueursNHL)){
        ligneJoueur[,8:10]<- statsJoueursNHL[posJoueurInStatsJoueursNHL, 5:7]
        ligneJoueur[,5:7]<- statsJoueursNHL[posJoueurInStatsJoueursNHL, 5:7]
    
      }else{
        ligneJoueur[,8:10]<- c(rep(0,3))
        ligneJoueur[,5:7]<- c(rep(0,3))
        
      }
    }else{
      ligneJoueur[,8:10]<- c(rep(0,3))
      ligneJoueur[,5:7]<- c(rep(0,3))
    }
    ligneJoueur[,11:12]<- rep(as.character(Sys.Date( )),2)
    return(ligneJoueur)
}

InitGardiensPtsAtToday<- function(ligneJoueur){
  
  if (!dbExistsTable(con, "statsGardiens")){
    statsGardienNHL<- dbReadTable(con, "statsGardiens")
    posJoueurInStatsGardienNHL<- match(ligneJoueur$Joueurs, statsGardienNHL$Joueurs)
    
    if (!is.na(posJoueurInStatsGardienNHL)){
      ligneJoueur[,11:16]<- statsGardienNHL[posJoueurInStatsGardienNHL, c(4,6,8:11)]
      ligneJoueur[,5:10]<- statsGardienNHL[posJoueurInStatsGardienNHL, c(4,6,8:11)]
      
    }else{
      ligneJoueur[,11:16]<- c(rep(0,6))
      ligneJoueur[,5:10]<- c(rep(0,6))
    }
  }else{
    ligneJoueur[,11:16]<- c(rep(0,6))
    ligneJoueur[,5:10]<- c(rep(0,6))
  }
  ligneJoueur[,17:18]<- rep(as.character(Sys.Date( )),2)

  return(ligneJoueur)
}

