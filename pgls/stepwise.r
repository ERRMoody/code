## load packages
require(ape)
require(phytools)
require(nlme)
require(MASS)
require(geiger)
require(evobiR)


#Data input
tree <- read.tree(file="arcorthocleanedpostdrop.tre")
stepData <- read.csv("arcfeatures2.csv", row.names =1)


#check and re-order data
data2 <- ReorderData(tree, stepData, taxa.names="Species")
td <- treedata(tree, data2)






## build model (using nlme)
obj<-gls(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data=data2 ,correlation=corBrownian(1,td$phy),method="ML")


## run stepwise AIC (using MASS & nlme)
fit<-stepAIC(obj,direction="both",trace=0)

fit
