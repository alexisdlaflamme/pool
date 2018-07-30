
server <- function(input, output) {
  
  ######################
  ##Creation graphique##
  ######################
  
  output$graph_total <- renderPlot({
    classement<- classementPoolersTotal()
    barplot(classement[,3],xlab = 'Points',
            main = 'Classement General',
            col = classement[,2], border = "black",horiz=TRUE,beside = TRUE,
            names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
    box()
  })
  
  output$graph_attaquant <- renderPlot({ # on fait appel ? la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    classement<- classementAttPoolers()
    barplot(classement[,3],xlab = 'Points',
            main = 'Classement Attaquants',
            col = classement[,2], border = "black",horiz=TRUE,beside = TRUE,
            names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
    box()
  })
  
  output$graph_defensseur <- renderPlot({ 
    classement<- classementDefPoolers()
    barplot(classement[,3],xlab = 'Points',
            main = 'Classement Defenseurs',
            col = classement[,2], border = "black",horiz=TRUE,beside = TRUE,
            names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
    box()
    
  })
  
  output$graph_gardien <- renderPlot({ # on fait appel ? la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    classement<- classementGardiensPoolers()
    barplot(classement[,3],xlab = 'Points',
            main = 'Classement Gardiens',
            col = classement[,2], border = "black",horiz=TRUE,beside = TRUE,
            names.arg=classement[,1], las = 1,xlim =c(0,max(classement[,3])*1.2))
    box()
  })
  
  ###########################
  ##Affichage Stats Poolers##
  ###########################
  
  
  lapply(c("statsJoueursPooler", "statsDefenseursPooler", "statsGardiensPooler"), function(i){
    output[[i]] <- DT::renderDataTable({
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
    })
  })
  

  
  ####################
  ##Création poolers##
  ####################
  
  observeEvent(input$createNewPooler, {
    
    infoJoueursGardiens<- as.data.frame(rbind(c(input$att1, "NA", "Actif", "Att"),
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
    else{
      createPoolers(input$nomPooler, input$colorPooler,  infoJoueursGardiens)
      
      showNotification(paste("Le pooler", input$nomPooler, "a bien été créée!"))
    }
  })
  
  
  
}
