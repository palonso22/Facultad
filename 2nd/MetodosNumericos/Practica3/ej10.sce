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
    y(1)=x0(1)^2+x0(1)*x0(2)^3-9
    y(2)=3*x0(1)^2*x0(2)-4-x0(2)^3
endfunction


function y=test(x0)
    y=newton_multivariable(f,x0,1000)
    if isnan(y) then
        disp("Diverge")
    else
        disp("Res:")
        disp(y(1))
        disp(y(2))
        disp("Evaluando")
        disp(f(y))
    end
endfunction



test([1.2;2.5]) //converge a un punto fijo
//test([-2;2.5])//converge a un punto fijo
//test([-1.2;-2.5])//converge a un punto fijo
//test([2;-2.5])//converge a un punto fijo
/*y=newton_multivariable(prueba,x0,10)
disp("Resultado:")
disp(y(1))
disp(y(2))*/




