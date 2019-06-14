library(caper)

arcData <- read.csv("arcfeatures2.csv")
arcTree <- read.tree("arcorthocleaned.tre")

arc <- comparative.data(phy = arcTree, data = arcData, names.col = 'Species',vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)

model.pgls<-pgls(OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = arc, lambda='ML')

summary(model.pgls)

crossval <- function(data){
  
  X = as.matrix(data[,c(-1, -2)])
  t = data[,2]
  N = nrow(X)
  M = ncol(X)
  
  n_fold = N
  folds <- cut(seq(1,N),breaks=n_fold,labels=FALSE)
  RMSE = 0
  for(k in 1:n_fold){
    
    testIndexes <- which(folds==k,arr.ind=TRUE)
    X_test <- X[testIndexes, ]
    t_test <- t[testIndexes]
    
    X_train <- X[-testIndexes, ]
    t_train <- t[-testIndexes]
    
    w = solve(t(X_train)%*%X_train + diag(M))%*%t(X_train)%*%t_train
    RMSE = RMSE + mean((t_test - X_test%*%w)**2)**0.5
    
  }
  Av_RMSE = RMSE/n_fold
  cat('Av. RMSE: ', Av_RMSE, '\n')
}

crossval(model.pgls))
