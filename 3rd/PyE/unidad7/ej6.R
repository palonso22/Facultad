library(markovchain)


#Estados
states <- c("PB","1er piso","2do piso")


#Matriz de trancisión

tm <- matrix( c(0,1/2,1/2,3/4,0,1/4,1,0,0), byrow=TRUE , nrow=3)

#Cadena de markov
mc <- new("markovchain", states = states, transitionMatrix = tm, name = "ej6")


#Graficar
plot(mc)

#Calcular matriz R (())



