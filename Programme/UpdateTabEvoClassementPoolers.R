updateEvo<- function(listNomPoolers){
  
  createUnexistingEvoTable(listNomPoolers)
  updateEvoPtsTotal(listNomPoolers)
  updateEvoPtsJours(listNomPoolers)
}



createUnexistingEvoTable<- function(listNomPoolers){
  
  if (!dbExistsTable(con, "evoPointsTotal")){
    evoPointsTotal<- data.frame(matrix(listNomPoolers, ncol = 1))
    colnames(evoPointsTotal)<- c("nomPoolers")
    dbWriteTable(con, "evoPointsTotal", evoPointsTotal, overwrite = T)
  }
  
  if(!dbExistsTable(con, "evoPtsJours")){
    evoPtsJours<- evoPointsTotal<- data.frame(matrix(c(listNomPoolers,rep(0, length(listNomPoolers))), ncol = 2))
    colnames(evoPtsJours)<- c("nomPoolers", as.character(Sys.Date( )))
    dbWriteTable(con, "evoPtsJours", evoPtsJours, overwrite = T)
  }
}


updateEvoPtsTotal<- function(listNomPoolers){

  classementTotal<- classementPoolersTotal()
  evoPtsTotal<- dbReadTable(con, "evoPointsTotal")
  
  evoPtsTotalNewCol<- matrix(rep(NA,length(classementTotal$Nom)), ncol = 1)
  colnames(evoPtsTotalNewCol)<- as.character(Sys.Date( ))

  for (nom in classementTotal$Nom){
    indexClassement<- match(nom, classementTotal$Nom)
    indexEvo<- match(nom, evoPtsTotal$nomPoolers)
    
    evoPtsTotalNewCol[indexEvo,1]<- classementTotal[indexClassement,3]
  }
  
  if (as.character(Sys.Date( )) %in% colnames(evoPtsTotal)){
    indexCol <- match(as.character(Sys.Date( )), colnames(evoPtsTotal))
    evoPtsTotal[,indexCol]<- as.data.frame(evoPtsTotalNewCol)
  }
  
  evoPtsTotal<- cbind(evoPtsTotal, as.data.frame(evoPtsTotalNewCol))
  
  dbWriteTable(con, "evoPointsTotal", evoPtsTotal, overwrite = T)
  
}


updateEvoPtsJours<- function(listNomPoolers){
  
  evoPtsTotal<- dbReadTable(con, "evoPointsTotal")
  evoPtsJours<- dbReadTable(con, "evoPtsJours")
  
  lastDateTotal<- as.Date(gsub('X', "", gsub(".","-",colnames(evoPtsTotal)[ncol(evoPtsTotal)], fixed = T)))
  lastDateJours<- as.Date(gsub('X', "", gsub(".","-",colnames(evoPtsJours)[ncol(evoPtsJours)], fixed = T)))
  
  if (lastDateTotal > lastDateJours){
    
    if (ncol(evoPtsTotal) == 2){
      lastDatePtsJour<- c(rep(0, nrow(evoPtsTotal)))
    }else{
        lastDatePtsJour<- evoPtsTotal[,ncol(evoPtsTotal) - 1]
    }
    
    newPtsJours<- evoPtsTotal[,ncol(evoPtsTotal)] - lastDatePtsJour
    newPtsJours<- data.frame(matrix(newPtsJours, ncol = 1))
    colnames(newPtsJours)<- as.character(Sys.Date( ))
    
    dbWriteTable(con, "evoPtsJours", cbind(evoPtsJours, newPtsJours) , overwrite = T)
  }
  
}



