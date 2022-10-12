
library(markovchain)


#Distribucion inicial
pi <- c(2/5,1/5,2/5)

#Estados

states <- c("A","B","C")


#Matriz de trancisión

transition <- matrix( c(0, 1/3, 2/3, 1/4, 3/4, 0, 2/5, 0, 3/5 ), byrow=TRUE , nrow=3)


mc <- new("markovchain", states = states, transitionMatrix = transition, name = "Ejercicios")


#Probabilidad de ir de un estado a otro

transitionProbability(mc, "A","B")
mc[1,2]



#Grafo asociado
plot(mc)



is.irreducible(mc)
period(mc)
transientStates(mc)
steadyStates(mc)
predict(mc, newdata = c("A","B"))

transition1 <- transition
transition2 <- mc ^2
transition3 <- mc ^3


eja <- transitionProbability(mc, "A", "B")

condicionalDistribution()

res <- mc[1,2]*mc[2,2]*mc[2,2]*mc[2,1]*mc[1,3]


res2 <- mc[1,2]*transition2[2,1]*mc[1,3]*transition2[3,2]

res3 <- transition2[1,2]*transition3[2,2]*transition[2,1]*2/5 + transition2[2,2]*transition3[2,2]*transition[2,1]*1/5 + transition2[3,2]*transition3[2,2]*transition[2,1]*2/5


