gestion <- function(s,name,Pos){
  if( Pos == "Attaquants" ){
    a<- 0
    b<- 0
    bool <- FALSE
    changeActif<-dbReadTable(con, paste0("statsAtt", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        if (changeActif[i,3] == 'Actif'){
          a <- a+1

        }
        else if(changeActif[i,3] == 'Backup' ){
          b <- b+1
 
        }
        else{
          bool <- TRUE
        }
      }
    }
    if ((a == b) && (bool == FALSE)){
      return(TRUE)
    }
    else{
      return(FALSE)
    }
  }
  if( Pos == "Defenseurs" ){
    a<- 0
    b<- 0
    bool <- FALSE
    changeActif<-dbReadTable(con, paste0("statsDef", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        if (changeActif[i,3] == 'Actif'){
          a <- a+1

        }
        else if(changeActif[i,3] == 'Backup' ){
          b <- b+1

        }
        else{
          bool <- TRUE
        }
      }
    }
    if ((a == b) && (bool == FALSE)){
      return(TRUE)
    }
    else{
      return(FALSE)
    }
  }
  if( Pos == "Gardiens" ){
    a<- 0
    b<- 0
    bool <- FALSE
    changeActif<-dbReadTable(con, paste0("statsGardiens", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        if (changeActif[i,3] == 'Actif'){
          a <- a+1

        }
        else if(changeActif[i,3] == 'Backup' ){
          b <- b+1

        }
        else{
          bool <- TRUE
        }
      }
    }
    if ((a == b) && (bool == FALSE)){
      
      return(TRUE)
    }
    else{
      return(FALSE)
    }
  }
}
dataJoueur <- function(s,name,pos){
  if (pos == "Attaquants"){
    changeActif<-dbReadTable(con, paste0("statsAtt", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        if (changeActif[i,3] == 'Actif'){
          changeActif[i,3] <- 'Inactif'
        }
        else {
          changeActif[i,3] <- 'Actif'
        }
  
      }
    }
    return(changeActif)
  }
  if (pos == "Defenseurs"){
    changeActif<-dbReadTable(con, paste0("statsDef", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        if (changeActif[i,3] == 'Actif'){
          changeActif[i,3] <- 'Inactif'
        }
        else {
          changeActif[i,3] <- 'Actif'
        }
        
      }
    }
    return(changeActif)
  }
  if (pos == "Gardiens"){
    changeActif<-dbReadTable(con, paste0("statsGardiens", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        if (changeActif[i,3] == 'Actif'){
          changeActif[i,3] <- 'Inactif'
        }
        else {
          changeActif[i,3] <- 'Actif'
        }
        
      }
    }
    return(changeActif)
  }
}
Joueurnew <- function(s,name,pos,statue){
  if ( pos == "Attaquants"){
    changeActif<-dbReadTable(con, paste0("statsAtt", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        changeActif[i,3] <- statue
      }      
    }
    dbWriteTable(con,paste0("statsAtt",name),changeActif,overwrite = T)
  }
  if ( pos == "Defenseurs"){
    changeActif<-dbReadTable(con, paste0("statsDef", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        changeActif[i,3] <- statue
      }      
    }
    dbWriteTable(con,paste0("statsDef",name),changeActif,overwrite = T)
  }
  if ( pos == "Gardiens"){
    changeActif<-dbReadTable(con, paste0("statsGardiens", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        changeActif[i,3] <- statue
      }      
    }
    dbWriteTable(con,paste0("statsGardiens",name),changeActif,overwrite = T)
  }
}
NbreNew <- function(s,name,pos){
  if ( pos == "Attaquants"){
    n <- 0
    changeActif<-dbReadTable(con, paste0("statsAtt", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        if (changeActif[i,3] == "New"){
          n <- n +1
        }
      }      
    }
    if (n == length((s))){
      return(TRUE)
    }
    else{
      return(FALSE)
    }

  }
  if ( pos == "Defenseurs"){
    n <- 0
    changeActif<-dbReadTable(con, paste0("statsDef", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        if (changeActif[i,3] == "New"){
          n <- n +1
        }
      }      
    }
    if (n == length((s))){
      return(TRUE)
    }
    else{
      return(FALSE)
    }

    
  }
  if ( pos == "Gardiens"){
    n <- 0
    changeActif<-dbReadTable(con, paste0("statsGardiens", name))
    for( i in 1:length(changeActif[,1])){
      if (changeActif[i,1] %in% s){
        if (changeActif[i,3] == "New"){
          n <- n +1
        }
      }      
    }
    if (n == length((s))){
      return(TRUE)
    }
    else{
      return(FALSE)
    }

  }

}
  