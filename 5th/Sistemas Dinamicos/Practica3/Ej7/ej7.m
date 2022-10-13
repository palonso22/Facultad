x0=[0;0]
t0=0
tf=100
h=10
[t,x]=beuler(@masaresorte,x0,t0,tf,h)
plot(t,x)
title(strcat("Fig 24: Masa resorte con h=",mat2str(h)," y b=1"))

## Matriz A para el sistema masa resorte 

#k=1
#b=0
#m=1
#F=1
#h=0.5
#A=[0,1;-k/m,-b/m]
#v = eig(A)
#abs(v*h+1)