#!/usr/bin/Rscript
#suppressMessages(library(ggplot))

error.rate <- function(dataA, dataB) sum( dataA != dataB ) / length(dataB)

sign.ranking <- function(x,y,verbosity=0)
{

	num.feat<-max.feat<-dim(x)[2]
	list.feat<-1:max.feat
	keep.feat<-1:num.feat
    min.error<-double(max.feat)
	while(num.feat>1){
		class.error<-double(num.feat)
		for(i in 1:num.feat){
			#at i step create a model with all minus i variable and keep the cv error rate in class.error
			#el modelo es un hiperplano fijo con vector apuntando al 1,1,1...,1
			x.train<-x[,keep.feat[-i],drop=F]
			pred<-factor(sign(apply(x.train,1,sum)))
			class.error[i] <- error.rate(y,pred)
		}
		if(verbosity>1) cat("\n---------\nStep ",num.feat)
		if(verbosity>2) cat("\nFeatures:\n",keep.feat,"\nErrors:\n",class.error)

		#look for minimum error, and eliminate that variable
		best.index<-which.min(class.error)
		list.feat[num.feat]<-keep.feat[best.index]
		if(verbosity>1) cat("\nSelected Feature (",best.index,"):",keep.feat[best.index]," Error ",class.error[best.index])
		min.error[num.feat]<-class.error[best.index]

		keep.feat<-keep.feat[-best.index]
		if(verbosity>2) cat("\nNew search list: ",keep.feat)
		num.feat<-num.feat-1
	}
	#complete the list with the remaining variables
	list.feat[num.feat:1]<-keep.feat

	search.names<-colnames(x)[list.feat]
	imp<-(max.feat:1)/max.feat
	names(imp)<-search.names

	if(verbosity>1){
		cat("\n---------\nFinal ranking ",num.feat," features.")
		cat("\nFeatures: ",search.names,"\n")
	}

 	return( list(ordered.names.list=search.names,ordered.features.list=list.feat,importance=imp,error.rate=min.error) )

}
crea.ruido.unif<-function(n=100,d=2){
x<-runif(2*n*d,min=-1)	#genero los datos
dim(x)<-c(2*n,d)
return(cbind(as.data.frame(x),y=factor(rep(c(-1,1),each=n))))	#le agrego la clase
}

#generar n=10,d=200
d<-200
n<-10
datos<-crea.ruido.unif(n=n,d=d)

dd<-sign.ranking(datos[,-(d+1)],y=factor(datos[,d+1]),verb=2)
plot(dd$error.rate)
