#!/usr/bin/Rscript

suppressMessages(library(rpart))
suppressMessages(library(dplyr))
suppressMessages(library(purrr))
suppressMessages(library(RColorBrewer))
suppressMessages(library(ggplot2))
suppressMessages(library(caret))



printf <- function(s1,s2){print(paste(s1,as.character(s2),sep=""))}



#get train data
system("./ej1.R 200 0 0 train")
trainData <- read.csv("train.csv")


# get test data
system("./ej1.R 2000 0 0 test")
testData <- read.csv("test.csv")
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


printf("Error sin cv:",res1)
printf("Error con cv:",res2)
