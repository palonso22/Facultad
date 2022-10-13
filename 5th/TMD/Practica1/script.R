#!/usr/bin/Rscript



suppressMessages(library(rpart))
suppressMessages(library(dplyr))
suppressMessages(library(purrr))
suppressMessages(library(RColorBrewer))
suppressMessages(library(ggplot2))
suppressMessages(library(caret))
suppressMessages(library(class))




printf <- function(s1,s2){print(paste(s1,as.character(s2),sep=""))}


generatorD <- function(n,d,mean,sd,class){
  #gerate point mapping vector of size n
  points <- 1:n %>% map(function(x) c(rnorm(d,mean,var),class))
  m<-matrix(unlist(points),n,byrow=TRUE)
  data.frame(x=m[,1],y=m[,2],class=as.factor(m[,3]))
}



diagonal <- function(n,d,c){
  #standar deviation
  sd <- c*sqrt(d)
  # half of examples for each class
  ctos <- n %/% 2
  # generate and join
  rbind(generatorD(ctos,d,-1,sd,0),generatorD(n-ctos,d,1,sd,1))
}




class0 <- function(r){
  runif(1,r*4*pi-pi,r*4*pi);
}


class1 <- function(r){
  runif(1,r*4*pi,r*4*pi+pi);
}



generatorS <- function(r,fun,xOr,yOr,class){
  theta <- unlist(r %>% map(function(x) fun(x)))
  x <- xOr + r*cos(theta)
  y <- yOr + r*sin(theta)
  data.frame(x,y,class)
}



espiral <- function(n,xOr,yOr){
  # half of examples for each class
  ctos <- n %/% 2
  #first generate r distances between 0 and 1
  r <- sqrt(runif(n))
  #half for each class
  ctos <- n %/%2
  rbind(generatorS(head(r,ctos),class0,xOr,yOr,rep(0,ctos)),generatorS(tail(r,n-ctos),class1,xOr,yOr,rep(1,n-ctos)))
}



trainTree <- function(trainData,testData){
  testTarget <- testData$class

  #eval model with cp given
  eval <- function(cp){
    #build model
    mytree <- rpart(class ~ .,data = trainData,method = "class",cp=cp)
    #make prediction
    pred <- predict(mytree,testData, type="class")
    #confuse matrix
    m <- as.matrix(table(pred,testTarget))
    #compute classifing error
    (m[1,2]+m[2,1])/2000
  }

  #comlexity parameter control the grow of the tree
  #compute several cps
  cps <- unlist(1:10 %>% map(function(x) 10^(-x)))


  m <- matrix(cps,nrow=10,ncol=1)
  #apply eval function to cps
  errors <- apply(m, c(1,2),eval)[,1]


  #min error
  res1 <- min(errors)
  #change class to factor so train not complain
  trainData <- data.frame(x=trainData[,1],y=trainData[,2],class=as.factor(trainData[,3]))
  set.seed(123)
  # Define training control
  trainCtrl <- trainControl(method = "cv", number = 5)
  # Train the model with 5 fold cross validation and recover best model
  bestModel <- train(class ~., data = trainData, method = "rpart",trControl = trainCtrl)$finalModel
  # new prediction
  pred <- predict(bestModel,testData, type="class")
  #new confuse matrix
  m <- as.matrix(table(pred,testTarget))
  #new compute classifing error
  res2 <- (m[1,2]+m[2,1])/2000


  print("------------------")
  printf("Error sin 5 fold cv:",res1)
  printf("Error con 5 fold cv:",res2)
  print("------------------")
}


trainKNN <- function(trainData,testData){
  testTarget <- testData[,3]
  trainTarget <- trainData[,3]

  eval <- function(k) {
       pred <- knn(data.frame(trainData[,1],trainData[,2]),data.frame(testData[,1],testData[,2]),cl=trainTarget,k)
       m <- as.matrix(table(pred,testTarget))
       (m[1,2]+m[2,1])/2000
     }


  ctosK <- 100
  #confusion matrix
  m <- matrix(1:ctosK,nrow=ctosK, ncol=1)
  res <- apply(m, c(1,2),eval)[,1]

  # take the less error
  res1 <- min(res)

  trainData <- data.frame(x=trainData[,1],y=trainData[,2],class=as.factor(trainData[,3]))
  # Define training control
  set.seed(123)
  trainCtrl <- trainControl(method = "cv", number = 5)
  # Train the model with 5 fold cross validations and optimize the k value
  bestK <- train(class~., data = trainData, method = "knn",trControl = trainCtrl)$results[1,1]
  #new prediction
  pred <- knn(data.frame(trainData[,1],trainData[,2]),data.frame(testData[,1],testData[,2]),cl=trainTarget,bestK)


  #new confuse matrix
  m <- as.matrix(table(pred,testTarget))
  #new compute classifing error
  res2 <- (m[1,2]+m[2,1])/2000
  print("------------------")
  printf("Error sin 5 fold cv:",res1)
  printf("Error con 5 fold cv:",res2)
  print("------------------")
}


trainData <- diagonal(200,2,0.78)
testData <- diagonal(2000,2,0.78)
print("Problema diagonal:")
print("////////////////////")
print("Árboles de decisión")
print("===================")
trainTree(trainData,testData)
print("")
print("")
print("")
print("K vecinos más cercanos")
print("======================")
trainKNN(trainData,testData)
print("")
print("")
print("")
print("")
print("")
print("Problema espiral:")
print("////////////////////")
trainData <- espiral(200,0,0)
testData <- espiral(2000,0,0)
print("Árboles de decisión")
print("===================")
trainTree(trainData,testData)
print("")
print("")
print("")
print("K vecinos más cercanos")
print("======================")
trainKNN(trainData,testData)
