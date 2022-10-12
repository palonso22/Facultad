x0=[0;0]
ti=0
tf=50
reltol=1e-3
abstol=1e-6
[t,x]=traprulevs(@masaresorte,x0,ti,tf,reltol,abstol)
length(t)
#plot(t,x)
#title("Fig 50: Masa resorte con b=10")
#plot(diff(t))
#title("Fig 51:Tamaño del paso para masa resorte con b=10")


