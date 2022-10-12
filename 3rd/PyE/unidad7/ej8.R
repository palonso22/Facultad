library(markovchain)


#Estados
states <- c("A","B","C")


#Matriz de trancisión

tm <- matrix( c(1/2,1/4,1/4,2/3,0,1/3,3/5,2/5,0), byrow=TRUE , nrow=3,dimnames = list(states, states))

#Cadena de markov
mc <- new("markovchain", states = states, transitionMatrix = tm, name = "ej7")


#Graficar
plot(mc)

#¿Es irreducible?
is.irreducible(mc)
#Estados transitorios
transientStates(mc)



#-----------------------------------

#Estados
states <- c("A","B","C","D","E")


#Matriz de transición
tmb <- matrix(c(1/2,0,0,1/2,0,0,0.6,0,0,0.4,0.3,0,0.7,0,0,0,0,1,0,0,0,1,0,0,0),
                byrow = TRUE, nrow = 5,dimnames = list(states, states))
mc <- new("markovchain",states = states,transitionMatrix = tmb,name="ej8")
plot(mc)

#¿Es irreducible?
is.irreducible(mc)
#Período de la cadena
period(mc)
#Estados transitorios
transientStates(mc)
#Distribución estacionaria
steadyStates(mc)
 #Estados absorbentes
absorbingStates(mc)
