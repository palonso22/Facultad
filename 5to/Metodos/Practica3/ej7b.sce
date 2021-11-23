clear
clc()
/*
g=9.8
h=4
T=5
w=2*%pi/T*/


function [y,i]=newton(f,x0,tol,iter)
    i=0
    x1=x0-f(x0)/numderivative(f,x0)
    while abs(x1-x0)>tol && i <iter
        i=i+1
        x0=x1
        x1=x0-f(x0)/numderivative(f,x0)        
    end
    if i == iter then
        y=%nan
    else        
        y=x1
    end
endfunction


//queremos encontrar la raiz de la siguiente funcion
function y=ola(l)
 g=9.8
 h=4
 T=5
 w=2*%pi/T
 y = g*2*%pi/l*tanh(h*2*%pi/l)-w^2;
endfunction

// punto inicial
x0=27.9
x=newton(ola,x0,1e-1,1000)

if isnan(x) then
    printf("No converge\n")
else
    disp(x)
end

