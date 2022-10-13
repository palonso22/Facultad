#!/usr/bin/Rscript

suppressMessages(library(dplyr))
suppressMessages(library(purrr))
suppressMessages(library(groupdata2))




generatorD <- function(n,d,mean,sd,class){
  #gerate point mapping vector of size n
  points <- 1:n %>% map(function(x) c(rnorm(d,mean,sd),class))
  as.data.frame(matrix(unlist(points),n,byrow=TRUE))
}



diagonal <- function(n,d){
  #standar deviation
  #sd <- c*sqrt(d)
	sd <- 2
  # half of examples for each class
  ctos <- n %/% 2
  # generate and join
  rbind(generatorD(ctos,d,-1,sd,0),generatorD(n-ctos,d,1,sd,1))
}







forward.ranking <- function(x,y,method,verbosity=0,... )
{

	max.feat<-dim(x)[2] #dim(x)[2] number of features
	num.feat<-1
	list.feat<-1:max.feat

	#initial ranking
  x.train<-matrix(0,dim(x)[1],1) #dim(x)[1] number of rows
	class.error<-double(max.feat)
	#Evaluation with only 1 feature
	for(i in 1:max.feat){
    print(i)
		x.train[,1]<-x[,i]
		class.error[i] <- do.call(method, c(list(x.train, y), list(...)) )
	}
	list.feat[1]<-which.min(class.error) # less error
	keep.feat<-sort(class.error,decreasing=FALSE,index=T)$ix[-1] # greater error
	x.prev<-x.train[,1]<-x[,list.feat[1]]

	#if(verbosity>1) cat("\nFirst feature: ",list.feat[1],"\n")

	while(num.feat<max.feat){
		class.error<-double(max.feat-num.feat)
		for(i in 1:(max.feat-num.feat)){
			x.train<-cbind(x.prev,x[,keep.feat[i]])
			class.error[i] <- do.call(method, c(list(x.train, y), list(...)) )
		}
		#if(verbosity>2) cat("\nFeatures:\n",keep.feat,"\nErrors:\n",class.error)

		best.index<-which.min(class.error)
		list.feat[num.feat+1]<-keep.feat[best.index]
		#if(verbosity>1) cat("\n---------\nStep ",1+num.feat,"\nFeature ",best.index)

		keep.feat<-keep.feat[-best.index]
		if(verbosity>2) cat("\nNew search list: ",keep.feat)
		num.feat<-num.feat+1
		x.prev<-x[,list.feat[1:num.feat]]
	}


	search.names<-colnames(x)[list.feat]
	imp<-(max.feat:1)/max.feat
	names(imp)<-search.names

	if(verbosity>1){
		cat("\n---------\nFinal ranking ",num.feat," features.")
		cat("\nFeatures: ",search.names,"\n")
	}


 	return( list(ordered.names.list=search.names,ordered.features.list=list.feat,importance=imp) )

}


backward.ranking<- function(x,y,method){


  totalFeatures<-dim(x)[2] # number of features
  keepFeatures <- 1:totalFeatures
  keepData <- x
  orderFeatures <- 1:totalFeatures


  #backward ranking
  if(totalFeatures > 1){
    for(i in totalFeatures:2){
      cat("Iter:",i)
      ctos <- length(keepFeatures)
      classError <- double(ctos)
      for(j in 1:ctos){
        trainData <- data.frame(keepData[,-j]) # discard column of feature j
        classError[j] <- do.call(method, c(list(trainData, y)) ) # train model
      }
      bestIndex <- which.min(classError) # discard feature with lest error in clasiffier when it is discarded
      orderFeatures[i] <- keepFeatures[bestIndex]  # assign order to feature
      keepFeatures <- keepFeatures[-bestIndex] # discard feature
			#cat("Remaining features:",keepFeatures)
      keepData <- keepData[,-bestIndex] # discard column
    }
  }

  orderFeatures[1] <- keepFeatures[1]

  search.names <- colnames(x)[orderFeatures]
	imp<-(totalFeatures:1)/totalFeatures
	names(imp)<-search.names

 	return( list(ordered.names.list=search.names,ordered.features.list=orderFeatures,importance=imp) )
}


nonParametricTest.ranking <- function(x,y){
  test <- apply(data.matrix(x),2,function(col) oneway.test(col~y)$statistic)
	orderFeatures <-  sort(test,decreasing = T,index=T)$ix
	search.names <- colnames(x)[orderFeatures]
	totalFeatures <-  dim(x)[2]
	imp <- (totalFeatures: 1)/ totalFeatures
	return (list(ordered.names.list=search.names,ordered.features.list=orderFeatures,importance=imp))
}











#---------------------------------------------------------------------------
#random forest error estimation (OOB) for greedy search
#---------------------------------------------------------------------------
rf.est <- function(x.train,y,equalize.classes=TRUE,tot.trees=50,mtry=0)
{
	if(mtry<1) mtry<-floor(sqrt(dim(x.train)[2]))
	prop.samples<-table(y)
	if(equalize.classes) prop.samples<-rep(min(prop.samples),length(prop.samples))
  t <- randomForest(x.train,y,mtry=mtry,ntree=tot.trees,sampsize=prop.samples)
	return( t$err.rate[tot.trees] )
}

#---------------------------------------------------------------------------
#LDA error estimation (LOO) for greedy search
#---------------------------------------------------------------------------
lda.est <- function(x.train,y)
{
	m.lda <- lda(x.train,y,CV=TRUE)
	return(error.rate( y , m.lda$class))
}
error.rate <- function(dataA, dataB) sum( dataA != dataB ) / length(dataB)

#---------------------------------------------------------------------------
#SVM error estimation (internal CV) for greedy search
#---------------------------------------------------------------------------
svm.est <- function(x.train,y,type="C-svc",kernel="vanilladot",C=1,cross = 4)
{
	return ( ksvm(as.matrix(x.train), y, type=type,kernel=kernel,C=C,cross = cross)@cross )
}


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



#---------------------------------------------------------------------------
#linear svm ranking method for rfe. Using kernlab. Multiclass
#---------------------------------------------------------------------------
imp.linsvm <- function(x.train,y,C=100)
{
	num.feat<-dim(x.train)[2]
	tot.problems<-nlevels(y)*(nlevels(y)-1)/2

	m.svm <- ksvm(as.matrix(x.train), y, type="C-svc",kernel="vanilladot",C=C)

	w<-rep(0.0,num.feat)

	for(i in 1:tot.problems) for(feat in 1:num.feat)
		w[feat]<-w[feat]+abs(m.svm@coef[[i]] %*% m.svm@xmatrix[[i]][,feat])
	rank.list<-sort(w,decreasing=FALSE,index=T)
	return(list(feats=rank.list$ix,imp=rank.list$x))
}



suppressMessages(library(randomForest))
library(kernlab)
library(MASS)



#hacer una funcion que cree datos, 2 clases (-1 y 1,n puntos de cada una), d dimensiones, de ruido uniforme [-1,1], con la clase al azar

crea.ruido.unif<-function(n=100,d=2){
x<-runif(2*n*d,min=-1)	#genero los datos
dim(x)<-c(2*n,d)
return(cbind(as.data.frame(x),y=factor(rep(c(-1,1),each=n))))	#le agrego la clase
}

#datosA
d<-10
n<-1000
datos<-crea.ruido.unif(n=n,d=d)

#tomar 50% de los datos al azar, y hacer que la clase sea el signo de la 8 variable
shuffle<-sample(1:dim(datos)[1])
sub<-shuffle[1:dim(datos)[1]*0.5]
datos[sub,d+1]<-sign(datos[sub,8])
#tomar 20% de los datos al azar (fuera de los anteriores), y hacer que la clase sea el signo de la 6 variable
sub<-shuffle[(dim(datos)[1]*0.5):(dim(datos)[1]*0.7)]
datos[sub,d+1]<-sign(datos[sub,6])
#tomar 10% de los datos al azar, y hacer que la clase sea el signo de la 4 variable
sub<-shuffle[(dim(datos)[1]*0.7):(dim(datos)[1]*0.8)]
datos[sub,d+1]<-sign(datos[sub,4])
#tomar 5% de los datos al azar, y hacer que la clase sea el signo de la 2 variable
sub<-shuffle[(dim(datos)[1]*0.8):(dim(datos)[1]*0.85)]
datos[sub,d+1]<-sign(datos[sub,2])
datos[,d+1]<-factor(datos[,d+1])



datosA<-datos


#generar n=100,d=8
d<-8
n<-1000
datos<-crea.ruido.unif(n=n,d=d)
#hacer que la clase sea el xor de las 2 primeras variables (es usando el signo)
datos[,d+1]<-sign(datos[,1]*datos[,2])
#hacer que las variables 3 y 4 tengan un 50% de correlacion con la clase
shuffle<-sample(1:dim(datos)[1])
sub<-shuffle[1:dim(datos)[1]*0.5]
datos[sub,3]<-abs(datos[sub,3])*datos[sub,d+1]
shuffle<-sample(1:dim(datos)[1])
sub<-shuffle[1:dim(datos)[1]*0.5]
datos[sub,4]<-abs(datos[sub,4])*datos[sub,d+1]
datos[,d+1]<-factor(datos[,d+1])

datosB<-datos


#Aplicar cada método a un problema
eval <- function(datos,dim){
	print("svm")
	class <- dim+1
	print("Backward method")
	print(backward.ranking(datos[,-class],datos[,class],"rf.est"))
	print("Forward method")
	print(forward.ranking(datos[,-class],datos[,class],"rf.est",2))
	print("RFE method")
	print(rfe(datos[,-class],as.factor(datos[,class]),"imp.rf"))
	print("No Parametric Test")
	print(nonParametricTest(datos[,-class],datos[,class]))


  print("rf")
	print("Backward method")
	print(backward.ranking(datos[,-class],datos[,class],"rf.est"))
	print("Forward method")
	print(forward.ranking(datos[,-class],datos[,class],"rf.est",2))
	print("RFE method")
	print(rfe(datos[,-class],as.factor(datos[,class]),"imp.rf"))
	print("No Parametric Test")
	print(nonParametricTest(datos[,-class],datos[,class]))

}








#Take the list of results and count how many times the first 10 variables appear between the first ten positions
accum <- function(listRest){
  res <- integer(10)
  for (pos in listRest)
         for(v in pos) if (v <= 10)res[v] <- res[v] + 1
  return (res)
}


eval2 <- function(datos,dim){
	class <- dim+1


	#backwardRes <- accum(1:30 %>% map(function(x) backward.ranking(datos[,-class],datos[,class],"svm.est")[["ordered.features.list"]][1:10]))
	forwardRes <- accum(1:30 %>% map(function(x) forward.ranking(datos[,-class],datos[,class],"svm.est")[["ordered.features.list"]][1:10]))
  print(forwardRes)
	#rfeRes <- accum(1:30 %>% map(function(x) rfe.ranking(datos[,-class],as.factor(datos[,class]),"imp.rf")[["ordered.features.list"]][1:10]))
	#nonParametricRes <- accum(1:30 %>% map(function(x) nonParametricTest.ranking(datos[,-class],datos[,class])[["ordered.features.list"]][1:10]))
  #write.table(rbind(backwardRes),"resultados2.txt")


}


### Ej 2

#eval(datosA,10)
#eval(datosB,8)



### Ej 3

# diagonalData <- diagonal(100,10)
# data <- cbind(diagonalData[,-11],crea.ruido.unif(100,90)[,-91],as.factor(diagonalData[,11]))
# eval2(data,100)
#



### Ej 4

library(R.matlab)

rawData <- readMat("DBWORLD-Email/MATLAB/dbworld_bodies.mat")
data <- rawData[["inputs"]]
target <- rawData[["labels"]]


error1 <- double(5)
error2 <- double(5)
for(i in 1:5){
  cat("I",i)
  shuffle <- sample(dim(data)[1])[1:14]

  ## Apply rfe and recover best 1000 words
  write.table(rfe.ranking(data[-shuffle,],as.factor(target[-shuffle,]),"imp.rf")[["ordered.features.list"]][1:2000],"words.txt")
  bestWords <- read.table("words.txt")[,1]
  data <- cbind(data,target)

  ##Construct models
  rf1 <- randomForest(data[-shuffle,],as.factor(target[-shuffle,]),ntree=100)
  pred1 <- predict(rf1,data[shuffle,])
  rf2 <- randomForest(data[-shuffle,bestWords],as.factor(target[-shuffle,]), ntree=100)
  pred2 <- predict(rf2,data[shuffle,bestWords])

  ###Compute error
  cm <- table(target[shuffle],pred1)
  error1[i] <- (cm[2,1] + cm[2,1]) / 14
  cm2 <- table(target[shuffle,],pred2)
  error2[i] <- (cm2[2,1] + cm2[2,1]) / 14

}

print(error1)
print(error2)
mean(error1)
mean(error2)
