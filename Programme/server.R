
server <- function(input, output, session) {
  
  ######################
  # Creation graphique #
  ######################
  
  output$graph_total <- renderPlot({
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      classement<- classementPoolersTotal()
      barplot(classement[,3],xlab = 'Points',
              main = 'Classement General',
              col = classement[,2], border = "black",horiz=TRUE,beside = TRUE,
              names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
      box()
    }
  })
  
  output$graph_attaquant <- renderPlot({ # on fait appel ? la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      classement<- classementAttPoolers()
      barplot(classement[,3],xlab = 'Points',
              main = 'Classement Attaquants',
              col = classement[,2], border = "black",horiz=TRUE,beside = TRUE,
              names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
      box()
    }
  })
  
  output$graph_defensseur <- renderPlot({ 
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      classement<- classementDefPoolers()
        barplot(classement[,3],xlab = 'Points',
                main = 'Classement Defenseurs',
                col = classement[,2], border = "black",horiz=TRUE,beside = TRUE,
                names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
        box()
    }
  })
  
  output$graph_gardien <- renderPlot({ # on fait appel ? la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
      classement<- classementGardiensPoolers()
      barplot(classement[,3],xlab = 'Points',
              main = 'Classement Gardiens',
              col = classement[,2], border = "black",horiz=TRUE,beside = TRUE,
              names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
      box()
    }
  })
  
  ###########################
  # Affichage Stats Poolers #
  ###########################
  
  
  lapply(c("statsJoueursPooler", "statsDefenseursPooler", "statsGardiensPooler"), function(i){
    output[[i]] <- DT::renderDataTable({
      if (!is.na(dbReadTable(con, "infoPoolers")[1,1])){
        if (i == "statsJoueursPooler"){
          statsPoolersChoisi <- miseEnFormeStatsAttPoolers(input$statsPoolers)
          datatable(statsPoolersChoisi,options = list("pageLength" = length(statsPoolersChoisi[,1]), dom = 't'))
        }
        else if (i == "statsDefenseursPooler"){
          statsPoolersChoisi <- miseEnFormeStatsDefPoolers(input$statsPoolers)
          datatable(statsPoolersChoisi,options = list("pageLength" = length(statsPoolersChoisi[,1]), dom = 't'))
        }
        else if (i == "statsGardiensPooler"){
          statsPoolersChoisi <- miseEnFormeStatsGardiensPoolers(input$statsPoolers)
          datatable(statsPoolersChoisi,options = list("pageLength" = length(statsPoolersChoisi[,1]), dom = 't'))
        }
      }
    })
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
          listeJoueur<-rbind(matrix(dbReadTable(con, paste0("statsAtt", nom))$Joueur, length(dbReadTable(con, paste0("statsAtt", nom))$Joueur),1), 
                            matrix(dbReadTable(con, paste0("statsDef", nom))$Joueur,length(dbReadTable(con, paste0("statsDef", nom))$Joueur),1), 
                            matrix(dbReadTable(con, paste0("statsGardiens", nom))$Joueur,length(dbReadTable(con, paste0("statsGardiens", nom))$Joueur),1)) 
    
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
        
        output$sommaireEchanges<- renderTable(dbReadTable(con, "infoEchange"))
        output$choixEchange<-  renderUI({
          selectInput(inputId = "noEchange", label = "Choisir le # de l'echange ", width = "100%",
                      multiple = F ,choices = 1:length(dbReadTable(con, "infoEchange")$Num), selected = 1)
        })
      }
    }
  })
  
  output$sommaireEchanges<- renderTable(dbReadTable(con, "infoEchange"))
  
  output$choixEchange<-  renderUI({
            selectInput(inputId = "noEchange", label = "Choisir le # de l'echange ", width = "100%",
                                          multiple = F ,choices = 1:length(dbReadTable(con, "infoEchange")$Num), selected = 1)
  })
  
  observeEvent(input$tradeAction, {
    if (!dbExistsTable(con, paste0("ConfirmeEchange", input$noEchange))){
      showNotification("Une decision a deja ete prise vis-a-vis cet echange")
    }else{
      
      if (input$choixAction == "Accepter"){
        
        echangeAccepter(input$nomTrade,input$noEchange, input$motPasse)
        output$sommaireEchanges<- renderTable(dbReadTable(con, "infoEchange"))
        
      }else if (input$choixAction == "Refuser"){
        
        echangeRefuser(input$nomTrade, input$noEchange, input$motPasse)
        output$sommaireEchanges<- renderTable(dbReadTable(con, "infoEchange"))
      
      }
    }
    
    
  })
  
  ####################
  ##Création poolers##
  ####################
  
  observeEvent(input$createNewPooler, {
    
    infoJoueursGardiens<- as.data.frame(rbind( c(input$att1, "NA", "Actif", "Att"),
                                               c(input$att2, "NA", "Actif", "Att"),
                                               c(input$att3, "NA", "Actif", "Att"),
                                               c(input$att4, "NA", "Actif", "Att"),
                                               c(input$att5, "NA", "Actif", "Att"),
                                               c(input$att6, "NA", "Actif", "Att"),
                                               c(input$att7, "NA", "Actif", "Att"),
                                               c(input$att8, "NA", "Actif", "Att"),
                                               c(input$att9, "NA", "Actif", "Att"),
                                               c(input$att10, "NA", "Actif", "Att"),
                                               c(input$att11, "NA", "Actif", "Att"),
                                               c(input$att12, "NA", "Actif", "Att"),
                                               c(input$def1, "NA", "Actif", "Def"),
                                               c(input$def2, "NA", "Actif", "Def"),
                                               c(input$def3, "NA", "Actif", "Def"),
                                               c(input$def4, "NA", "Actif", "Def"),
                                               c(input$def5, "NA", "Actif", "Def"),
                                               c(input$def6, "NA", "Actif", "Def"),
                                               c(input$goal1, "NA", "Actif", "G"),
                                               c(input$goal2, "NA", "Actif", "G"),
                                               c(input$goal3, "NA", "Actif", "G")
                                        ))
    colnames(infoJoueursGardiens)<-c("Joueurs", "Equipe", "Statue", "POS")
    
    verifEntrees<- ifelse(grepl("^[A-Za-z]+$", gsub("-", "",gsub("[[:space:]]", "", infoJoueursGardiens$Joueurs)), perl = T), T, F)
    
    if (F %in% verifEntrees){
      showNotification("Tout les joueurs doivent avoir un nom non-vide ou contenir des caractères valides...")
    }
    else if(input$motPasse == input$motPasseConfirm){
      createPoolers(input$nomPooler, input$colorPooler,  infoJoueursGardiens, input$motPasseCreate)
      
      showNotification(paste("Le pooler", input$nomPooler, "a bien été créée!"))
    }else{
      showNotification("Les deux mots de passes ne correspondent pas ...")
    }
      
  })
  
  
  
}
