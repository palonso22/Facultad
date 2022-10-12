library(markovchain)


#Estados
states <- c("A","B","C")


#Matriz de trancisión

tm <- matrix( c(0.1,0.3,0.6,0.2,0.2,0.6,0.2,0.4,0.4), byrow=TRUE , nrow=3)

#Cadena de markov
mc <- new("markovchain", states = states, transitionMatrix = tm, name = "ej7")


#Graficar
plot(mc)

#Matriz de transición en 4 pasos
tm4 <- tm^4
R <- solve(Id-tm)



