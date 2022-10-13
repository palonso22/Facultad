#!/usr/bin/Rscript

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
plot(gausianas[,1:2],col=gausianas[,3])



wg=rep(0.0,10)
for(k in 2:10) wg[k]<- sum(kmeans(gausianas[,1:2],k,nsta=10)$withinss)
matplot(2:10,wg[-1],type='b')
#se ve el quiebre para k=4



#Ejemplo: Iris
w=rep(0.0,10)
for(k in 2:10) w[k]<-sum(kmeans(iris[,-5],k,nsta=10)$withinss)
matplot(2:10,w[-1],type='b')
#se ve el quiebre para k=3,
