A=[0,1;-1,-1]
B=[0,1]'
x0=[0,0]'
t=0:0.1:10
u=1
x=ltiSolve(A,B,u,x0,t)
plot(t,x)
title ("Fig 2:Solución analítica para el sistema lti")
