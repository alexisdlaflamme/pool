addNewPropositionEchange<- function(nomJoueur1, listJoueursEchange1, nomJoueur2, listJoueursEchange2){
  
  strListeJoueurs1<- listJoueursEchange1[1]
  strListeJoueurs2<- listJoueursEchange2[1]
  for (i in 2:length(listJoueursEchange1)){
    if (listJoueursEchange1[i] != strListeJoueurs1 & !is.na(listJoueursEchange1[i])){
      strListeJoueurs1<- paste(strListeJoueurs1, listJoueursEchange1[i], sep = ", ")
    }
    if (listJoueursEchange2[i] != strListeJoueurs2 & !is.na(listJoueursEchange2[i])){
      strListeJoueurs2<- paste(strListeJoueurs2, listJoueursEchange2[i], sep = ", ")
    }
  }
  
  newTrade<- data.frame(matrix(c(NA,nomJoueur1, strListeJoueurs1, "<---->", 
                                 strListeJoueurs2, nomJoueur2, 
                                 format(Sys.time(), "%d/%m/%Y"), "En attente"), 1,8))
  
  colnames(newTrade)<- colnames(dbReadTable(con, "infoEchange"))
  

  if (is.na(dbReadTable(con, "infoEchange")[1,1])){
    newTrade$Num<- 1
    dbWriteTable(con, "infoEchange" , newTrade, overwrite = T )
  }else{
    newTrade$Num<- length(dbReadTable(con, "infoEchange")$Num)+1
    dbWriteTable(con, "infoEchange" , newTrade, overwrite = F, append = T )
  }
  
  tabTempsConfirm<- data.frame(c(0))
  colnames(tabTempsConfirm)<- c("Confirmation")
  dbWriteTable(con, paste0("ConfirmeEchange",length(dbReadTable(con, "infoEchange")$Num)), tabTempsConfirm, overwrite = T)
}



