
g=9.8
h=4
T=5
w=2*%pi/T

function y =iteracion(f,x0,n)
    y=f(x0)
    for i=1:n
        y=f(y)
    end
endfunction


/*function y=ola(l)
    y=g*2*%pi/w^2*tanh(h*2*%pi/l)
endfunction*/

function y = ej7D(d) // En funcion de d
    g = 9.8
    h = 4
    T = 5
    w = 2*%pi/T
    y = (w^2)/(g*tanh(h*d))
endfunction




format('v',4)
x=iteracion(ej7D,1,10000)
if x==%inf then
    printf("Diverge\n")
else
    disp("Solucion con un digito de precision:")
    disp(x)
end
