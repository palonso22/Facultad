/*
newton multivariable aproxima una raiz de una función multivariable f
   Entrada:
       - x0: un vector que representa un punto inicial de la aproximacion
       - iter: cantidad de iteraciones que realiza el metodo
*/

function [x1,i]=newton_multivariable(f,x0,iter)
    i=0
    x1=x0
    for i=1:iter
        x0=x1
        x1=x0-inv(numderivative(f,x0))*f(x0)
    end       
endfunction


function y=f(x0)
    y(1)=1+x0(1)^2-x0(2)^2+exp(x0(1))*cos(x0(1))
    y(2)=2*x0(1)*x0(2)+exp(x0(1))*sin(x0(2))
endfunction


x0=[-1;4]
y=newton_multivariable(f,x0,5)
if isnan(y) then
    disp("Diverge")
else
    disp("Res:")
    disp(y(1))
    disp(y(2))
    disp("Evaluando")
    disp(f(y))
end
