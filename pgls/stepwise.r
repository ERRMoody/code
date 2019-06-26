## load packages
require(phytools)
require(nlme)
require(MASS)


#Data input
tree <- read.newick(file="arcorthocleanedpostdrop.tre")
stepData <- read.csv("arcfeatures2.csv")

## build model (using nlme)
obj<-gls(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data=stepData ,correlation=corBrownian(1,tree),method="ML")


## run stepwise AIC (using MASS & nlme)
fit<-stepAIC(obj,direction="both",trace=0)

fit
