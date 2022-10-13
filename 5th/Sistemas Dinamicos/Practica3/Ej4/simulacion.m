#x0=1
x0=[0;0]
t0=0
tf=5
h=0.1
#[t,x]=feuler(@solfarmaco,x0,t0,tf,h)
#plot(t,x)
#title ("Fig 5:Absorción del farmaco usando Forward Euler")
[t,x]=feuler(@masaresorte,x0,t0,tf,h)
plot(t,x)
title ("Fig 6:Masa resorte usando Forward Euler")
