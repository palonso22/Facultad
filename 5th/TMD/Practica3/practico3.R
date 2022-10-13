#!/usr/bin/Rscript


library(stats)
library(cluster)
library(MASS)



# compute the relative frequency of times that kmeans find the classes
evalKmeans <- function(data,class){
  iters <- 1:1000
  res <- double(1)
  for(i in iters){
    cm <- table(class,kmeans(data,cent=2)$cluster)
    sum1 <- cm[1,1] + cm[2,2]
    sum2 <- cm[1,2] + cm[2,1]
    if(sum1==0 || sum2==0) res <- res+1
  }
  return (res/length(iters))
}






#compute results for all methods and plot clusters
evalAllMethods <- function(data,class,nameClass){
  print(paste("Evaluando clustering de clase ",nameClass))


  print("Res with 2-means:")
  c <- kmeans(data,center=2)$cluster
  print(table(class,c))
  plot(data,col=c,main="2-means")



  jer <-hclust(dist(data),method="single")
  c <- cutree(jer,k=2)
  print("Res with single linkage:")
  print(table(class,c))
  plot(data,col=c,main="single linkage")


  jer <-hclust(dist(data),method="average")
  print("Res with average linkage:")
  c <- cutree(jer,k=2)
  print(table(class,c))
  plot(data,col=c,main="average linkage")



  jer <-hclust(dist(data),method="complete")
  c <- cutree(jer,k=2)
  print("Res with complete linkage:")
  print(table(class,c))
  plot(data,col=c,main="complete linkage")


}





#
data(crabs)
especie <- crabs[,1]
genero <- crabs[,2]


logData <- log(crabs[,-c(1,2)])

pca <- prcomp(logData)$x

scaled <- scale(pca,center=TRUE,scale=TRUE)
#




#summary(pca)

#plot(scaled,col=especie,main="especie")
#plot(scaled,col=genero,main="genero")









# cat("especie:",evalKmeans(scaled,especie))
# cat("genero",evalKmeans(scaled,genero))






# evalAllMethods(scaled,especie,"especie")
# evalAllMethods(scaled,genero,"genero")



load("lampone.Rdata")

year <- lampone[,1]
especie <- lampone[,143]
data <- lampone[,-c(1,143,144)]



# scaled <- scale(data,center=TRUE,scale=TRUE)
# pca <- prcomp(scaled)
#error
#evalAllMethods(pca)

#error
#evalAllMethods(scaled)


#make pca
#pca <- prcomp(data)
#plot(pca$x[,1:5],col=year)

#plot(pca)
#check the number of pcs that explain 99% of the variance
#summary(pca)


# we need only 5 pcs
# print("Without scaled")
#evalAllMethods(pca$x[,1:5])

#scaled data
#scaled <- scale(pca$x[,1:5],center=TRUE,scale=TRUE)



# print("With scaled")
#evalAllMethods(scaled)


#scaled <- scale(data,center=TRUE,scale=TRUE)
#print(scaled)

#evalAllMethods(scaled)


#Ej 2 y 3



#cuatro clusters de dist. gaussianas
tot.puntos<-100
gap=2
x<-rnorm(tot.puntos,mean=-gap)
y<-rnorm(tot.puntos,mean=-gap)
gausianas<-cbind(x,y,rep(1,length(x)))
x<-rnorm(tot.puntos,mean=2*gap)
y<-rnorm(tot.puntos,mean=0)
gausianas<-rbind(gausianas,cbind(x,y,rep(2,length(x))))
x<-rnorm(tot.puntos,mean=0.7*gap,sd=0.5)
y<-rnorm(tot.puntos,mean=2.5*gap,sd=0.5)
gausianas<-rbind(gausianas,cbind(x,y,rep(3,length(x))))
x<-rnorm(tot.puntos,mean=-gap,sd=0.5)
y<-rnorm(tot.puntos,mean=gap,sd=0.5)
gausianas<-rbind(gausianas,cbind(x,y,rep(4,length(x))))







clusterWithin <- function(data,k){
  return(sapply(1:k,function(i) kmeans(data,i,nsta=10)$tot.withinss))
}

generateUnifDataset <- function(data){
  ctos <- dim(data)[1]
  dims <- dim(data)[2]
  #take a column and return a uniformly distributed vector
  unifCol <- function(col){
    return(runif(ctos,min(col),max(col)))
  }
  return(sapply(1:dims,function(i) unifCol(data[,i])))
}

gapStatistic <- function(data,k,b){

  #obtain k withinss dispersion measures for k several clusterings
  wn <- clusterWithin(data,k)

  #create reference datasets  and compute withinss measure
  evalReference <- function(pca){
    unifDataset <- generateUnifDataset(pca)
    return(clusterWithin(unifDataset,k))
  }

  #use pca for create reference datasets
  pca <- prcomp(data,retx=TRUE)$x
  #create a k*b matrix with k withinss measures of b uniforms datasets
  wnb <- sapply(1:b,function(i) evalReference(pca))
  # compute k gaps
  gaps <- sapply(1:k,function(i) (1/b)*sum(log(wnb[i,])) - log(wn[i]))
  ls <- sapply(1:k,function(i)  (1/b)*sum(log(wnb[i,])))
  sd <- sapply(1:k, function(i) sqrt((1/b) *sum  ((log(wnb[i,])-ls[i])^2 )))
  sk <- sapply(1:k,function(i) sd[i]*sqrt(1+1/b))

  #obtain the smallest k such that  meets the condition
  for(i in 1:k)  if(gaps[i] >= gaps[i+1] - sk[i+1]) return(i);
  return(0)
}







evalGapStatistic <- function(data,pca,problem){
  res <- 1:100
  for (i in 1:100) res[i] <- gapStatistic(data,10,6)
  uniq <- unique(res)

  for (i in uniq){
    c <- kmeans(pca,center=i)$cluster
    png(paste(problem,"K",i,".png",sep=""))
    plot(pca,col=c,main=paste("Una solución con ",i," clusters"))
  }
  invisible(dev.off())
}





#lampone
# data <- lampone[,-c(1,143,144)]
# pca <- prcomp(data)$x
# evalGapStatistic(data,pca,"lampone")


#iris
# pca <- prcomp(iris[,-5])$x
# evalGapStatistic(iris[,-5],pca,"iris")



#gausianas
#pca <- prcomp(gausianas[,-3])$x
#evalGapStatistic(gausianas[,-3],pca,"gausianas")




#Compare two clusters of size k and compute score of similarity
#evalScore(c(1,2,3,4),c(2,1,3,4)) devuelve 0.66 y debería devolver 1
#se suma 1 para corregir eso
evalScore <- function(cluster1,cluster2){
  cluster1 <- cluster1 + 1
  cluster2 <- cluster2 + 1
  #creo una matriz m con 1 donde los dos puntos estan en el mismo cluster, -1 en distinto cluster y 0 si alguno no esta, para cada
  a<-sqrt(cluster1%*%t(cluster1))
  m1<-a / -a + 2*(a==round(a))
  m1[is.nan(m1)]<-0
  a<-sqrt(cluster2%*%t(cluster2))
  m2<-a / -a + 2*(a==round(a))
  m2[is.nan(m2)]<-0
  #calculo el score, los pares de puntos que estan en la misma situacion en los dos clustering dividido el total de pares validos.
  validos<-sum(cluster1*cluster2>0)
  score<-sum((m1*m2)[upper.tri(m1)]>0)/(validos*(validos-1)/2)
  return(score)
}


firstQuartile<- function(dist){
  return(as.numeric(quantile(dist,0.75)))
}



# add uniforn noise to the data
addNoise <-function(data,i){
  # in the first place leave original data
  if(i == 1) return(data)
  dims <- dim(data)[2]
  #noise <- sapply(1:dims,function(i){col <- data[,i];col + rnorm(length(col), sd = 0.015 * sd(col))})
  noise <- sapply(1:dims,function(i) jitter(data[,i]))
  return(noise)
}

sampleDataset <- function(data,b){
  ctos <- dim(data)[1]
  #take 90% of data
  return(lapply(1:b,function(i) sample(ctos,0.9*ctos)))
}

noiseDataset <- function(data,b){
  return(lapply(1:b,function(i) addNoise(data,i)))
}

solutionWithSamples <- function(ind,data,k){
  sol <-rep(0,dim(data)[1])
  sol[ind] <- kmeans(data[ind,],k,nsta=10)$cluster
  return(sol)
}


solutionWithNoise<- function(noise,data,k){
  return(kmeans(noise,k,nsta=10)$cluster)

}


estabilidad <- function(data,b,k,referenceDatasets,makeSolucion,problem){

  #first generate b-1 references datasets  with sampling or adding noise
  datasets <- referenceDatasets(data,b)


  # return a vector of size b with similarities of clusters of size k
  eval <- function(k){
    # generate b solutions for k clustering
    clusters <- lapply(datasets,function(m) makeSolucion(m,data,k))
    #compare cluster j with the rest of clusters
    compare <- function(j){
      # the scores range from 0 to 1 where 1 represent similarity and 0 disimilarity
      scores <- sapply((1:b)[-(1:j)],function(i) evalScore(clusters[[j]],clusters[[i]]))
      return(scores)
    }
    # compute a distribution of similarities scores between the b clusters
    dist <- unlist(sapply(1:b,compare))
    return(dist)
  }

  breaks <- seq(0.5, 1, by=0.001)
  cut <- cut(eval(2), breaks, right=TRUE)
  freq <- table(cut)
  cumfreq0 <- c(0,cumsum(freq))
  plot(breaks, cumfreq0,main=problem, xlab="Score",  ylab="Frecuencia acumulada",type="l",col=2)   # y−axis label
  for(i in 3:k){
    cut <- cut(eval(i), breaks, right=TRUE)
    freq <- table(cut)
    cumfreq0 <- c(0,cumsum(freq))
    lines(breaks, cumfreq0,type="l",col=i)
  }
  ks <- sapply(2:k,function(i) paste('k =',i))
  legend("topleft", legend = ks, col = 2:k,pch=1)
}





evalEstabilidad <- function(data,problem){
  png(paste(problem,".png",sep=""))
  par(mfrow=c(1,2))
  estabilidad(data,10,10,sampleDataset,solutionWithSamples,paste(problem,"con sampleo"))
  estabilidad(data,10,10,noiseDataset,solutionWithNoise,paste(problem,"con ruido"))
  invisible(dev.off())
}





# evalEstabilidad(lampone[,-c(1,143,144)],"lampone")
# evalEstabilidad(iris[,-5],"iris")
# evalEstabilidad(gausianas[,-3],"gausianas")





#Ej 4

wines <- read.csv("wine/wine.data")
cultivars <- wines[,1]
data <- log(wines[,-1])
scaled <- scale(data,center=TRUE,scale=TRUE)
pca <- prcomp(scaled)$x

png("wine.png")
par(mfrow=c(1,2))
plot(pca,col=cultivars,main="Datos clasificados")
cluster <- kmeans(pca,center=3)$cluster
plot(pca,col=cluster + 2,main="Datos clusterizados")
invisible(dev.off())
library(e1071)
# Find optimal match between the two classifications
table <- table(cultivars,cluster)
class.match <- matchClasses(as.matrix(table),method="exact")
#table[,class.match]


evalEstabilidad(pca,"wines")
# res <- 0
# for(i in 1:100)if(gapStatistic(pca,10,6) == 3) res <-  res +1;
# print(res/100)
