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






evalAllMethods(scaled,especie,"especie")
evalAllMethods(scaled,genero,"genero")



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
