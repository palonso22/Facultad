rm(list = ls())
setwd("~/Desktop/Facultad/5to\ año/TMD/TPFinal")

data1 <- read.csv("test.csv")
data2 <- read.csv("train.csv")
data <- rbind(data1,data2)



#2 Selección de variables


#---------------------------------------------------------------------------
#random forest ranking method for rfe.
#---------------------------------------------------------------------------
imp.rf <- function(x.train,y,equalize.classes=TRUE,tot.trees=50,mtry=0)
{
  if(mtry<1) mtry<-floor(sqrt(dim(x.train)[2]))
  prop.samples<-table(y)
  if(equalize.classes) prop.samples<-rep(min(prop.samples),length(prop.samples))
  
  m.rf<-randomForest(x.train,y,ntree=tot.trees,mtry=mtry,sampsize=prop.samples,importance=TRUE)
  imp.mat<-importance(m.rf)
  imp.col<-dim(imp.mat)[2]-1
  rank.list<-sort(imp.mat[,imp.col],decreasing=FALSE,index=T)
  return(list(feats=rank.list$ix,imp=rank.list$x))
}


rfe.ranking <- function(x,y,method){
  keepFeatures <- 1:dim(x)[2]
  totalFeatures <- length(keepFeatures)
  keepData <- x
  orderFeatures <- 1:totalFeatures
  if(totalFeatures > 1){
    for(i in totalFeatures:2){
      cat("Iter:",i)
      ranking <- (do.call(method, c(list(keepData,y)) ))[["feats"]]
      lessImp <- ranking[1] #index
      orderFeatures[i] <- keepFeatures[lessImp]  # assign order to feature
      keepData <- keepData[,-lessImp] # discard column in data
      keepFeatures <- keepFeatures[-lessImp] # discard feature
    }
  }
  
  orderFeatures[1] <- keepFeatures[1]
  
  search.names <- colnames(x)[orderFeatures] # order colnames
  imp<-(totalFeatures:1)/totalFeatures # compute importance
  names(imp)<-search.names # assign colnames to importance vector
  
  return( list(ordered.names.list=search.names,ordered.features.list=orderFeatures,importance=imp) )
}


misclass <- function(res,test){
  tab <- table(res,test)
  
  optimalMatch <- matchClasses(as.matrix(tab),method="exact",verbose = TRUE)
  m <- tab[,optimalMatch]
  ctos <- length(test)
  return((ctos-sum(diag(m)))/ctos)
}


library(randomForest)
#Random forest
rf <- function(train,trainClass,test,testClass,formula){
  model <- randomForest(formula,train,ntree=200)
  return(misclass(predict(model,test),testClass))
}



pca <- prcomp(scale(data[,-563]))
summary(pca)
pca$Activity <- as.factor(data[,563])
data$Activity <- as.factor(data$Activity)

ctos <- nrow(data)
train <- sample(1:ctos,0.8*ctos)
rf(pca[train,],pca[train,101],pca[-train,],pca[-train,101],Activity~.)
rf(data[train,],data[train,563],data[-train,],data[-train,563],Activity~.)
