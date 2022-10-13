x0=[0;0]
t0=0
tf=50
h=0.1
[t,x]=traprule(@masaresorte,x0,t0,tf,h)
plot(t,x)
title(strcat("Fig 41: Masa resorte con h=",mat2str(h)," y b=10"))