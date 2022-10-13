#!/usr/bin/Rscript
suppressMessages(library(class))
suppressMessages(library(ggplot2))
suppressMessages(library(caret))

printf <- function(s1,s2){print(paste(s1,as.character(s2),sep=""))}


system("./ej1.R 200 2 1.5 train")
trainData <- read.csv("train.csv")


system("./ej1.R 2000 2 1.5 test")
testData <- read.csv("test.csv")

trainTarget <- trainData[,3]
testTarget <- testData[,3]

eval <- function(k) {
     pred <- knn(data.frame(trainData[,1],trainData[,2]),data.frame(testData[,1],testData[,2]),cl=trainTarget,k)
     m <- as.matrix(table(pred,testTarget))
     (m[1,2]+m[2,1])/2000
   }


ctosK <- 100
m <- matrix(1:ctosK,nrow=ctosK, ncol=1)
res <- apply(m, c(1,2),eval)[,1]

res1 <- min(res)

trainData <- data.frame(x=trainData[,1],y=trainData[,2],class=as.factor(trainData[,3]))


# Define training control
set.seed(123)
trainCtrl <- trainControl(method = "cv", number = 5)
# Train the model with 5 fold cross validations
bestK <- train(class~., data = trainData, method = "knn",trControl = trainCtrl)$results[1,1]
#new prediction
pred <- knn(data.frame(trainData[,1],trainData[,2]),data.frame(testData[,1],testData[,2]),cl=trainTarget,bestK)


#new confuse matrix
m <- as.matrix(table(pred,testTarget))
#new compute classifing error
res2 <- (m[1,2]+m[2,1])/2000

printf("Error sin cv:",res1)
printf("Error con cv:",res2)
