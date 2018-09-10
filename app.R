library(shiny)
library(shinyWidgets)
library(shinythemes)
library(DT)

DirPGM<-paste0(getwd(), "/Programme/")

#Connection db
source(paste0(DirPGM,"BaseDonnee.R"))
source(paste0(DirPGM,"InitTableauDeBase.R"))

#Programmes utilent pour l'interface ui
source(paste0(DirPGM, "InterfaceAlignementSelection.R"))

#Programme le server
source(paste0(DirPGM, "MiseEnFormeStatsPoolers.R"))
source(paste0(DirPGM, "CreatePooler.R"))
source(paste0(DirPGM, "GetClassementPoolers.R"))
source(paste0(DirPGM, "ServerGestionDechange.R"))
source(paste0(DirPGM, "GestionActionEchange.R"))
source(paste0(DirPGM, "MiseAJourPtsPoolers.R"))
source(paste0(DirPGM, "UpdateTabEvoClassementPoolers.R"))
source(paste0(DirPGM, "UpdateStatsJoueurgardiens.R"))

#Programmes interface et serveur 
source(paste0(DirPGM, "ui.R"))
source(paste0(DirPGM, "server.R"))

# Run the app ----
shinyApp(ui = ui, server = server)
