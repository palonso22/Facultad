reltol=1e-3
abstol=1e-6
ti=0
tf=50
x0=[0;0]
[t,x]=rk23(@masaresorte,x0,ti,tf,reltol,abstol)
#plot(t,x)
#title("Fig 43: Masa resorte con b=1")
#plot(diff(t))
#title("Fig 44: Tamaño del paso para masa resorte con b=1")
