crossval <- function(t, X, data, Tree){
  
  X = as.matrix(X)
  N = nrow(X)
  X = cbind(rep(1,N), X)
  M = ncol(X)
  
  n_fold = N
  folds <- cut(seq(1,N),breaks=n_fold,labels=FALSE)
  RMSE = 0
  for(k in 1:n_fold){
    
    cat('Fold: ', k, '\n')
    
    testIndexes <- which(folds==k,arr.ind=TRUE)
    X_test <- X[testIndexes, ]
    t_test <- t[testIndexes, ]

    X_train <- X[-testIndexes, ]
    t_train <- t[-testIndexes, ]
    data_train <- data[-testIndexes, ]
    
    comp.dat <- comparative.data(phy = Tree, data = data_train, names.col = 'Species')
    Tree2 <- drop.tip(Tree, comp.dat$dropped$tips)

    model <- phylolm(formula = OGT ~ prot_D + prot_G + prot_M + prot_P + prot_R + 
                       prot_S + prot_V + prot_Y + Genome_Dinuc_AG + Genome_Dinuc_GT + 
                       AGA + ATC + CCC + CCT + CGG + prot_Thermolabile + S_GC, data = data_train, 
                     phy = Tree2, model = c("lambda"), lower.bound = NULL, upper.bound = NULL, 
                     starting.value = NULL, measurement_error = FALSE, boot = 0, 
                     full.matrix = TRUE)
    #model <- lm(t_train ~ X_train[,-c(1)])
    
    output <- summary(model)$coefficient
    w = output[,1]
    RMSE = RMSE + mean((t_test - X_test %*% w)**2)**0.5
    
    }
  Av_RMSE = RMSE/n_fold
  cat('Av. RMSE: ', Av_RMSE, '\n')
}