library(caper)

bacData <- read.csv("bacfeatures2.csv")

bacTree <- read.tree("neobacreduced3aligned.faa.contree.rooted")

bac <- comparative.data(phy = bacTree, data = bacData, names.col = 'Species',vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)



model_pgls<-pgls(OGT ~ prot_F + prot_G + prot_I + prot_L + prot_M + prot_P + prot_R + prot_S + prot_T + prot_V + prot_W + prot_Y + Genome_Dinuc_AC + Genome_Dinuc_AG + Genome_Dinuc_AT + Genome_Dinuc_CG, data = bac, lambda='ML')

#model_pgls<-lm(OGT ~ prot_F + prot_G + prot_I + prot_L + prot_M + prot_P + prot_R + prot_S + prot_T + prot_V + prot_W + prot_Y + Genome_Dinuc_AC + Genome_Dinuc_AG + Genome_Dinuc_AT + Genome_Dinuc_CG, data = bacData, lambda='ML')



summary(model_pgls)

#output <- summary(model.pgls)$coefficient

#crossval(arcData, output[,1])



output <- summary(model_pgls)$coefficient

#crossval(arcData, output[,1])

notOGTs <-bacData[c(-1,-2,-3)]

OGTs<-bacData[c(3)]

predictions <- predict(model_pgls, notOGTs)

#mean((OGTs - predictions)**2)**0.5

residual <- OGTs - predictions

res_squared <- residual ** 2

sum_res <- sum(res_squared)

MSE <- as.numeric(sum_res/nrow(bac$data))

RMSE <- MSE ** 0.5

RMSE



