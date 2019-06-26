library(ape)
library(nlme)
library(geiger)

arcData <- read.csv("arcfeatures3postdrop.csv", row.names = 1)
arcTree <- read.tree("arcorthocleanedpostdrop.tre")

arcmodel_pgls<-gls(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = arcData, correlation = corPagel(1, arcTree))
                                                                                                                                                                                                                          
summary(arcmodel_pgls)



bacData <- read.csv("bacfeatures2.csv", row.names = 1)
bacTree <- read.tree("neobacreduced3aligned.faa.contree.rooted")

td <- treedata(bacTree, bacData)

bacData <- as.data.frame(td$data)
bacTree <- td$phy


bacmodel_pgls<-gls(OGT ~ prot_F + prot_G + prot_I + prot_L + prot_M + prot_P + prot_R + prot_S + prot_T + prot_V + prot_W + prot_Y + Genome_Dinuc_AC + Genome_Dinuc_AG + Genome_Dinuc_AT + Genome_Dinuc_CG, data = bacData, correlation = corPagel(1, bacTree))

summary(bacmodel_pgls)