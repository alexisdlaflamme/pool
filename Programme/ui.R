ui <-navbarPage("Pool 2018-2019",

###########################
#     Section Acceuil     #
###########################

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
                         ),
                         fluidRow(
                           column(8, offset = 2,
                                  plotOutput("evoPtsJours",width = '100%')
                            )
                         )
                ),
##########################################
#     Section affichage stats Poolers    #
##########################################

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
###########################
#     Section Échange     #
###########################

                tabPanel("Echange",
                        fluidRow(
                          column(2, 
                                 selectInput(inputId = "nomPoolers1", label = "Nom Poolers 1", width = "100%",
                                    choices = dbReadTable(con,"infoPoolers")$Nom, selected = dbReadTable(con,"infoPoolers")$Nom[1])
                                ),
                          column(4,
                                 uiOutput("listJoueur1")
                                ),
                          column(4,
                                 uiOutput("listJoueur2")
                                ),
                          column(2, 
                                 selectInput(inputId = "nomPoolers2", label = "Nom Poolers 2", width = "100%",
                                             choices = dbReadTable(con,"infoPoolers")$Nom, selected = dbReadTable(con,"infoPoolers")$Nom[2])
                                )
                        ),
                        fluidRow( width = "200px",
                          column(6,
                                 uiOutput("listJoueurChoisi1")
                          ),
                          column(6,
                                 uiOutput("listJoueurChoisi2")
                          )
                        ),
                        fluidRow(
                          column(12, align="center", 
                                 actionBttn("runEchange", label = "Proposer un echange", color ="success", style =  "bordered", size = "sm")
                          )
                        ),
                        fluidRow(
                          column(5,
                                 HTML( paste('<br/>', h4("Sommaire des echanges"))),
                                 HTML('<br/>')
                          )
                        ),
                        fluidRow(
                          column(12,align="center",
                                 tableOutput("sommaireEchanges")
                          ),
                          column(5,
                                 HTML( paste('<br/>', h4(" "))),
                                 HTML('<br/>'))
                        ),
                        fluidRow(
                          column(3,
                                 uiOutput("choixEchange")
                          ),
                          column(3,
                                selectInput(inputId = "nomTrade", label = "Nom Poolers", width = "100%",
                                        choices = dbReadTable(con,"infoPoolers")$Nom, selected = 1)
                          ),
                          column(3,
                                 selectInput(inputId = "choixAction", label = "Choisir votre action", width = "100%",
                                             choices = c("Accepter", "Refuser"), selected = 1)
                          ),
                          column(3, 
                                 passwordInput(inputId = "motPasse", label = "Entrez votre mot de passe", width = "100%")
                          )
                        ),
                        fluidRow(
                          column(2, style = "margin-top: 10px;",
                                 actionButton("tradeAction", "Submit", width = "100%")
                          )
                        ),
                        fluidRow(
                          HTML('<br/>'), HTML('<br/>'), HTML('<br/>'),
                          HTML('<br/>'), HTML('<br/>'), HTML('<br/>'),
                          HTML('<br/>'), HTML('<br/>'), HTML('<br/>')
                        )
                )
                ,
#################################
#     Section Ajout Poolers     #
#################################

                tabPanel("Ajout Pooler",
                         fluidRow(
                           column(2,
                                  textInput(inputId = "nomPooler", label = "Nom du nouveau pooler", width = "100%"),
                                  selectInput(inputId = "colorPooler", label = "Choisir la couleur du nouveau pooler", width = "100%",
                                              choices = colors(), selected = 0),
                                  passwordInput(inputId = "motPasseCreate", label = "Entrez votre mot de passe", width = "100%"),
                                  passwordInput(inputId = "motPasseConfirm", label = "Confirmer votre mot de passe", width = "100%"),
                                  actionBttn("createNewPooler", "Creer")
                           ),
                           column(8, offset = 1,
                                  fluidRow(
                                    column(5, offset = 5, HTML( paste(h4("Attaquants")))),
                                    alignementSelectionAttaquant()
                                  )
                           ),
                           column(8, offset = 3,
                                  fluidRow(
                                    column(5, offset = 5, HTML( paste(h4("Defenseurs")))),
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
###############################
#     Section Update Pool     #
###############################

                tabPanel("Update",
                         fluidRow(
                           column(12, align="center",
                                  HTML( paste(h2("Points joueurs/gardiens de la NHL")))
                           )
                         ),
                         fluidRow(
                           column(5,
                                  HTML( paste(h4("Joueurs"))),
                                  dataTableOutput("statsJoueurs")
                                  
                           ),
                           column(5, offset = 1,
                                  HTML( paste(h4("Gardiens"))),
                                  dataTableOutput("statsGardiens")
                           )
                         ),
                         fluidRow(
                           column(4, offset = 4,
                                  HTML('<br/>'), HTML('<br/>'),
                                  actionButton("updateStatsJouerNHL", "Mettre a jours", width = "100%"),
                                  HTML('<br/>'), HTML('<br/>')
                           )
                         ),
                         fluidRow(
                           column(12, align="center",
                                  HTML( paste(h2("Toutes les statistique du pool"))),
                                  HTML('<br/>'), HTML('<br/>'),
                                  actionButton("updateAll", "Mettre a jours", width = "33%")
                                  
                                  )
                         )
                )
)