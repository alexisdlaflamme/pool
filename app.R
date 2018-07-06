library(shiny)


# Define UI ----anel
ui <- fluidPage(
  
  navbarPage("Pool 2018-2019",
             tabPanel("Acceuil",
                      
                      HTML( paste(h4("Yolo")))
                      
             ),
             tabPanel("Stats Poolers"
                      
                      
             ),
             tabPanel("Échange"
                      
             ),
             tabPanel("Création d'équipe"
                      
                      
             )               
  )
  
  
  
)

# Define server logic ----
server <- function(input, output, session) {
  
  
  
}
# Run the app ----
shinyApp(ui = ui, server = server)

