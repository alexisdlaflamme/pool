ui <-navbarPage("Pool 2019-2020", theme = shinytheme("cerulean"),

###########################
#     Section Acceuil     #
###########################

                tabPanel("Acceuil",
                         fluidRow(
                           column(4,
                                  plotOutput("graph_total",width = "100%")
                           ),
                           column(4,
                                  plotOutput("graph_attaquant",width = "100%")                             
                           ),
                           column(4,
                                  plotOutput("graph_defensseur",width = '100%')
                           ),
                           column(4,
                                  plotOutput("graph_gardien",width = '100%')                   
                           ),
                           column(4,
                                  plotOutput("graph_GP",width = '100%')                   
                           ),
                           column(4,
                                  plotOutput("graph_PtsGP",width = '100%')                   
                           ),
                           column(4, offset = 1,
                                  plotOutput("PtsHier")
                           ),
                           column(4, offset = 1,
                                  plotlyOutput("EvoPtsTot")
                           )
                           
                         ),
                         fluidRow(
                         lapply(1:length(dbReadTable(con,"evoPtsJours")[,1]), function(i) {
                           column(4,
                                  plotlyOutput(paste0("PtsJours",dbReadTable(con,"evoPtsJours")[i,1]))
                           )
                         })
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
                         HTML( paste('<br/>', h4("Défenseurs"))),
                         dataTableOutput("statsDefenseursPooler"),
                         HTML( paste('<br/>', h4("Gardiens"))),
                         dataTableOutput("statsGardiensPooler")
                         
                ),
#########################
# Gestion d'alignemant  # 
#########################
                tabPanel("Gestion Alignement",
                         titlePanel('Gestion Alignement'),
                         sidebarLayout(
                           
                           sidebarPanel(
                             
                             selectInput(inputId = "PoolerName", label = "Nom du pooler", width = "100%",
                                         choices = dbReadTable(con,"infoPoolers")$Nom, selected = 0),
                             
                             
                             selectInput(inputId = "Position", label = "Position", width = "100%",
                                         choices = c('Attaquants','Defenseurs','Gardiens'), selected = 0),
                             selectInput("OptionNew",label = "Choix mouvement",choices = c("Gestion Alignement","Nouveaux Joueurs"),
                                         selected = 0),
                             conditionalPanel(condition = " input.OptionNew == 'Nouveaux Joueurs'",
                                              selectInput("StatueNew",label = "Statue du nouveau joueur",choices = c("Actif","Backup"),
                                                          selected = 0)),
                             dataTableOutput('Selection'),
                             HTML('<br/>'),
                             passwordInput("password", label = "Mot de passe"),
                             actionBttn('Confirm','Confirmer',style = 'jelly',color = 'primary',size = 'sm')
                             
                             ),
                           mainPanel(
                             column(6, offset = 4,
                                    titlePanel('Choix des joueurs')),
                             
                             dataTableOutput("statsJoueursAlignement")
                             
                           )
                         )
                         
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
                                 actionBttn("runEchange", label = "Proposer un échange", color ="success", style =  "bordered", size = "sm")
                          )
                        ),
                        fluidRow(
                          column(5,
                                 HTML( paste('<br/>', h4("Sommaire des échanges"))),
                                 HTML('<br/>')
                          )
                        ),
                        fluidRow(
                          column(12,align="center",
                                 dataTableOutput("sommaireEchanges")
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
                                uiOutput("listNomTrade")
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

# #################################
# #     Section Ajout Poolers     #
# #################################

                # tabPanel("Ajout Pooler",
                #          fluidRow(
                #            column(2,
                #                   textInput(inputId = "nomPooler", label = "Nom du nouveau pooler", width = "100%"),
                #                   selectInput(inputId = "colorPooler", label = "Choisir la couleur du nouveau pooler", width = "100%",
                #                               choices = colors(), selected = 0),
                #                   passwordInput(inputId = "motPasseCreate", label = "Entrez votre mot de passe", width = "100%"),
                #                   passwordInput(inputId = "motPasseConfirm", label = "Confirmer votre mot de passe", width = "100%"),
                #                   actionBttn("createNewPooler", "Créer")
                #            ),
                #            column(8, offset = 1,
                #                   fluidRow(
                #                     column(5, offset = 5, HTML( paste(h4("Attaquants")))),
                #                     alignementSelectionAttaquant()
                #                   )
                #            ),
                #            column(8, offset = 3,
                #                   fluidRow(
                #                     column(5, offset = 5, HTML( paste(h4("Defenseurs")))),
                #                     alignementSelectionDefenseur()
                #                   )
                # 
                #            ),
                #            column(8, offset = 3,
                #                   fluidRow(
                #                     column(5, offset = 5, HTML( paste(h4("Gardiens")))),
                #                     alignementSelectionGardien()
                #                   )
                #            )
                #          )
                # ),

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
                           column(4, offset = 2, align="left",
                                  HTML('<br/>'), HTML('<br/>'),
                                  passwordInput(inputId = "motPasseUpdateNHL", label = "Entrez le mot de passe de mise a jour", width = "100%"),
                                  HTML('<br/>'), HTML('<br/>')
                           ),
                           column(5, offset = 1, style = "margin-top: 25px;",
                                  HTML('<br/>'), HTML('<br/>'),
                                  actionButton("updateStatsJouerNHL", "Mettre a jours", width = "50%"),
                                  HTML('<br/>'), HTML('<br/>')
                           )
                         ),
                         fluidRow(
                           column(12, align="center",
                                  HTML( paste(h2("Toutes les statistique du pool"))),
                                  HTML('<br/>'), HTML('<br/>')
                                  )
                         ),
                         fluidRow(
                           column(4, offset = 2, align="left",
                                  passwordInput(inputId = "motPasseUpdatePool", label = "Entrez le mot de passe de mise a jour", width = "100%")
                           ),
                           column(5, offset = 1, style = "margin-top: 25px;",
                                  actionButton("updateAll", "Mettre a jours", width = "50%")
                                  
                          ),
                          tags$head(
                            HTML(
                              "
                              <script>
                              var socket_timeout_interval
                              var n = 0
                              $(document).on('shiny:connected', function(event) {
                              socket_timeout_interval = setInterval(function(){
                              Shiny.onInputChange('count', n++)
                              }, 15000)
                              });
                              $(document).on('shiny:disconnected', function(event) {
                              clearInterval(socket_timeout_interval)
                              });
                              </script>
                              "
                            )
                            ),
                          textOutput("keepAlive")
                )
      )
)