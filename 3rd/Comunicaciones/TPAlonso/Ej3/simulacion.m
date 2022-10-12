#no va este
A=[0,1;-k/m,-b*m]
B=[0,1/m]'
x0=[0,0]'
t=0:0.1:10
u=1
x=ltiSolve(A,B,u,x0,t)
plot(t,x)
title ("Fig 4:Solución con b=10")
