library(eurostat)
paises <- c("AT","BE","BG","CZ","DK","DE","EE","IE","EL","ES","FR","HR","IT","CY",
            "LV","LT","LU","HU","MT","NL","PL","PT","RO","SI","SK","FI","SE","UK","IS")
time <- 2006:2016


tfr <- get_eurostat(id = "tps00199",time_format = "num", filters = list(geo = paises, time = 2006:2016))
tfr <- as.data.frame(tfr[,-1])

maw <-  get_eurostat(id = "tps00017",time_format = "num", filters = list(geo = paises, time = 2006:2016))
maw <- maw[maw$indic_de == "AGEMOTH",]                                                                         
maw <- as.data.frame(maw[,-1])

leb <- get_eurostat(id = "tps00205",time_format = "num", filters = list(geo = paises, time = 2006:2016))
leb <- leb[leb$sex == "T",]
leb <- as.data.frame(leb[,-1:-3])

le65 <- get_eurostat(id = "tps00026",time_format = "num", filters = list(geo = paises, time = 2006:2016))
le65 <- le65[le65$sex == "T",]
le65 <- as.data.frame(le65[,-1:-3])

emr <- get_eurostat(id = "tps00027",time_format = "num", filters = list(geo = paises, time = 2006:2016))
emr <- as.data.frame(emr[,-1:-2])

er <- get_eurostat(id = "tepsr_wc120",time_format = "num", filters = list(geo = paises, time = 2006:2016))
er02 <- er[er$isced11 =="ED0-2",]
er02 <- as.data.frame(er02[,-1:-4])
er34 <- er[er$isced11 =="ED3_4",]
er34 <- as.data.frame(er34[,-1:-4])
er58 <- er[er$isced11 =="ED5-8",]
er58 <- as.data.frame(er58[,-1:-4])

ur <- get_eurostat(id = "tps00159",time_format = "num", filters = list(geo = paises, time = 2006:2016))
ur1524 <- ur[ur$age =="Y15-24",]
ur1524 <- as.data.frame(ur1524[,-1:-4])
ur1564 <- ur[ur$age =="Y15-64",]
ur1564 <- as.data.frame(ur1564[,-1:-4])
ur5564 <- ur[ur$age =="Y55-64",]
ur5564 <- as.data.frame(ur5564[,-1:-4])

dsex <- get_eurostat(id = "sdg_05_20",time_format = "num", filters = list(geo = paises, time = 2006:2016))
dsex <- as.data.frame(dsex[,-1:-2])

hb <- get_eurostat(id = "tps00046",time_format = "num", filters = list(geo = paises, time = 2006:2016))
hb <- as.data.frame(hb[,-1:-2])
hb[,2] <- as.numeric(hb[,2])# não tem info para 2016
hb[is.na(hb$values),]# 6 valores omissos( 1 DK, 1 IS, 4 NL),sem imputação

daa <- get_eurostat(id = "tps00140", time_format = "num", filters = list(geo = paises, time = 2006:2016))
daa <- daa[daa$sex == "T",]
daa <- as.data.frame(daa[,-1:-4])# só temos 5 anos( 2011 a 2015)

ddc <- get_eurostat(id = "tps00116", time_format = "num", filters = list(geo = paises, time = 2006:2016))
ddc <- ddc[ddc$sex == "T",]
ddc <- as.data.frame(ddc[,-1:-4])# só temos 5 anos( 2011 a 2015)

dda <- get_eurostat(id = "tps00125", time_format = "num", filters = list(geo = paises, time = 2006:2016))
dda <- dda[dda$sex == "T",]
dda <- as.data.frame(dda[,-1:-4])# só temos 5 anos( 2011 a 2015)

pp <- get_eurostat(id = "tps00044", time_format = "num", filters = list(geo = paises, time = 2006:2016))
pp <- as.data.frame(pp[,c("geo","time","values")])
setdiff(paises,pp$geo)# falta info de "EL" e "PT"

oadr <- get_eurostat(id = "tps00198", time_format = "num", filters = list(geo = paises, time = 2006:2016))
oadr <- as.data.frame(pp[,c("geo","time","values")])
setdiff(paises,oadr$geo)# falta info de "EL" e "PT"
oadr[is.na(oadr$values),]# sem imputação (67 valores omissos), considerar retirada variável????

prpast <- get_eurostat(id = "t2020_52", time_format = "num", filters = list(geo = paises, time = 2006:2016))
prpast <- as.data.frame(prpast[prpast$unit == "PC",c("geo","time","values")])
prpast[is.na(prpast$values),]# 5 valores omissos: Roménia e Hungria

iwrp <- get_eurostat(id = "tesov110", time_format = "num", filters = list(geo = paises, time = 2006:2016))
iwrp <- as.data.frame(iwrp[iwrp$sex == "T",c("geo","time","values")])

pece <- get_eurostat(id = "tps00179", time_format = "num", filters = list(geo = paises, time = 2006:2016))
pece <- as.data.frame(pece[pece$indic_ed == "P02_0",c("geo","time","values")])
setdiff(2006:2016,pece$time)# falta info dos anos 2013,2014,2015 e 2016
pece[is.na(pece$values),]# falta "EL" de 2009

apl <- get_eurostat(id = "sdg_04_60", time_format = "num", filters = list(geo = paises, time = 2006:2016))
apl <- as.data.frame(apl[apl$sex == "T",c("geo","time","values")])

nenet <- get_eurostat(id = " tipslm90", time_format = "num", filters = list(geo = paises, time = 2006:2016))
