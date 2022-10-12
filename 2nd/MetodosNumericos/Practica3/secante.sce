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
        i=i+1        
        x1=x2        
        x2=x1-f(x1)*(x1-x0)/(f(x1)-f(x0))        
        x0=x1
        //Seguir mientras se cumpla la condicion
        seguir=abs(x2-x1)>tol
    end
endfunction




function y=f1(x)
    y=x^2-1
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

function y=f5(x)
    y=x^2/4-sin(x)
endfunction





tol=1e-2
iter=100
//Raices:-1,1
printf("f(x)=x^2-1\n")
x=secante(f1,-1,0,tol,iter)
printf("Raiz:%e Error:%e\n",x,abs(f1(x)))
x=secante(f1,0,1,tol,iter)
printf("Raiz:%e Error:%e\n",x,abs(f1(x)))


//Raices: una entre -1 y 1 y la otra entre 0 y 2
printf("f(x)=sinx-x^2/2\n")
x=secante(f2,-1,1,tol,iter)
printf("Raiz:%e Error:%e\n",x,abs(f2(x)))
x=secante(f2,0,2,tol,iter)
printf("Raiz:%e Error:%e\n",x,abs(f2(x)))



//Raices: una entre -2 y 0,otra entre 0 y 2,otra entre -10 y -5
printf("f(x)=e^(-x)-x^4 \n")
x=secante(f3,-2,0,tol,iter)
printf("Raiz:%e Error:%e\n",x,f3(x))
x=secante(f3,0,2,tol,iter)
printf("Raiz:%e Error:%e\n",x,f3(x))
x=secante(f3,-10,-5,tol,iter)
printf("Raiz:%e Error:%e\n",x,f3(x))




//Raices: una entre 0 y 1/2 y la otra entre 1/2 y 2
printf("f(x)=log(x)-(x-1)\n")
x=secante(f4,0,0.5,tol,iter)
printf("Raiz:%e Error:%e\n",x,abs(f4(x)))
x=secante(f4,0.5,2,tol,iter)
printf("Raiz:%e Error:%e\n",x,abs(f4(x)))


//Raices: una entre -1 y 1 y la otra entre 1.5 y 2
printf("f(x)=x^2/4-sin(x)\n")
x=secante(f5,-1,1,tol,iter)
printf("Raiz:%e Error:%e\n",x,abs(f5(x)))
x=secante(f5,1.5,2,tol,iter)
printf("Raiz:%e Error:%e\n",x,abs(f5(x)))


