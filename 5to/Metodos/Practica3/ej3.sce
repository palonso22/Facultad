/*
Secante: método para aproximar la raíz de una función f
   Entrada:
     - función f a la cual se quiere aproximar la raíz
     - x0,x1: puntos por los cuales pasa la recta secante que usamos para aproximar la raíz
     - tol: cuando la distancia entre x2 y x1 es menor a tol el algoritmo termina.
     - iter: maximo numero de iteraciones permitido
   Salida:
     - una aproximación de la raíz de f, x2
     - i: número de iteraciones realizadas, si i==iter se dice que el método no converge
*/


function [x2,i]=secante(f,x0,x1,tol,iter)
    x2=x1
    i=0
    seguir=%T
    while seguir && i < iter
        x1=x2        
        x2=x1-f(x1)*(x1-x0)/(f(x1)-f(x0))        
        x0=x1
        //Seguir mientras se cumpla la condicion
        seguir=abs(x2-x1)>tol
        i=i+1        
    end    
endfunction


function y=f1(x)
    y=x^2-1
endfunction

function y=f2(x)
    y=sin(x)-x^2/2
endfunction

function y=f3(x)
    y=exp(-x)-x^4 
endfunction

function y=f4(x)
    y=log(x)-x+1
endfunction






function y=test(f,x0,x1)
    iter=1000
    [x,i]=secante(f,x0,x1,1e-4,iter)
    if i==iter then
        disp("Diverge")
    else
        disp("Raiz")
        disp(x)
        disp("Evaluacion:")
        disp(f(x))    
    end
    y=0
endfunction


//testing
test(f1,0.5,1.5)
test(f2,0,2)
test(f3,0,2)
test(f4,0,1/2)



function y=ej(x)
    y=x^2-sin(x)
endfunction

test(ej,0.5,3/2)

