x0=[2;0]

[t,x] = feuler(@bball,x0,0,10,0.1)
plot(t,x(1,:))