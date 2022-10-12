/*
 El método de la bisección nos da una aproximación de la raíz de f
  Entrada: 
    - una función f de la cual se quiere aproximar la raiz
    - dos puntos a y b tq a<=b y [a,b] es el intervalo donde se estima que 
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
    y=cos(x)*cosh(x)+1
endfunction



//Test
tol=1e-2
//La raiz está en [0.5,1.5]
printf("f(x)=x^2-1\n")
x=biseccion(f1,0.5,1.5,tol)
printf("Raiz:%e Eval:%e\n",x,abs(f1(x)))



//Primer raiz en [1.5,2]
disp("f(x)=cos(x)*cosh(x)+1\n")
x=biseccion(f2,1.5,2,tol)
printf("Primer Raiz:%e Eval:%e\n",x,abs(f1(x)))
//Segunda raiz en [4.5,5]
x=biseccion(f2,4.5,5,tol)
printf("Segunda Raiz:%e Eval:%e\n",x,abs(f1(x)))
//Tercer raiz en [7.5,8]
x=biseccion(f2,7.5,8,tol)
printf("Tercer Raiz:%e Eval:%e\n",x,abs(f1(x)))








