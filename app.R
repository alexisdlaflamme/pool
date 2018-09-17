library(shiny)
library(shinyWidgets)
library(shinythemes)
library(DT)

DirPGM<-paste0(getwd(), "/Programme/")

#Connection db
source(paste0(DirPGM,"BaseDonnee.R"), encoding = "utf-8")
source(paste0(DirPGM,"InitTableauDeBase.R"), encoding = "utf-8")

#Programmes utilent pour l'interface ui
source(paste0(DirPGM, "InterfaceAlignementSelection.R"), encoding = "utf-8")
source(paste0(DirPGM, "GestionAlignement.R"), encoding = "utf-8")

#Programme le server
source(paste0(DirPGM, "MiseEnFormeStatsPoolers.R"), encoding = "utf-8")
source(paste0(DirPGM, "CreatePooler.R"), encoding = "utf-8")
source(paste0(DirPGM, "GetClassementPoolers.R"), encoding = "utf-8")
source(paste0(DirPGM, "ServerGestionDechange.R"), encoding = "utf-8")
source(paste0(DirPGM, "GestionActionEchange.R"), encoding = "utf-8")
source(paste0(DirPGM, "MiseAJourPtsPoolers.R"), encoding = "utf-8")
source(paste0(DirPGM, "UpdateTabEvoClassementPoolers.R"), encoding = "utf-8")
source(paste0(DirPGM, "UpdateStatsJoueurGardiens.R"), encoding = "utf-8")
source(paste0(DirPGM, "InitPtsJoueurGardiens.R"), encoding = "utf-8")

#Programmes interface et serveur 
source(paste0(DirPGM, "ui.R"), encoding = "utf-8")
source(paste0(DirPGM, "server.R"), encoding = "utf-8")

# Run the app ----
shinyApp(ui = ui, server = server)
