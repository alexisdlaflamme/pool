
postgress.connect <- function() {
  
  # Make sure you install these!
  require(RPostgreSQL)
  require(pool)
  
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
                   , host     = "ec2-54-235-96-48.compute-1.amazonaws.com"
                   , port     = 5432
                   , user     = "hyjwmtibyxqhzs"
                   , password = "b55061358ae8a6ccd79a7d59df2315f9d9276477c12b0609230c19dd23f98651"
                   , dbname   = "d8t0tkn8mpo2a6"
                   
    )
    print("Heroku application detected connecting to Postgres local")
  }
  
  return(pool)
}

con <- postgress.connect()





