## load packages
require(ape)
require(phytools)
require(nlme)
require(MASS)
require(geiger)
require(evobiR)
require(caper)

#Data input
tree <- read.tree(file="arcorthocleanedpostdrop.tre")
stepData <- read.csv("arcfeatures3postdrop.csv", row.names =1)


#check and re-order data
data2 <- ReorderData(tree, stepData, taxa.names="Species")
td <- treedata(tree, data2)

## build model (using nlme)
#obj<-gls(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data=data2 ,correlation=corBrownian(1,td$phy),method="ML")
#obj<- gls(OGT ~ . - Domain - OGT - ATG - TGG, data=data2 ,correlation=corBrownian(1,td$phy),method="ML")

obj<- lm(OGT ~ . - Domain - OGT - ATG - TGG, data=stepData)



## run stepwise AIC (using MASS & nlme)
fit<-stepAIC(obj,direction="both",trace=0)
fit


caperarcData <- read.csv("arcfeatures3postdrop.csv")
caperarcTree <- read.tree("arcorthocleanedpostdrop.tre")
caperarc <- comparative.data(phy = caperarcTree, data = caperarcData, names.col = 'Species',vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)

capermodel_pgls <- pgls(OGT ~ . - Species - Domain - OGT, data = caperarc, lambda='ML')

