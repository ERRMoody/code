library(caper)
library(phylolm)

arcData <- read.csv("arcfeatures2.csv")
arcTree <- read.tree("arcorthocleanedpostdrop.tre")
arc <- comparative.data(phy = arcTree, data = arcData, names.col = 'Species')

model_pgls <- pgls(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = arc, lambda=0.001)

#arcData <- read.csv("arcfeatures2.csv", row.names = 1)

#model_pgls <- phylolm(formula = OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + 
#                        prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + 
#                        AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = arcData, 
#                      phy = arcTree, model = c("lambda"), lower.bound = NULL, upper.bound = NULL, 
#                      starting.value = NULL, measurement_error = FALSE, boot = 0, 
#                      full.matrix = TRUE)

#model_pgls<-lm(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = arcData)
summary(model_pgls)

notOGTs <- arcData[c('prot_D', 'prot_G', 'prot_M', 'prot_P', 'prot_R', 'prot_S', 'prot_V', 'prot_Y', 
                     'Genome_Dinuc_AG', 'Genome_Dinuc_GT', 'AGA', 'ATC', 'CCC', 'CCT', 'CGG', 'prot_Thermolabile', 
                     'S_GC')]
OGTs<-arcData[c(3)]

crossval(OGTs, notOGTs, cbind(arcData['OGT'],arcData['Species'],notOGTs), arcTree)

#predictions <- predict(model_pgls, notOGTs)
#mean((OGTs - predictions)**2)**0.5
#residual <- OGTs - predictions
#res_squared <- residual ** 2
#sum_res <- sum(res_squared)
#MSE <- as.numeric(sum_res/nrow(arcData))
#RMSE <- MSE ** 0.5
#RMSE


#Stepwise selection

#stepData <- read.csv("arcfeatures2.csv")
#stepTree <- read.caic("arcorthocleaned.tre")
