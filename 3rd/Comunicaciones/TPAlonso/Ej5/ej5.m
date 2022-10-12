x0=[0;0]
t0=0
tf=10
h1=0.1
h2=0.01
[t,x]=feuler(@masaresorte,x0,t0,tf,h2)
plot(t,x)
title ("Fig 8:Masa resorte con h=0.01")
