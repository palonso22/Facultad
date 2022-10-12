library("markovchain")
m <- matrix(c(0,1,0,0,0,0,
               1,0,0,0,0,0,
               0,0,0,1,0,0,
               0,0,1/2,1/2,0,0,
               1,0,0,0,0,0,
               1/2,1/6,0,0,1/3,0),
      byrow = TRUE, nrow = 6)

states <- c("a","b","c","d","e","f")

mc <- new("markovchain", transitionMatrix = m, states = states, name = "Ej7")
transientStates(mc)
recurrentClasses(mc)
steadyStates(mc)

I <- diag(1,nrow = 6)
R <- solve(I-mt)


v <- c(1/4,1/4,1/6,2/6,0,0)


