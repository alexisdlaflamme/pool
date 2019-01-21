
#Tableau évo pts total 
evoPtsTotal<- dbReadTable(con, "evoPointsTotal")
infoPoolers<- dbReadTable(con,"infoPoolers")
name <- colnames(evoPtsTotal[2:length(evoPtsTotal)])
name <- as.Date(as.character(gsub('X', "", gsub(".","-",name, fixed = T))))
name<- c(as.Date("2018-10-03"), name)
pts<- unname(cbind(rep(0,6), evoPtsTotal[,2:length(evoPtsTotal)]))
p<- plot_ly() %>% layout(title = "Évolution Pts totaux")
for (i in 1:6){
  p<- add_trace(p, x = name, y = pts[i,], type = "scatter", mode = 'lines',color = I(infoPoolers$Couleur[i]), name = infoPoolers$Nom[i] ) 
}
p 


#
