
server <- function(input, output) {
  
  
  ###########################
  ##Affichage Stats Poolers##
  ###########################
  
  
  lapply(c("statsJoueursPooler", "statsDefenseursPooler", "statsGardiensPooler"), function(i){
    output[[i]] <- DT::renderDataTable({
      if (i == "statsJoueursPooler"){
        statsPoolersChoisi <- miseEnFormeStatsPoolers(input$statsPoolers)
        datatable(statsPoolersChoisi[[1]],options = list("pageLength" = length(statsPoolersChoisi[[1]][,1]), dom = 't'))
      }
      else if (i == "statsDefenseursPooler"){
        statsPoolersChoisi <- miseEnFormeStatsPoolers(input$statsPoolers)
        datatable(statsPoolersChoisi[[2]],options = list("pageLength" = length(statsPoolersChoisi[[2]][,1]), dom = 't'))
      }
      else if (i == "statsGardiensPooler"){
        statsPoolersChoisi <- miseEnFormeStatsPoolers(input$statsPoolers)
        datatable(statsPoolersChoisi[[3]],options = list("pageLength" = length(statsPoolersChoisi[[3]][,1]), dom = 't'))
      }
    })
  })
  
  ######################
  ##Creation graphique##
  ######################
  
  output$graph_total <- renderPlot({ # on fait appel ? la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    barplot(as.numeric(sort(classementPoolers()[,5])),xlab = 'Points',
            main = 'Classement General',# le titre de notre histogramme (param?tre 'main') va ?tre constitu? du texte rentr? ? la main par l'utilisateur dans la partie 'UI' et stock? dans 'titre_histo'
            col = c('orange','skyblue','red'), border = "black",horiz=TRUE,beside = TRUE,
            names.arg=as.numeric(sort(classementPoolers()[,5])),las = 1,xlim =c(0,as.numeric(sort(classementPoolers()[,5])[3])+200))
    box()
    legend('topright',c('Alexis','Rich','Xav'),fill =c('Orange','Red','Skyblue') )
    
  })
  
  output$graph_attaquant <- renderPlot({ # on fait appel ? la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    barplot(as.numeric(sort(classementPoolers()[,2])),xlab = 'Points',
            main = 'Classement Attaquants',# le titre de notre histogramme (param?tre 'main') va ?tre constitu? du texte rentr? ? la main par l'utilisateur dans la partie 'UI' et stock? dans 'titre_histo'
            col = c('orange','red','skyblue'), border = "black",horiz=TRUE,beside = TRUE,
            names.arg=as.numeric(sort(classementPoolers()[,2])),las = 1,xlim =c(0,as.numeric(sort(classementPoolers()[,2])[3])+200))
    box()
    legend('topright',c('Alexis','Rich','Xav'),fill =c('Orange','Red','Skyblue') )
  })
  
  output$graph_defensseur <- renderPlot({ # on fait appel ? la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    barplot(as.numeric(sort(classementPoolers()[,3])),xlab = 'Points',
            main = 'Classement Defensseurs',# le titre de notre histogramme (param?tre 'main') va ?tre constitu? du texte rentr? ? la main par l'utilisateur dans la partie 'UI' et stock? dans 'titre_histo'
            col = c('skyblue','orange','red'), border = "black",horiz=TRUE,beside = TRUE,
            names.arg=as.numeric(sort(classementPoolers()[,3])),las = 1,xlim =c(0,as.numeric(sort(classementPoolers()[,3])[3])+200))
    box()
    legend('topright',c('Alexis','Rich','Xav'),fill =c('Orange','Red','Skyblue') )
    
  })
  
  output$graph_gardien <- renderPlot({ # on fait appel ? la fonction 'renderPlot' cette fois car notre sortie sera un graphique
    barplot(as.numeric(sort(classementPoolers()[,4])),xlab = 'Points',
            main = 'Classement Gardiens',# le titre de notre histogramme (param?tre 'main') va ?tre constitu? du texte rentr? ? la main par l'utilisateur dans la partie 'UI' et stock? dans 'titre_histo'
            col = c('orange','skyblue','red'), border = "black",horiz=TRUE,beside = TRUE,
            names.arg=as.numeric(sort(classementPoolers()[,4])),las = 1,xlim =c(0,as.numeric(sort(classementPoolers()[,4])[3])+200))
    box()
    legend('topright',c('Alexis','Rich','Xav'),fill =c('Orange','Red','Skyblue') )
    
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
    
    verifEntrées<- ifelse(grepl("^[A-Za-z]+$", gsub("-", "",gsub("[[:space:]]", "", infoJoueursGardiens$Joueurs)), perl = T), T, F)
    
    if (F %in% verifEntrées){
      showNotification("Tout les joueurs doivent avoir un nom non-vide ou contenir des caractères valides...")
    }
    else{
      createJsonPoolers(input$nomPooler, input$colorPooler,  infoJoueursGardiens)
      
      showNotification(paste("Le pooler", input$nomPooler, "a bien été créée!"))
    }
  })
  
  
  
}
