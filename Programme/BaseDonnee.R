library(processx)
library(RPostgreSQL)
library(httr)
library(dbplyr)
library(tidyverse)

# this example assumes you've created a heroku postgresql
# instance and have the app name (in this example, "rpgtestcon").

# use the heroku command-line app
# we do this as the creds change & it avoids disclosure
config <- run("heroku", c("config:get", "DATABASE_URL", "-a", "poolhockey"))

# ^^ gets us a URL, we need the parts
pg <- httr::parse_url(config$stdout)

# use the parts from ^^
dbConnect(dbDriver("PostgreSQL"),
          dbname = trimws(pg$path),
          host = pg$hostname,
          port = pg$port,
          user = pg$username,
          password = pg$password,
          sslmode = "require"
) -> db_con

# hook it up to dbplyr
db <- src_dbi(db_con)

# boom
db
## src:  PqConnection
## tbls:

xdf <- copy_to(db, iris, name="iris", overwrite = TRUE)

