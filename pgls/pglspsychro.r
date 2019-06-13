library(caper)

arcData <- read.csv("arcpsychro2.csv")
arcTree <- read.tree("arcorthocleaned.tre")

arc <- comparative.data(phy = arcTree, data = arcData, names.col = 'Species',vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)

model.pgls<-pgls(OGT~ prot_D + prot_E, data = arc, lambda='ML')

summary(model.pgls)
