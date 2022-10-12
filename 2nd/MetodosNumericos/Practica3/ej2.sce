/*
 El método de la bisección nos da una aproximación de la raíz de f
  Entrada: 
    - una función f de la cual se quiere aproximar la raiz
    - dos puntos a y b tq a<b y (a,b) es el intervalo donde se estima que 
    se encuentra la raíz.
    - tol es la distancia entre c y b que se usa como criterio de parada.
  Salida:
    - c es una aproximación de la raíz de f  
*/



function c=biseccion(f,a,b,tol)
    c=a
    while abs(b-c)>tol               
        if f(b)*f(c)<=0 then
            a=c            
        else
            b=c                
        end
        c=(a+b)/2 
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






tol=1e-2

//Raices:-1,1
printf("f(x)=x^2-1\n")
x=biseccion(f1,-1,0,tol)
printf("Raiz:%e tol:%e\n",x,abs(f1(x)))
x=biseccion(f1,0,1,tol)
printf("Raiz:%e tol:%e\n",x,abs(f1(x)))


//Raices: una entre -1 y 1 y la otra entre 0 y 2
printf("f(x)=sinx-x^2/2\n")
x=biseccion(f2,-1,1,tol)
printf("Raiz:%e Eval:%e\n",x,abs(f2(x)))
x=biseccion(f2,0,2,tol)
printf("Raiz:%e Eval:%e\n",x,abs(f2(x)))



//Raices: una entre -2 y 0 y la otra entre 0 y 2
printf("f(x)=e(-x)-x^4 \n")
x=biseccion(f3,-2,0,tol)
printf("Raiz:%e Eval:%e\n",x,f3(x))
x=biseccion(f3,0,2,tol)
printf("Raiz:%e Eval:%e\n",x,f3(x))



//Raices: una entre 0 y 1/2 y la otra entre 1/2 y 2
printf("f(x)=log(x)-(x-1)\n")
x=biseccion(f4,0.0000001,1,tol)
printf("Raiz:%e Eval:%e\n",x,abs(f4(x)))
x=biseccion(f4,3/4,2,tol)
printf("Raiz:%e Eval:%e\n",x,abs(f4(x)))






