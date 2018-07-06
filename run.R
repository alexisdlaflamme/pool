library(shiny)
install.packages("DT", repos = "http://cran.us.r-project.org")
port <- Sys.getenv('PORT')

shiny::runApp(
  appDir = getwd(),
  host = '0.0.0.0',
  port = as.numeric(port)
)


