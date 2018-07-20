
postgress.connect <- function() {
  
  # Make sure you install these!
  require(RPostgreSQL)
  require(pool)
  
  #driver
  #drv <- dbDriver("PostgreSQL")
  
  #attempt connection
  if (Sys.getenv("DATABASE_URL") != "") {
    url <- httr::parse_url(Sys.getenv("DATABASE_URL"))
    pool <- dbConnect(RPostgres::Postgres()
                   , host     = url$hostname
                   , port     = url$port
                   , user     = url$user
                   , password = url$password
                   , dbname   = url$path
    )
    print("Heroku application detected connecting to Postgres online")
    
  } else {
    ##Ajuster##
    
    pool <- dbConnect(RPostgres::Postgres()
                   , host     = "ec2-50-16-231-2.compute-1.amazonaws.com"
                   , port     = 5432
                   , user     = "rkvaizleemdacw"
                   , password = "7efca54493c95afc32fd648ac7bbdf0f2c4f6ba935e2b3fd7745d6bf545d2972"
                   , dbname   = "d2tn74iejrtdue"
                   
    )
    print("Heroku application detected connecting to Postgres local")
  }
  
  return(pool)
}

con <- postgress.connect()

library(readxl)

statsJoueursNHL<- paste(getwd(), "/Data/NHL/dataBaseStatsJoueur.xlsm", sep = "")
ColTypesJoueurs = c("skip", rep("text",10) , rep("skip",17))
ColNamesJoueurs = c("Joueurs", "Age", "Position", "Equipe", "GP", "Buts", "Passes", "PTS", "PlusMois", "PIM")
statsJoueurs <- read_excel(statsJoueursNHL, sheet = "Joueurs", col_types = ColTypesJoueurs, col_names = ColNamesJoueurs, skip = 1)
