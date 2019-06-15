library(caper)

bacData <- read.csv("bacfeatures2.csv")
bacTree <- read.tree("neobacreduced3aligned.faa.contree.rooted")
bac <- comparative.data(phy = bacTree, data = bacData, names.col = 'Species',vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)

model.pgls<-pgls(OGT ~ prot_F + prot_G + prot_I + prot_L + prot_M + prot_P + prot_R + prot_S + prot_T + prot_V + prot_W + prot_Y + Genome_Dinuc_AC + Genome_Dinuc_AG + Genome_Dinuc_AT + Genome_Dinuc_CG, data = bac, lambda='ML')

summary(model.pgls)

#output <- summary(model.pgls)$coefficient

#crossval(arcData, output[,1])



