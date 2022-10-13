
#clasificacion



testPerformance <- function(data,tuneModel,k,class,formula){
  folds <- createFolds(1:nrow(data),k)
  errors <- double(k)
  for(i in 1:k){
    print(i)
    trainIx <- as.vector(unlist(folds[-i]))
    testIx <- as.vector(unlist(folds[i]))
    train <- data[trainIx,]
    trainClass <- class[trainIx]
    test <- data[testIx,]
    testClass <- class[testIx]
    errors[i] <- tuneModel(train,trainClass,test,testClass,formula)
  }
  return(mean(errors))
}




misclass <- function(res,test){
  tab <- table(res,test)
  library(e1071)
  optimalMatch <- matchClasses(as.matrix(tab),method="exact",verbose = TRUE)
  m <- tab[,optimalMatch]
  ctos <- length(test)
  return((ctos-sum(diag(m)))/ctos)
}




# Find best number of rounds for Ada boosting
tuneAda <- function(train,trainClass,test,testClass,formula){
  errors <- 0
  #Define a function which depends of data and rounds
  eval <- function(x,xClass,y,yClass,formula,depth){
    model <- boosting(formula=formula,data=x, mfinal = 50, coef="Freund", control = rpart.control(maxdepth =depth)) 
    return(misclass(predict(model,y)$class,yClass))
  }
  
  # measure performance for ada with depth between 1:10
  for (i in 1:10){
    cat("depth:",i)
    evalWithDepth <- function(x,xClass,y,yClass,formula) eval(x,xClass,y,yClass,formula,i)
    error <- sapply(1:5,function(j) evalWithDepth(train,trainClass,test,testClass,formula)) 
    errors[i] <- mean(error)
  }
  #Recover the optimal depth
  optimalDepth <- which.min(errors)
  cat("optimal depth",optimalDepth)
  #Measure the performance with the optimal number depth
  error <- eval(train,trainClass,test,testClass,formula,optimalDepth)
  cat("optimal depth: ",optimalDepth)
  cat("error: ",error)
  return(error)
}

# usamos ada boosting para clasificar los datos
resAda <- testPerformance(lampone,tuneAda,5,lampone[,142],N_tipo~.)










