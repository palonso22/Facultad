setwd("~/Desktop/Facultad/5to\ año/TMD/Practica4")
library(adabag)
library(ggplot2)
library(randomForest)
library(e1071)


data <- load("datos.Rdata")


# given train,test and depth return error
eval <- function(train,test,depth){
  boost <- boosting(class ~ ., data = train, mfinal = 400, coef="Freund", control = rpart.control(maxdepth =depth))
  newPredict <- predict(boost,test)
  return(newPredict$error)
}




#eval espiral data
espErrors <- sapply(1:20,function(i) eval(esp_train,esp_test,i))
diagErrors <- sapply(1:20,function(i) eval(diag_train,diag_test,i))
dfError <- data.frame(x=1:20,y=espErrors,z=diagErrors)
plot <- ggplot(dfError) +
         scale_colour_manual("",
                       breaks = c("Diagonal", "Espiral"),
                       values = c("Diagonal"="green", "Espiral"="red")) +
         geom_line(aes(x,y,colour="Espiral")) +
         geom_point(aes(x,y),color = "red", pch=16,size=2) +
         geom_line(aes(x,z,colour="Diagonal")) +
         geom_point(aes(x,z),color = "green", pch=16,size=2) +
         scale_x_continuous(breaks=seq(0,20,by=2)) +
         labs(x="Profundidad",y="Error",title="Fig 1: Efecto de la complejidad en boosting") +
         theme(plot.title = element_text(face="bold",size=10,hjust = 0.5),axis.text.x= element_text(size=7))



plot

#Ej 2

load("lampone.Rdata")
lampone <- lampone[,-c(1,144),drop=FALSE]



misclass <- function(res,test){
  tab <- table(res,test)
  optimalMatch <- matchClasses(as.matrix(tab),method="exact",verbose = TRUE)
  m <- tab[,optimalMatch]
  ctos <- length(test)
  return((ctos-sum(diag(m)))/ctos)
}



#Generic funcion to measure the performance of a machine learning algorithm 
# through k-fold
testPerformance <- function(data,tuneModel,k,class,formula){
  folds <- createFolds(1:nrow(data),k)
  errors <- double(k)
  for(i in 1:k){
    print(i)
    trainIx <- as.vector(unlist(folds[-i]))
    testIx <- as.vector(unlist(folds[i]))
    train <- data[trainIx,,drop=FALSE]
    trainClass <- class[trainIx]
    test <- data[testIx,,drop=FALSE]
    testClass <- class[testIx]
    errors[i] <- tuneModel(train,trainClass,test,testClass,formula)
    cat("Error ",i,":",errors[i])
  }
  return(mean(errors))
}




#Random forest
rf <- function(train,trainClass,test,testClass,formula){
  model <- randomForest(formula,train,ntree=1000)
  return(misclass(predict(model,test),testClass))
}

#SVM polynomial kernel
polyKernel <- function(train,trainClass,test,testClass,formula){
  #model <- tune.svm(formula, data=train, tunecontrol = tune.control(sampling = "cross",cross=5),kernel="polynomial",degree = 1:3,cost = 10^(-1:3))$best.model 
  model <- train(formula, data = train, method = "svmLinear")
  return(misclass(predict(model,test),testClass))
}


#SVM gaussian kernel
gausKernel <- function(train,trainClass,test,testClass,formula){
  model <- tune.svm(formula, data=train, tunecontrol = tune.control(sampling = "cross",cross=5),gamma = 10^(-10:0),cost = 10^(-5:5))$best.model 
  return(misclass(predict(model,test),testClass))
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


printRes<- function(resPoly,resGaus,resAda,resRf){
  cat("SVM Poly ",resPoly)
  cat("SVM Gaus ",resGaus)
  cat("Ada boost ",resAda)
  cat("Random Forest ",resRf)
}


lampone[,142] <- as.factor(lampone[,142])
resPoly <- testPerformance(lampone,polyKernel,5,lampone[,142],N_tipo~.)
resGaus <- testPerformance(lampone,gausKernel,5,lampone[,142],N_tipo~.)
resAda <- testPerformance(lampone,tuneAda,5,as.factor(lampone[,142]),N_tipo~.)
resRf <- testPerformance(lampone,rf,5,lampone[,142],N_tipo~.)

printRes(resPoly,resGaus,resAda,resRf)


#RRL data

resPoly <- testPerformance(pca,polyKernel,5,pca[,50],N_tipo~.)
resGaus <- testPerformance(pca,gausKernel,5,pca[,50],N_tipo~.)
resAda <- testPerformance(pca,tuneAda,5,pca[,50],N_tipo~.)
resRf <- testPerformance(pca,rf,5,pca[,50],N_tipo~.)
printRes(resPoly,resGaus,resAda,resRf)



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



# rankear variables de acuerdo  a su importancia
res <- rfe.ranking(lampone[,-142],as.factor(lampone[,142]),"imp.rf")
cleanData <- lampone[,c(res$ordered.features.list[1:5],142)]
plot(cleanData[,-6],col=cleanData[,6])


#Ej 3
resPoly <- testPerformance(RRL,polyKernel,5,RRL[,70],Tipo~.)
resGaus <- testPerformance(RRL,gausKernel,5,RRL[,70],Tipo~.)
resAda <- testPerformance(RRL,tuneAda,5,RRL[,70],Tipo~.)
resRf <- testPerformance(RRL,rf,5,RRL[,70],Tipo~.)

printRes(resPoly,resGaus,resAda,resRf)


