library(ape)
library(nlme)
library(geiger)
library(caper)
library(phylolm)

arcData <- read.csv("arcfeatures3postdrop.csv", row.names = 1)
arcTree <- read.tree("arcorthocleanedpostdrop.tre")
arcmodel_pgls<-gls(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = arcData, correlation = corPagel(1, arcTree))

caperarcData <- read.csv("arcfeatures3postdrop.csv")
caperarcTree <- read.tree("arcorthocleanedpostdrop.tre")
caperarc <- comparative.data(phy = caperarcTree, data = caperarcData, names.col = 'Species',vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)
capermodel_pgls<-pgls(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = caperarc, lambda='ML')

phylolm_pgls <- phylolm(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = arcData, arcTree, model = c("lambda"), lower.bound = NULL, upper.bound = NULL, starting.value = NULL, measurement_error = FALSE, boot=0,full.matrix = TRUE)


summary(arcmodel_pgls)
summary(capermodel_pgls)
summary(phylolm_pgls)

bacData <- read.csv("bacfeatures2.csv", row.names = 1)
bacTree <- read.tree("neobacreduced3aligned.faa.contree.rooted")
td <- treedata(bacTree, bacData)
bacData <- as.data.frame(td$data)
bacTree <- td$phy
bacmodel_pgls <- phylolm (OGT ~ prot_F + prot_G + prot_I + prot_L + prot_M + prot_P + prot_R + prot_S + prot_T + prot_V + prot_W + prot_Y + Genome_Dinuc_AC + Genome_Dinuc_AG + Genome_Dinuc_AT + Genome_Dinuc_CG, data = bacData, bacTree, model = c("lambda"), lower.bound = NULL, upper.bound = NULL, starting.value = NULL, measurement_error = FALSE, boot=0,full.matrix = TRUE)


caperbacData <- read.csv("bacfeatures2.csv")
caperbacTree <- read.tree("neobacreduced3aligned.faa.contree.rooted")
caperbac <- comparative.data(phy = caperbacTree, data = caperbacData, names.col = 'Species',vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)
caperbacmodel_pgls <- pgls(OGT ~ prot_F + prot_G + prot_I + prot_L + prot_M + prot_P + prot_R + prot_S + prot_T + prot_V + prot_W + prot_Y + Genome_Dinuc_AC + Genome_Dinuc_AG + Genome_Dinuc_AT + Genome_Dinuc_CG, data = caperbac, lambda='ML')
summary(caperbacmodel_pgls)