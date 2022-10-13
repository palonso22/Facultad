rm(list = ls())
setwd("/home/pablo/powerdevs/output")


c1 <- read.csv("cola1.csv")
c2 <- read.csv("cola2.csv")
plot(c1[,1],c1[,2],type="h",col="blue",main="Fig 33:Cola del sistema 1",xlab="Tiempo",ylab="Valor")
plot(c2[,1],c2[,2],type="h",col="red",main="Fig 34:Cola del sistema 2",xlab="Tiempo",ylab="Valor")

plot(g[,1],g[,2],type="h",col="green",main="Fig 10:Entradas generadas",xlab="Tiempo",ylab="Valor")
plot(p0[,1],p0[,2],type="h",col="blue",main="Fig 11:Filtro",xlab="Tiempo",ylab="Valor")
lines(p1[,1],p1[,2],type="h",col="red")
legend(14,0.9,legend=c("Puerto 0", "Puerto 1"),col=c("blue", "red"), lty=c(1,1), cex=0.8)





v <- read.csv("filtro.csv")
lines(v[,1],v[,2],type="h",col="red")
#legend("topleft", legend = c("Group 1", "Group 2"), col = c("red","blue"))
legend("topright", lty=c(1,1),col=c("green", "red"), legend = c("puerto 0", "puerto 1"))

