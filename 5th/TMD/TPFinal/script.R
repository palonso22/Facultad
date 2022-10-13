rm(list = ls())
setwd("~/Desktop/Facultad/5to\ año/TMD/TPFinal")

recipe0 <- read.csv("recipeData.csv")
recipe1 <- recipe0[,-c(1,2,3,4,5,16,17,19,20,21,22,23)]
recipe <- recipe1[recipe1$BoilGravity != "N/A",]
recipe$BoilGravity <- as.numeric(recipe$BoilGravity)
recipe$BrewMethod <- as.factor(recipe$BrewMethod)
#attach(recipe)

library(randomForest)
library(e1071)
library(caret)




#Random forest
rf <- function(train,trainClass,test,testClass,formula){
  model <- randomForest(formula,train,ntree=500)
  return(misclass(predict(model,test),testClass))
}


#SVM polynomial kernel
polyKernel <- function(train,trainClass,test,testClass,formula){
  #model <- tune.svm(formula, data=train, kernel="polynomial",degree = 2,cost = 10^-1)$best.model 
  model <- train(formula, data = train, method = "svmLinear")
  return(misclass(predict(model,test),testClass))
}


#SVM gaussian kernel
gausKernel <- function(train,trainClass,test,testClass,formula){
  model <- tune.svm(formula, data=train, tunecontrol = tune.control(sampling = "cross",cross=5),gamma = 10^(-10:0),cost = 10^(-5:5))$best.model 
  return(misclass(predict(model,test),testClass))
}





misclass <- function(res,test){
  tab <- table(res,test)
  
  optimalMatch <- matchClasses(as.matrix(tab),method="exact",verbose = TRUE)
  m <- tab[,optimalMatch]
  ctos <- length(test)
  return((ctos-sum(diag(m)))/ctos)
}



pca <- as.data.frame(prcomp(scale(recipe[,-11]))$x[,1:7])
pca$BrewMethod <- as.factor(recipe$BrewMethod)
ctos <- nrow(recipe)
train <- sample(1:ctos,1000)
library(rpart)

gausKernel(pca[train,],pca[train,8],pca[-train,],pca[-train,8],BrewMethod~.)

model <- randomForest(BrewMethod~.,pca[train,],ntree=400)
p <- predict(model,pca[-train,-11],type="class")
misclass(p,recipe[-train,11])






#posible brew methods 
#allGain <- unique(recipe$BrewMethod)


  



