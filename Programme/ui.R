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
                navbarMenu("Gestion Alignement",
                           tabPanel("Allo")
                           ,
                           interfaceGestionAlignement()
                
                         
                )
                ,
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
                                    alignementSelection()
                                  )
                           ),
                           column(8, offset = 3,
                                  fluidRow(
                                    column(5, offset = 5, HTML( paste(h4("Défenseurs")))),
                                    alignementSelectionDefenseur()
                                  )
                                  
                           ),
                           
                           column(8, offset = 3,
                                  fluidRow(
                                    column(5, offset = 5, HTML( paste(h4("Gardiens")))),
                                    alignementSelectionGardien()
                                  )
                                  
                           )
                        )
                ),
                tabPanel("Création d'équipe"
                         
                         )               
)