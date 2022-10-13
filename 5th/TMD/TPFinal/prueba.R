library(randomForest)
#Random forest
rf <- function(train,trainClass,test,testClass,formula){
  model <- randomForest(formula,train,ntree=1000)
  return(misclass(predict(model,test),testClass))
}
