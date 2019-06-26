library(caper)

arcData <- read.csv("arcfeatures2.csv")
arcTree <- read.tree("arcorthocleaned.tre")
arc <- comparative.data(phy = arcTree, data = arcData, names.col = 'Species',vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)

model_pgls<-pgls(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = arc, lambda='ML')
#model_pgls<-lm(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = arcData)

summary(model_pgls)
output <- summary(model_pgls)$coefficient

notOGTs1 <-arcData[c(-1,-2,-3)]
notOGTs <- notOGTs1[c('prot_D' , 'prot_G' , 'prot_M' , 'prot_P' , 'prot_R' , 'prot_S' , 'prot_V' , 'prot_Y' , 'Genome_Dinuc_AG' , 'Genome_Dinuc_GT' , 'AGA' , 'ATC' , 'CCC' , 'CCT' , 'CGG' , 'prot_Thermolabile' , 'S_GC')]

OGTs<-arcData[c(3)]
crossval(OGTs, notOGTs, arc)

predictions <- predict(model_pgls, notOGTs)
#mean((OGTs - predictions)**2)**0.5
residual <- OGTs - predictions
res_squared <- residual ** 2
sum_res <- sum(res_squared)
MSE <- as.numeric(sum_res/nrow(arcData))
RMSE <- MSE ** 0.5
RMSE

