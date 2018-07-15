

#install.packages("RPostgreSQL")
library("RPostgreSQL")
#this completes installing packages
#now start creating connection

con<-dbConnect(dbDriver("PostgreSQL"), dbname="d3n51p55ij2eet", host="ec2-54-227-240-7.compute-1.amazonaws.com", port=5432, user="qukzhzjhfyxyin",password="ced47dfa459ed8d9666766d23318d2c104b987317f92d6c91365da4f3ed73f28")

#this completes creating connection
#get all the tables from connection
dbListTables(con)


######################################################################################


library(processx)
library(RPostgres)
library(httr)
library(dbplyr)
library(tidyverse)

config <- run("heroku", c("config:get", "DATABASE_URL", "-a", "poolhockey"))

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
) -> db_con

# hook it up to dbplyr
db <- src_dbi(db_con)

# boom
db
## src:  PqConnection
## tbls:

xdf <- copy_to(db, iris, name="iris", overwrite = TRUE)

db
## src:  PqConnection
## tbls: iris

xdf