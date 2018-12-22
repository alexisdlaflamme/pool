
server <- function(input, output, session) {
  
  ######################
  # Creation graphique #
  ######################
  
#  output$graph_total <- renderPlot({
#    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
#      classement<- classementPoolersTotal()
#      bp<-barplot(classement[,3], plot = F)
#      colnames(bp)<- "y"
#      barplot(classement[,3],xlab = 'Points',
#              main = 'Classement General',
#              col = as.character(classement[,2]), border = "black",horiz=TRUE,beside = TRUE,
#              names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
#      par(xpd=T)
#      text(cbind(classement[,3],bp),labels=classement[,3],pos=4)
#      box()
#    }
# })
  
  output$graph_total <- renderPlotly({
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      classement<- classementPoolersTotal()
      classement$Nom<- factor(classement$Nom, levels =classement$Nom) #Création d'un facteur pour avoir le bon ordre dans le graphique

      plot_ly(classement, x = ~classementTotal, y = ~Nom , type="bar", orientation = 'h',
              marker = list(color = ~Couleur)) %>%
        layout(title = "Classement General",
               xaxis = list("Nom"),
               yaxis = list("Points"))
      
      
      par(xpd=T)
      #text(cbind(classement[,3],bp),labels=classement[,3],pos=4)
      box()
    }
  })
  
  
  output$graph_attaquant <- renderPlot({ # on fait appel ? la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      classement<- classementAttPoolers()
      bp<-barplot(classement[,3], plot = F)
      colnames(bp)<- "y"
      barplot(classement[,3],xlab = 'Points',
              main = 'Classement Attaquants',
              col = as.character(classement[,2]), border = "black",horiz=TRUE,beside = TRUE,
              names.arg= as.character(classement[,1]), las = 1,xlim =c(0,max(classement[,3])*1.2))
      par(xpd=T)
      text(cbind(classement[,3],bp),labels=classement[,3],pos=4)
      box()
    }
  })
  
  output$graph_defensseur <- renderPlot({ 
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      classement<- classementDefPoolers()
      bp<-barplot(classement[,3], plot = F)
      colnames(bp)<- "y"
      barplot(classement[,3],xlab = 'Points',
                main = 'Classement Defenseurs',
                col = as.character(classement[,2]), border = "black",horiz=TRUE,beside = TRUE,
                names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
      par(xpd=T)
      text(cbind(classement[,3],bp),labels=classement[,3],pos=4)
      box()
    }
  })
  
  output$graph_gardien <- renderPlot({ # on fait appel ? la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      classement<- classementGardiensPoolers()
      bp<-barplot(classement[,3], plot = F)
      colnames(bp)<- "y"
      barplot(classement[,3],xlab = 'Points',
              main = 'Classement Gardiens',
              col = as.character(classement[,2]), border = "black",horiz=TRUE,beside = TRUE,
              names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
      par(xpd=T)
      text(cbind(classement[,3],bp),labels=classement[,3],pos=4)
      box()
    }
  })
  
  output$graph_GP <- renderPlot({ 
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      classement<- classementGamePlayPoolers()
      bp<-barplot(classement[,3], plot = F)
      colnames(bp)<- "y"
      barplot(classement[,3],xlab = 'Points',
              main = 'Classement Match Jouer',
              col = as.character(classement[,2]), border = "black",horiz=TRUE,beside = TRUE,
              names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
      par(xpd=T)
      text(cbind(classement[,3],bp),labels=classement[,3],pos=4)
      box()
    }
  })
  
  output$graph_PtsGP <- renderPlot({ 
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      classement<- classementPoolersPtsGP()
      bp<-barplot(classement[,3], plot = F)
      colnames(bp)<- "y"
      barplot(classement[,3],xlab = 'Points',
              main = 'Classement Match Jouer',
              col = as.character(classement[,2]), border = "black",horiz=TRUE,beside = TRUE,
              names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
      par(xpd=T)
      text(cbind(classement[,3],bp),labels=classement[,3],pos=4)
      box()
    }
  })
  
  lapply(1:length(dbReadTable(con,"evoPtsJours")[,1]), function(i) {
    
    output[[paste0("PtsJours",dbReadTable(con,"evoPtsJours")[i,1])]] <- renderPlot({
      
      pts <- as.numeric(dbReadTable(con,"evoPtsJours")[i,(2:length(dbReadTable(con,"evoPtsJours")))])
      name <- colnames(dbReadTable(con,"evoPtsJours")[2:length(dbReadTable(con,"evoPtsJours"))])
      bp<-barplot(pts, plot = F)
      colnames(bp)<- "y"
      barplot(pts,main = paste0("Points Quotidien ",dbReadTable(con,"evoPtsJours")[i,1]),
              names.arg = name,las = 3, ylim = c(0,35))
      par(xpd=T)
      #text(cbind(bp,pts),labels=pts,pos=2)
      box()
      
    })
  })
  

  ###########################
  # Affichage Stats Poolers #
  ###########################
  
  
  lapply(c("statsJoueursPooler", "statsDefenseursPooler", "statsGardiensPooler"), function(i){
    output[[i]] <- DT::renderDataTable({
      if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
        if (i == "statsJoueursPooler"){
          statsPoolersChoisi <- miseEnFormeStatsAttPoolers(input$statsPoolers)
          datatable(statsPoolersChoisi,options = list("pageLength" = length(statsPoolersChoisi[,1]), dom = 't')
                    , rownames = F, selection = "none")
        }
        else if (i == "statsDefenseursPooler"){
          statsPoolersChoisi <- miseEnFormeStatsDefPoolers(input$statsPoolers)
          datatable(statsPoolersChoisi,options = list("pageLength" = length(statsPoolersChoisi[,1]), dom = 't')
                    , rownames = F, selection = "none")
        }
        else if (i == "statsGardiensPooler"){
          statsPoolersChoisi <- miseEnFormeStatsGardiensPoolers(input$statsPoolers)
          datatable(statsPoolersChoisi,options = list("pageLength" = length(statsPoolersChoisi[,1]), dom = 't')
                    , rownames = F, selection = "none")
        }
      }
    })
  })
  
  ######################
  ##Gestion alignement##
  ######################
  output$statsJoueursAlignement<- DT::renderDataTable({
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      if( input$Position == 'Attaquants'){
        Pooler <- miseEnFormeStatsAttPoolers(input$PoolerName)
      }
      else if (input$Position == 'Defenseurs'){
        Pooler <- miseEnFormeStatsDefPoolers(input$PoolerName)
      }
      else if (input$Position == 'Gardiens'){
        Pooler <- miseEnFormeStatsGardiensPoolers(input$PoolerName)
      }
      datatable(Pooler,options = list("pageLength" = length(Pooler[,1]), dom = 't'),rownames = FALSE,
                selection =list(mode = 'multiple',target = 'row'))
    }
  })
  
  output$Selection <- DT::renderDataTable({
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      s<- input$statsJoueursAlignement_rows_selected
      if( input$Position == 'Attaquants'){
        Pooler <- miseEnFormeStatsAttPoolers(input$PoolerName)
      }
      else if (input$Position == 'Defenseurs'){
        Pooler <- miseEnFormeStatsDefPoolers(input$PoolerName)
      }
      else if (input$Position == 'Gardiens'){
        Pooler <- miseEnFormeStatsGardiensPoolers(input$PoolerName)
      }
      datatable(Pooler[s,c(1,3)],options = list(dom = 't'),style = 'material')
    }
  })
  
  observeEvent(input$Confirm, {
    motDePasse <- input$password
    if (motDePasse != dbReadTable(con,"infoPoolers")[dbReadTable(con,"infoPoolers")$Nom == input$PoolerName,7] ){
      showNotification("Mauvais mot de passe",type = "error")
    }
    else if (input$OptionNew == "Gestion Alignement"){
      if( input$Position == 'Attaquants'){
        Pooler <- miseEnFormeStatsAttPoolers(input$PoolerName)
      }
      else if (input$Position == 'Defenseurs'){
        Pooler <- miseEnFormeStatsDefPoolers(input$PoolerName)
      }
      else if (input$Position == 'Gardiens'){
        Pooler <- miseEnFormeStatsGardiensPoolers(input$PoolerName)
      }
      d<-input$statsJoueursAlignement_rows_selected
      s<- Pooler[d,1]
      name<- input$PoolerName
      pos <- input$Position
      if (gestion(s,name,pos) == F){
        showNotification("Mouvement impossible",type = "message")
      }
      else {
        if ((gestion(s,name,pos) == T) && (input$Position == "Attaquants")){
          player <- dataJoueur(s,name,pos)
          dbWriteTable(con,paste0('statsAtt',input$PoolerName),player,overwrite = T)
          
        }
        else if ((gestion(s,name,pos) == T) && (input$Position == "Defenseurs")){
          player <- dataJoueur(s,name,pos)
          dbWriteTable(con,paste0('statsDef',input$PoolerName),player,overwrite = T)
          
        }
        else{
          player <- dataJoueur(s,name,pos)
          dbWriteTable(con,paste0('statsGardiens',input$PoolerName),player,overwrite = T)
        }
        
        output$statsJoueursAlignement<- DT::renderDataTable({
          if (input$Position == "Attaquants"){
            joueur <- miseEnFormeStatsAttPoolers(input$PoolerName)
          }
          if (input$Position == "Defenseurs"){
            joueur <- miseEnFormeStatsDefPoolers(input$PoolerName)
          }
          if (input$Position == "Gardiens"){
            joueur <- miseEnFormeStatsGardiensPoolers(input$PoolerName)
          }
          datatable(joueur,
                    options = list("pageLength" = length(joueur[,1]),
                                   dom = 't'),rownames = FALSE)
          
        })
      }
      
    }
    else{
      if( input$Position == 'Attaquants'){
        Pooler <- miseEnFormeStatsAttPoolers(input$PoolerName)
      }
      else if (input$Position == 'Defenseurs'){
        Pooler <- miseEnFormeStatsDefPoolers(input$PoolerName)
      }
      else if (input$Position == 'Gardiens'){
        Pooler <- miseEnFormeStatsGardiensPoolers(input$PoolerName)
      }
      d<-input$statsJoueursAlignement_rows_selected
      s<- Pooler[d,1]
      name<- input$PoolerName
      pos <- input$Position
      statue <- input$StatueNew
      if (NbreNew(s,name,pos) == F){
        showNotification("Mouvement impossible",type = "message")
      }
      else{
        Joueurnew(s,name,pos,statue)
        output$statsJoueursAlignement<- DT::renderDataTable({
          if (input$Position == "Attaquants"){
            joueur <- miseEnFormeStatsAttPoolers(input$PoolerName)
          }
          if (input$Position == "Defenseurs"){
            joueur <- miseEnFormeStatsDefPoolers(input$PoolerName)
          }
          if (input$Position == "Gardiens"){
            joueur <- miseEnFormeStatsGardiensPoolers(input$PoolerName)
          }
          datatable(joueur,
                    options = list("pageLength" = length(joueur[,1]),
                                   dom = 't'),rownames = FALSE)
          
        })
      }
    }
  })
  
  ############
  # Échange  #
  ############

  
  lapply(c("listJoueur1", "listJoueur2"), function(i){
      output[[i]]<- renderUI({
        if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
          if (i == "listJoueur1"){
            nom <- input$nomPoolers1
          } else{
            nom <- input$nomPoolers2
          }
          
          ###Faire en sorte de ne prendre seulement les joueurs qui n'ont pas été trade #######
          att<- dbReadTable(con, paste0("statsAtt", nom))
          attValidToTrade<- matrix(att[att$Statues %in% c("Actif", "Inactif", "Backup"),]$Joueur, ncol=1)
          def<-dbReadTable(con, paste0("statsDef", nom))
          defValidToTrade<- matrix(def[def$Statues %in% c("Actif", "Inactif", "Backup"),]$Joueur, ncol=1)
          gardiens<- dbReadTable(con, paste0("statsGardiens", nom))
          gardiensValidToTrade<- matrix(gardiens[gardiens$Statues %in% c("Actif", "Inactif", "Backup"),]$Joueur, ncol=1) 
            
          listeJoueur<-rbind(attValidToTrade, defValidToTrade, gardiensValidToTrade)
          
          selectInput(inputId = i, label = "Liste Joueur", width = "100%", size = 10,
                      multiple = T ,choices = listeJoueur, selected = 0, selectize=F)
        }
    }) 
  })
  
  lapply(c("listJoueurChoisi1", "listJoueurChoisi2"), function(i){
    output[[i]]<- renderUI({
      
      if (i == "listJoueurChoisi1"){
        nom <- input$listJoueur1
        no<- 1
      } else{
        nom <- input$listJoueur2
        no<- 2
      }
  
      selectInput(inputId = paste0("listElementTarde", no), label = "Liste Joueur dans l'echange", width = "100%",
                  multiple = T ,choices = nom, selected = 0, selectize=F)
    }) 
  })
  

  observeEvent(input$runEchange, {
    if (input$nomPoolers1 == input$nomPoolers2){
      showNotification("Vous devez choisir 2 poolers different pour faire un echange et votre échange doit contenir des joueurs")
      
    }else{
      if ((length(input$listJoueur1) != length(input$listJoueur2)) | (length(input$listJoueur1) == 0L)){
        showNotification("Le nombre de joueur echanger doit etre le meme pour chaque poolers")
      }else{

        addNewPropositionEchange(input$nomPoolers1, input$listJoueur1, input$nomPoolers2, input$listJoueur2)
        
        output$sommaireEchanges<- DT::renderDataTable({
          echangeDt<- dbReadTable(con, "infoEchange")
          datatable(echangeDt ,options = list("pageLength" = length(echangeDt[,1]), dom = 't'),rownames = FALSE,
                    selection =list(mode = 'single',target = 'row'))
        })
          
        output$choixEchange<-  renderUI({
          EchangeSelected<- input$sommaireEchanges_rows_selected
          
          if (!is.null(EchangeSelected)){
            selectInput(inputId = "noEchange", label = "Choisir le # de l'echange ", width = "100%",
                        multiple = F ,choices = EchangeSelected, selected = EchangeSelected)
          }else{
            selectInput(inputId = "noEchange", label = "Choisir le # de l'echange ", width = "100%",
                        multiple = F ,choices = NA, selected = 1)
          }
          
        })
      }
    }
  })
  
  output$sommaireEchanges<- DT::renderDataTable({
      echangeDt<- dbReadTable(con, "infoEchange")
      datatable(echangeDt ,options = list("pageLength" = length(echangeDt[,1]), dom = 't'),rownames = FALSE,
                selection =list(mode="single",target = 'row'))
    })
  
  output$choixEchange<-  renderUI({
            EchangeSelected<- input$sommaireEchanges_rows_selected
            
            if (!is.null(EchangeSelected)){
              selectInput(inputId = "noEchange", label = "Choisir le # de l'echange ", width = "100%",
                          multiple = F ,choices = EchangeSelected, selected = EchangeSelected)
            }else{
              selectInput(inputId = "noEchange", label = "Choisir le # de l'echange ", width = "100%",
                          multiple = F ,choices = NA, selected = 1)
            }
            
  })
  
  output$listNomTrade<- renderUI({
            choix<- c(dbReadTable(con,"infoEchange")[input$noEchange,2], dbReadTable(con,"infoEchange")[input$noEchange,6])
            selectInput(inputId = "nomTrade", label = "Nom Poolers", width = "100%",
                        choices = choix, selected = 1)
  })
  
  observeEvent(input$tradeAction, {
    if (!is.null(input$sommaireEchanges_rows_selected)){
      if (!dbExistsTable(con, paste0("ConfirmeEchange", input$noEchange))){
        showNotification("Une decision a deja ete prise vis-a-vis cet echange")
      }else{
        
        if (input$choixAction == "Accepter"){
          
          echangeAccepter(input$nomTrade,input$noEchange, input$motPasse)
          output$sommaireEchanges<- DT::renderDataTable({
            echangeDt<- dbReadTable(con, "infoEchange")
            datatable(echangeDt ,options = list("pageLength" = length(echangeDt[,1]), dom = 't'),rownames = FALSE,
                      selection =list(mode = 'single',target = 'row'))
          })
          
        }else if (input$choixAction == "Refuser"){
          
          echangeRefuser(input$nomTrade, input$noEchange, input$motPasse)
          output$sommaireEchanges<- DT::renderDataTable({
            echangeDt<- dbReadTable(con, "infoEchange")
            datatable(echangeDt ,options = list("pageLength" = length(echangeDt[,1]), dom = 't'),rownames = FALSE,
                      selection =list(mode = 'single',target = 'row'))
          })
        }
      }
    }else{
      showNotification("veuillez selectionner un echange")
    }
    
  })
  
  ####################
  ##Création poolers##
  ####################
  
  observeEvent(input$createNewPooler, {
    
    infoJoueursGardiens<- as.data.frame(rbind( c(input$att1, "NA", "New", "Att"),
                                               c(input$att2, "NA", "New", "Att"),
                                               c(input$att3, "NA", "New", "Att"),
                                               c(input$att4, "NA", "New", "Att"),
                                               c(input$att5, "NA", "New", "Att"),
                                               c(input$att6, "NA", "New", "Att"),
                                               c(input$att7, "NA", "New", "Att"),
                                               c(input$att8, "NA", "New", "Att"),
                                               c(input$att9, "NA", "New", "Att"),
                                               c(input$att10, "NA", "New", "Att"),
                                               c(input$att11, "NA", "New", "Att"),
                                               c(input$att12, "NA", "New", "Att"),
                                               c(input$att13, "NA", "New", "Att"),
                                               c(input$att14, "NA", "New", "Att"),
                                               c(input$att15, "NA", "New", "Att"),
                                               c(input$def1, "NA", "New", "Def"),
                                               c(input$def2, "NA", "New", "Def"),
                                               c(input$def3, "NA", "New", "Def"),
                                               c(input$def4, "NA", "New", "Def"),
                                               c(input$def5, "NA", "New", "Def"),
                                               c(input$def6, "NA", "New", "Def"),
                                               c(input$def7, "NA", "New", "Def"),
                                               c(input$def8, "NA", "New", "Def"),
                                               c(input$goal1, "NA", "New", "G"),
                                               c(input$goal2, "NA", "New", "G"),
                                               c(input$goal3, "NA", "New", "G")
                                        ))
    colnames(infoJoueursGardiens)<-c("Joueurs", "Equipe", "Statue", "POS")
    
    nomJoueursGardiensVerif<- gsub("'", "", gsub('.', "", gsub("-", "",gsub("[[:space:]]", "", infoJoueursGardiens$Joueurs)), fixed = T))
    verifEntrees<- ifelse(grepl("^[A-Za-z]+$", nomJoueursGardiensVerif, perl = T), T, F)
    
    print(nomJoueursGardiensVerif)
    
    if (F %in% verifEntrees){
      showNotification("Tout les joueurs doivent avoir un nom non-vide ou contenir des caractères valides...")
    }
    else if(input$motPasseCreate == input$motPasseConfirm){
      createPoolers(input$nomPooler, input$colorPooler,  infoJoueursGardiens, input$motPasseCreate)
      
      showNotification(paste("Le pooler", input$nomPooler, "a bien été créée!"))
    }else{
      showNotification("Les deux mots de passes ne correspondent pas ...")
    }
      
  })
  
  ###############################
  #     Section Update Pool     #
  ###############################
  
  lapply(c("statsJoueurs", "statsGardiens"), function(i){
    output[[i]] <- DT::renderDataTable({
      if (dbExistsTable(con, "statsGardiens")){
        tableau<- dbReadTable(con, i)
        
        if (i == "statsGardiens"){
          tableau<- tableau[ order(tableau$Win, decreasing = T),]
        }else{
          tableau<- tableau[ order(tableau$PTS, decreasing = T),]
        }
        
        datatable(tableau[1:40,1:8],options = list("pageLength" = 40, dom = 't'), rownames = F)
      }
    })
  })
  
  observeEvent(input$updateStatsJouerNHL, {
    
    if (input$motPasseUpdateNHL == dbReadTable(con, "UpdatePassword")[1,1]){
    
    UpdateStatsAttDefNHL()
    UpdateStatsGardiens()
    
    showNotification("Les statistiques des joueurs de la NHL ont ete misent a jours!")
    }else{
      
      showNotification("Mot de passe invalide")
    }
    
  })
  
  observeEvent(input$updateAll, {
    
    if (input$motPasseUpdatePool == dbReadTable(con, "UpdatePassword")[1,1]){
      if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      info<- dbReadTable(con, "infoPoolers")
      
      UpdateStatsAttDefNHL()
      UpdateStatsGardiens()
      
      for (pooler in info$Nom){
        miseAJourPtsPoolers(pooler)
      }
      
      updateEvo(info$Nom)
      
      showNotification("Le pool a ete mis à jours!")
      }else{
        showNotification("Le Pool ne peut pas etre mis a jour s'il n'y a pas de poolers inscrient")
      }
        
    }else{
      
      showNotification("Mot de passe invalide")
    }
    
  })
  
}
