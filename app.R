library(shiny)
library(shinyWidgets)
library(DT)

# Define UI ----anel
DirPGM<-paste(getwd(), "/Programme/", sep = "")
source(paste(DirPGM, "MiseEnFormeStatsPoolers.R", sep = ""))

# Define UI ----anel
ui <-navbarPage("Pool 2018-2019",
             tabPanel("Acceuil",
                      fluidRow(
                          column(5,
                                 plotOutput("graph_total",width = "100%")
                               
                          ),
                          column(5,offset = 1,
                                 plotOutput("graph_attaquant",width = "100%")                             
                          ),
                          column(5,
                                 plotOutput("graph_defensseur",width = '100%')
                          ),
                          column(5,offset = 1,
                                 plotOutput("graph_gardien",width = '100%')                   
                          )
                      )
                      
             ),
             tabPanel("Stats Poolers",
                      
                      radioGroupButtons("statsPoolers", label = "" , size = "lg", individual = T,
                                        choices = list("Alexis" = "Alexis", "Xav" = "Xav", "Rich" = "Rich")),
                      HTML( paste(h4("Attaquant"))),
                      dataTableOutput("statsJoueursPooler"),
                      HTML( paste('<br/>', h4("Defenseurs"))),
                      dataTableOutput("statsDefenseursPooler"),
                      HTML( paste('<br/>', h4("Gardiens"))),
                      dataTableOutput("statsGardiensPooler")
                      
             ),
             tabPanel("Échange"
                      
             ),
             tabPanel("Ajout Pooler",
                      fluidRow(
                          column(2,
                                textInput(inputId = "nomPooler", label = "Nom du nouveau pooler", width = "100%"),
                                selectInput(inputId = "colorPooler", label = "Choisir la couleur du nouveau pooler", width = "100%",
                                            choices = colors(), selected = 0),
                                actionBttn("createNewPooler", "Créer")
                          ),
                          column(8, offset = 1,
                                 fluidRow(
                                      column(5, offset = 5, HTML( paste(h4("Attaquants")))),
                                      column(4,
                                        textInput(inputId = "att1", label = "Nom attaquant 1", width = "100%"),
                                        textInput(inputId = "att4", label = "Nom attaquant 4", width = "100%"),
                                        textInput(inputId = "att7", label = "Nom attaquant 7", width = "100%"),
                                        textInput(inputId = "att10", label = "Nom attaquant 10", width = "100%")
                                      ),
                                      column(4,
                                             textInput(inputId = "att2", label = "Nom attaquant 2", width = "100%"),
                                             textInput(inputId = "att5", label = "Nom attaquant 5", width = "100%"),
                                             textInput(inputId = "att8", label = "Nom attaquant 8", width = "100%"),
                                             textInput(inputId = "att11", label = "Nom attaquant 11", width = "100%")
                                      ),
                                      column(4,
                                             textInput(inputId = "att3", label = "Nom attaquant 3", width = "100%"),
                                             textInput(inputId = "att6", label = "Nom attaquant 6", width = "100%"),
                                             textInput(inputId = "att9", label = "Nom attaquant 9", width = "100%"),
                                             textInput(inputId = "att12", label = "Nom attaquant 12", width = "100%")
                                      )
                                )
                          ),
                          column(8, offset = 3,
                                 fluidRow(
                                   column(5, offset = 5, HTML( paste(h4("Défenseurs")))),
                                   column(6,
                                            textInput(inputId = "def1", label = "Nom défenseur 1", width = "100%"),
                                            textInput(inputId = "def3", label = "Nom défenseur 3", width = "100%"),
                                            textInput(inputId = "def5", label = "Nom défenseur 5", width = "100%")
                                    ),
                                   column(6,
                                           textInput(inputId = "def2", label = "Nom défenseur 2", width = "100%"),
                                           textInput(inputId = "def4", label = "Nom défenseur 4", width = "100%"),
                                           textInput(inputId = "def6", label = "Nom défenseur 6", width = "100%")
                                   )
                          )
                          
                      ),
                      column(8, offset = 3,
                             fluidRow(
                               column(5, offset = 5, HTML( paste(h4("Gardiens")))),
                               column(4,
                                      textInput(inputId = "goal1", label = "Nom gardien 1", width = "100%")
                               ),
                               column(4,
                                      textInput(inputId = "goal2", label = "Nom gardien 2", width = "100%")
                               ),
                               column(4,
                                      textInput(inputId = "goal3", label = "Nom gardien 3", width = "100%")
                               )
                             )
                             
                      )
                      )
             ),
             tabPanel("Création d'équipe"
                      
                      
             )               
)

# Define server logic ----
server <- function(input, output) {
  
  
  
  ##Affichage Stats Poolers##
  
  output$statsJoueursPooler <- DT::renderDataTable({
    statsPoolersChoisi <- miseEnFormeStatsPoolers(input$statsPoolers)
    datatable(statsPoolersChoisi[[1]],options = list("pageLength" = length(statsPoolersChoisi[[1]][,1]), dom = 't'))
  })
  
  output$statsDefenseursPooler <- DT::renderDataTable({
    statsPoolersChoisi <- miseEnFormeStatsPoolers(input$statsPoolers)
    datatable(statsPoolersChoisi[[2]],options = list("pageLength" = length(statsPoolersChoisi[[2]][,1]), dom = 't'))
  })
  
  output$statsGardiensPooler <- DT::renderDataTable({
    statsPoolersChoisi <- miseEnFormeStatsPoolers(input$statsPoolers)
    datatable(statsPoolersChoisi[[3]],options = list("pageLength" = length(statsPoolersChoisi[[3]][,1]), dom = 't'))
  })
  ##Creation graphique
  
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
  
  
  

  ##Création poolers
  
  

}

# Run the app ----
shinyApp(ui = ui, server = server)

