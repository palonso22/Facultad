#parametros para feuler
x0=[0;0]
t0=0
tf=10

#h=0.1

#parametros para ltiSolve
k=1
u=1
m=1
b=1
A=[0,1;-k/m,-b*m]
B=[0,1/m]'

h=0.1
#calculo solucion numerica con h=0.1
#[t,x]=feuler(@masaresorte,x0,t0,tf,h)
#calculo solucion analitica

#calculo error en primer paso
#res=norm(x(:,2)-xa(:,2),1)
#calculo el error maximo de simulacion
#max=norm(x-xa,1)


#calculo solucion numerica con h=0.01
[t,x]=feuler(@masaresorte,x0,t0,tf,h)
xa=ltiSolve(A,B,u,x0,t)
#calculo error en primer paso
res=norm(x(:,2)-xa(:,2),1)
#calculo el error maximo de simulacion
max=norm(x-xa,1)
