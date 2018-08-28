library(shiny)
library(shinyWidgets)
library(DT)

DirPGM<-paste0(getwd(), "/Programme/")

#Connection db
source(paste0(DirPGM,"BaseDonnee.R"))

#Programmes utilent pour l'interface ui
source(paste0(DirPGM, "InterfaceAlignementSelection.R"))
#source(paste(DirPGM, "InterfaceGestionAlignement.R"))

#Programme le server
source(paste0(DirPGM, "MiseEnFormeStatsPoolers.R"))
source(paste0(DirPGM, "CreatePooler.R"))
source(paste0(DirPGM, "GetClassementPoolers.R"))

#Programmes interface et serveur 
source(paste0(DirPGM, "ui.R"))
source(paste0(DirPGM, "server.R"))

# Run the app ----
shinyApp(ui = ui, server = server)
