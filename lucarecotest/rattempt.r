setwd("~/OneDrive/Documents/code/lucarecotest")
home <- getwd()

library(ape)



tr <- read.tree("pteryxroot.tre")


#tr$node.label <- nodelabels(text=1:tr$Nnode,node=1:tr$Nnode+Ntip(tr))

#trs <- (tr$node.label <- nodelabels(text=1:tr$Nnode,node=1:tr$Nnode+Ntip(tr)))

#plot(trs)

write.tree(tr, file="testtreelabels.tre")