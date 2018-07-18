library(shiny)
library(shinyWidgets)
library(DT)

DirPGM<-paste(getwd(), "/Programme/", sep = "")

#Connection db
source(paste(DirPGM,"BaseDonnee.R", sep = ""))

#Programmes utilent pour l'interface ui
source(paste(DirPGM, "InterfaceAlignementSelection.R", sep = ""))
#source(paste(DirPGM, "InterfaceGestionAlignement.R", sep = ""))

#Programme le server
source(paste(DirPGM, "MiseEnFormeStatsPoolers.R", sep = ""))
source(paste(DirPGM, "CreateJSONPoolers.R", sep = ""))

#Programmes interface et serveur
source(paste(DirPGM, "ui.R", sep = ""))
source(paste(DirPGM, "server.R", sep = ""))

# Run the app ----
shinyApp(ui = ui, server = server)
