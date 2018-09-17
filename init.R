<<<<<<< HEAD
my_packages = c("DT", "jsonlite", "dplyr", "readxl", "shinyWidgets", "processx", "RPostgreSQL", "httr", 
                "XML", "RCurl", "rlist","dbplyr", "devtools", "shinythemes")
=======
my_packages = c("DT", "jsonlite", "dplyr", "readxl", "shinyWidgets", "processx", "RPostgres", "httr", "dbplyr", "tidyverse")
>>>>>>> f6d0a4bfbc3265738f4f2c9e39e7a62a1ea1f826

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
}

invisible(sapply(my_packages, install_if_missing))
invisible(devtools::install_github("rstudio/pool"))
