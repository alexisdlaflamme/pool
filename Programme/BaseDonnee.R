
postgress.connect <- function() {
  
  # Make sure you install these!
  require(RPostgreSQL)
  require(pool)
  
  #driver
  drv <- dbDriver("PostgreSQL")
  
  #attempt connection
  if (Sys.getenv("DATABASE_URL") != "") {
    url <- httr::parse_url(Sys.getenv("DATABASE_URL"))
    pool <- dbPool(drv
                   , host     = url$hostname
                   , port     = url$port
                   , user     = url$user
                   , password = url$password
                   , dbname   = url$path
    )
    print("Heroku application detected connecting to Postgres")
    
  } else {
    # You would setup a localhost  db connection to your personal computer here!
  }
  
  return(pool)
}

pg <- postgress.connect()
