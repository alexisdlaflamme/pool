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
                                           choices = dbReadTable(con,"infoPoolers")$Nom),
                         HTML( paste(h4("Attaquant"))),
                         dataTableOutput("statsJoueursPooler"),
                         HTML( paste('<br/>', h4("Defenseurs"))),
                         dataTableOutput("statsDefenseursPooler"),
                         HTML( paste('<br/>', h4("Gardiens"))),
                         dataTableOutput("statsGardiensPooler")
                         
                ),
                tabPanel("Echange",
                        fluidRow(
                          column(2, 
                                 selectInput(inputId = "nomPoolers1", label = "Nom Poolers 1", width = "100%",
                                    choices = dbReadTable(con,"infoPoolers")$Nom, selected = 0)
                                ),
                          column(4,
                                 uiOutput("listJoueur1")
                                ),
                          column(4,
                                 uiOutput("listJoueur2")
                                ),
                          column(2, 
                                 selectInput(inputId = "nomPoolers2", label = "Nom Poolers 2", width = "100%",
                                             choices = dbReadTable(con,"infoPoolers")$Nom, selected = 0)
                                )
                        ),
                        fluidRow(
                          column(6,
                                 uiOutput("listJoueurChoisi1")
                          ),
                          column(6,
                                 uiOutput("listJoueurChoisi2")
                          )
                        ),
                        fluidRow(
                          column(2, align="center", 
                                 actionBttn("runEchange", label = "Faire l'echange", color ="warning", style =  "bordered", size = "sm")
                          )
                        )
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
                                    alignementSelectionAttaquant()
                                  )
                           ),
                           column(8, offset = 3,
                                  fluidRow(
                                    column(5, offset = 5, HTML( paste(h4("D?fenseurs")))),
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
                )             
)