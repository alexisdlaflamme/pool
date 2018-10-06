

#Permet de générer une matrice avec différents classements



classementAttPoolers<- function(){
  table<- dbReadTable(con,"infoPoolers")
  Nom<- table$Nom
  Couleur<- table$Couleur
  classementAttaquant<-c()
  
  for (i in Nom){
    classementAttaquant<- append(classementAttaquant,sum(miseEnFormeStatsAttPoolers(i)$PTS, na.rm = T))
  }
  tabFinal<- as.data.frame(cbind(Nom, Couleur, classementAttaquant))
  tabFinal$classementAttaquant<- as.numeric(as.character(tabFinal$classementAttaquant))
  
  return(tabFinal[order(tabFinal$classementAttaquant),])
}

classementDefPoolers<- function(){
  table<- dbReadTable(con,"infoPoolers")
  Nom<- table$Nom
  Couleur<- table$Couleur
  classementDefenseur<-c()
  
  for (i in Nom){
    classementDefenseur<- append(classementDefenseur,sum(miseEnFormeStatsDefPoolers(i)$PTS, na.rm = T))
  }
  tabFinal<- as.data.frame(cbind(Nom, Couleur, classementDefenseur))
  tabFinal$classementDefenseur<- as.numeric(as.character(tabFinal$classementDefenseur))
  
  return(tabFinal[order(tabFinal$classementDefenseur),])
}


classementGardiensPoolers<- function(){
  table<- dbReadTable(con,"infoPoolers")
  Nom<- table$Nom
  Couleur<- table$Couleur
  classementGardiens<- c()
  
  for (i in Nom){
    classementGardiens<- append(classementGardiens,sum(miseEnFormeStatsGardiensPoolers(i)$PTS, na.rm = T))
  }
  tabFinal<- as.data.frame(cbind(Nom, Couleur, classementGardiens))
  tabFinal$classementGardiens<- as.numeric(as.character(tabFinal$classementGardiens))
  
  return(tabFinal[order(tabFinal$classementGardiens),])
}

classementPoolersTotal<-function(){
  table<- dbReadTable(con,"infoPoolers")
  Nom<- table$Nom
  Couleur<- table$Couleur
  classementTotal<- c()
  
  for (i in Nom){
    classementTotal<- append(classementTotal,sum(sum(miseEnFormeStatsAttPoolers(i)$PTS, na.rm = T)
                                                      ,sum(miseEnFormeStatsDefPoolers(i)$PTS, na.rm = T)
                                                      ,sum(miseEnFormeStatsGardiensPoolers(i)$PTS, na.rm = T)))
  }
  tabFinal<- as.data.frame(cbind(Nom, Couleur, classementTotal))
  tabFinal$classementTotal<- as.numeric(as.character(tabFinal$classementTotal))
  
  return(tabFinal[order(tabFinal$classementTotal),])
}

classementGamePlayPoolers<- function(){
  table<- dbReadTable(con,"infoPoolers")
  Nom<- table$Nom
  Couleur<- table$Couleur
  classementGP<-c()
  
  for (i in Nom){
    classementGP<- append(classementGP,sum(sum(miseEnFormeStatsAttPoolers(i)$GP, na.rm = T)
                                           ,sum(miseEnFormeStatsDefPoolers(i)$GP, na.rm = T)
                                           ,sum(miseEnFormeStatsGardiensPoolers(i)$GP, na.rm = T)))
  }
  tabFinal<- as.data.frame(cbind(Nom, Couleur, classementGP))
  tabFinal$classementGP<- as.numeric(as.character(tabFinal$classementGP))
  
  return(tabFinal[order(tabFinal$classementGP),])
}

classementPoolersPtsGP<-function(){
  table<- dbReadTable(con,"infoPoolers")
  Nom<- table$Nom
  Couleur<- table$Couleur
  classementTotal<- c()
  classementGP<-c()
  
  for (i in Nom){
    classementTotal<- append(classementTotal,sum(sum(miseEnFormeStatsAttPoolers(i)$PTS, na.rm = T)
                                                 ,sum(miseEnFormeStatsDefPoolers(i)$PTS, na.rm = T)
                                                 ,sum(miseEnFormeStatsGardiensPoolers(i)$PTS, na.rm = T)))
    
    classementGP<- append(classementGP,sum(sum(miseEnFormeStatsAttPoolers(i)$GP, na.rm = T)
                                           ,sum(miseEnFormeStatsDefPoolers(i)$GP, na.rm = T)
                                           ,sum(miseEnFormeStatsGardiensPoolers(i)$GP, na.rm = T)))
  }
  classementPtsGP<- round(as.numeric(as.character(classementTotal)) / as.numeric(as.character(classementGP)), 3)
  
  tabFinal<- as.data.frame(cbind(Nom, Couleur, classementPtsGP))
  tabFinal$classementPtsGP<- as.numeric(as.character(tabFinal$classementPtsGP))
  
  return(tabFinal[order(tabFinal$classementPtsGP),])
}
