library(caper)

arcData <- read.csv("arcfeatures2.csv")
arcTree <- read.tree("arcorthocleaned.tre")

arc <- comparative.data(phy = arcTree, data = arcData, names.col = 'Species',vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)

model.pgls<-pgls(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = arc, lambda='ML')

summary(model.pgls)


#plot(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = arcData)

#abline(model.pgls)
