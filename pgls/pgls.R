library(caper)

arcData <- read.csv("ArchaeaforR.csv")
arcTree <- read.tree("plusIG.tr")

arc <- comparative.data(phy = arcTree, data = arcData, names.col = 'Species',vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)

model.pgls<-pgls(log(OGT)~ log(avgproteinlength), data = arc, lambda='ML', bounds = list(lambda=c(0.001,1), kappa=c(1e-6,3), delta=c(1e-6,3)))
summary(model.pgls)


plot(log(OGT) ~ log(avgproteinlength), data = arcData)
abline(model.pgls)

profile_lambda=pgls.profile(model.pgls, which="lambda") # vary lambda
plot(profile_lambda)
  