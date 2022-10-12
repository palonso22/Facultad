library(markovchain)

#Estados
states <- c("Día soleado","Día nublado")


#Matriz de transición
tm <- matrix(c(0.9,0.1,0.2,0.8) , byrow = TRUE, nrow = 2)

#Cadena de Markov
mc <- new("markovchain", states = states, transitionMatrix = tm, name = "Ejercicio 4")

transitionProbability(mc,"A","B")



plot(mc)

