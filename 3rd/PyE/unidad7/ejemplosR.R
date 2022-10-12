library(markovchain)

#Distribución inicial
pi <- c(2/5,1/5,2/5)
#Estados
states <- c("A","B","C")
#Matriz de transición
transition <- matrix(c(0,1/3,2/3,1/4,3/4,0,2/5,0,3/5),byrow=TRUE,nrow=3)
#Creo la cadena de markov. Chequea automáticamente las propiedades necesarias
mc <- new("markovchain",states = states,transitionMatrix = transition,name="Ejercicio5")

#Probabilidad de ir de un estado a otro
transitionProbability(mc,"A","B")
mc[1,2]


#Grafo asociado
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

#Matriz de transición en un paso
transition1 <- mc
#Matriz de transición en dos pasos
transition2 <- mc * mc
#Matriz de transición en tres pasos
transition3 <- mc ^ 3

#Simula una trayectoria de 100 estados partiendo desde C
rmarkovchain(mc,n=100,t0="C")
