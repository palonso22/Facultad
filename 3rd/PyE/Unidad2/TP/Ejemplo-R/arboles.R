#leer la base

#para setear el directorio de trabajo deben pasarle la ruta
setwd("foo")
df = read.csv("arboles.txt", header = TRUE, sep = "\t")

attach(df)

#Toma dos números y expresa el valor x con k decimales. x es devuelto como un string
specify_decimal <- function(x, k) trimws(format(round(x, k), nsmall=k))
specify_decimal(2.333333333,2)

#calcula la moda
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

#clasificación de variables

#especie
var <- especie
fAbs <- table(var)
fAbs
n <- length(var)
#options(digits=2)
fRel <- fAbs/n
fRel
fRelP <- fRel * 100
fRelP
barplot(fRelP,xlab="Especies",ylab="Porcentaje",ylim=c(0,20))
getmode(especie)

#origen

#brotes

#inclinación