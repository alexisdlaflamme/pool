library(processx)
library(RPostgres)
library(httr)
library(dbplyr)
library(tidyverse)

# this example assumes you've created a heroku postgresql
# instance and have the app name (in this example, "rpgtestcon").

# use the heroku command-line app
# we do this as the creds change & it avoids disclosure
config <- run("heroku config:get DATABASE_URL -a testpool")

# ^^ gets us a URL, we need the parts
pg <- httr::parse_url(config$stdout)

# use the parts from ^^
dbConnect(RPostgres::Postgres(),
          dbname = trimws(pg$path),
          host = pg$hostname,
          port = pg$port,
          user = pg$username,
          password = pg$password,
          sslmode = "require"
)-> db_con

#dbcon<-dbConnect(RPostgres::Postgres(),dbname = 'd2tn74iejrtdue', 
#                 host = 'ec2-50-16-231-2.compute-1.amazonaws.com', 
#                 port = 5432, 
#                 user = 'rkvaizleemdacw',
#                 password = '7efca54493c95afc32fd648ac7bbdf0f2c4f6ba935e2b3fd7745d6bf545d2972') 


# hook it up to dbplyr
#db <- src_dbi(dbcon)

# boom
#db
## src:  PqConnection
## tbls:

#dbListTables(dbcon)