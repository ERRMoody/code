crossval <- function(data, estimate){
  
  X = as.matrix(data[,c(-1, -2)])
  t = data[,2]
  N = nrow(X)
  X = cbind(rep(1,N), X)
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
	
	w = estimate  
    RMSE = RMSE + mean((as.numeric(as.character(t_test - X_test %*% w))**2)**0.5)
    
    }
  Av_RMSE = RMSE/n_fold
  cat('Av. RMSE: ', Av_RMSE, '\n')
}