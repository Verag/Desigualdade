###1º parte: definição dos grupos

#Obtenção e tratamento dos dados
library(eurostat)
paises <- c("AT","BE","BG","CZ","DK","DE","EE","IE","EL","ES","FR","HR","IT","CY",
            "LV","LT","LU","HU","MT","NL","PL","PT","RO","SI","SK","FI","SE","UK","IS")
gini <- get_eurostat(id = "sdg_10_40",time_format = "num", filters = list(geo = paises, time = 2006:2016))
gini <- as.data.frame(gini[,-1])
str(gini)
head(gini)
summary(gini)
        
#Valores omissos
sum(is.na(gini))# 1.567% dos dados
gini[is.na(gini$values),]#identificar casos com valores omissos
#Imputação dos valores da  PORDATA aos valores omissos da Hungria
which(gini$geo == "HR" & gini$time == "2006")
gini$values[133] <- 33.3
gini$values[134] <- 25.6
gini$values[135] <- 25.2
gini$values[136] <- 24.7

library(imputeTS)
which(gini$geo == "RO" & gini$time == "2006")
na.interpolation(gini$values[gini$geo == "RO"], option = "linear")
gini$values[265] <- 38.3

library(ggplot2)
g <- ggplot(gini, aes(x= time,y = values, color = geo))
g <- g + geom_line() + labs( title = "Índice de Gini", x = "Anos em estudo",
                             y = "Valores do índice de gini")
g <- g + theme(plot.title = element_text(hjust = 0.5))
g

#alterar formato dados
wgini <- reshape(gini,idvar = "geo",timevar = "time", direction = "wide")

#Gráfico de todas as trajetórias na mesma escala
library(lattice)
parallelplot(wgini[,-1], horizontal.axis=FALSE, 
             scales=list(x=list(rot=45, 
                               at=seq(1,ncol(wgini)-1,by=1), 
                               labels=substr(names(wgini[,-1])[seq(1,ncol(wgini)-1, by = 1)],8,100))),
             main = "Paralleleplot", comb = 0)



library(kml)
names(wgini) <- c("id", c(2006:2016))
kgini <- cld(wgini)
gini.res <- kml(kgini,toPlot ="both")#baseado na distância euclediana
choice(kgini)

library(kmlShape)
wsgini <- as.matrix(wgini)
Sgini <- cldsWide(wsgini, time = 2006:2016, id = paises)

giniS.res <- kmlShape(Sgini,nbClusters = 4,timeScale = 0.005, FrechetSumOrMax = "sum",
                      toPlot = "both")# baseado na distância de Freachet e DTW
