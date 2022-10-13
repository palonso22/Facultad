x0=[0;0]
t0=0
tf=100
h=2
[t,x]=heun(@masaresorte,x0,t0,tf,h)
plot(t,x)
title(strcat("Fig 32: Masa resorte con h=",mat2str(h)," y b=10"))
