library(plotly)

infoPoolers<- dbReadTable(con,"evoPtsJours")[1,]
pts <- infoPoolers[(2:length(infoPoolers))]
name <- colnames(infoPoolers[2:length(infoPoolers)])
name <- as.Date(as.character(gsub('X', "", gsub(".","-",name, fixed = T))))
plot_ly(x = name, y = unname(pts), type = "bar", color = I(dbReadTable(con, "infoPoolers")[1,2]))
