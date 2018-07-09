library(shiny)
library(shinyWidgets)
library(DT)

# Define UI ----anel
DirPGM<-paste(getwd(), "/Programme/", sep = "")
source(paste(DirPGM, "MiseEnFormeStatsPoolers.R", sep = ""))

# Define UI ----anel
ui <-navbarPage("Pool 2018-2019",
             tabPanel("Acceuil",
                      
                      HTML( paste(h4("Les graphs de rich")))
                      
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
                          column(
                                4,
                                textInput(inputId = "nomPooler", label = "Nom du nouveau pooler", width = "100%"),
                                textInput(inputId = "colorPooler", label = "Choisir la couleur du nouveau pooler", width = "100%"),
                                actionBttn("createNewPooler", "Créer")
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
  
}

# Run the app ----
shinyApp(ui = ui, server = server)

