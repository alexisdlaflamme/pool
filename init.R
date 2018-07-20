my_packages = c("DT", "jsonlite", "dplyr", "readxl", "shinyWidgets", "processx", "RPostgreSQL", "httr", "dbplyr", "tidyverse", "devtools", "sqldf")

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
}

invisible(sapply(my_packages, install_if_missing))
invisible(devtools::install_github("rstudio/pool"))
