// Ejercicio 4 de la práctica 7
clc()
clear()




function y=diferenciasDivididas(p)
    /*Calcula las diferencias divididas para un arreglo
    Entrada:
       - p  una arreglo de valores
    Salida:
       -y: resultado de las diferencias divididas
    */
    [n,m]=size(p)
    if n==1 then        
        y=p(1,2)
    else
        y1=diferenciasDivididas(p(2:n,:)) 
        y2=diferenciasDivididas(p(1:n-1,:))
        y=(y1-y2)/(p(n,1)-p(1,1))
    end    
endfunction    

function y=interpolacionNewton(p)
    /* Realiza una interpolacion de Newton de grado n usando los puntos de la matriz p
      Entrada:
         - x valor donde se quiere evaluar el polinomio
         - p: una matriz que representa n puntos donde cada fila representa un valor sobre la recta x e y su evaluación
       Salida :
         - y:Polinomio de interpolacion de newton
    */
    [n,m]=size(p)
    if m<>2 then
        disp("p no representa una lista de puntos en el plano")
        abort
    end
    y=0
    // se usa la forma de las multiplicaciones encajadas
    for k=n:-1:1        
        div=diferenciasDivididas(p(1:k,:))
        dif=poly(p(k,1),'x','r')
        y=y*dif
        y=y+div
    end    
endfunction


function y = err(x,vals,cota)
    /* Entrada:
           - x : x evaluado
           - val : nodos de interpolación
           - cota : cota de |f^n|
        Salida:
           - y: cota del error de interpolacion*/
    n = length(vals)
    y = prod(abs(x-vals))*cota/(factorial(n))        
endfunction


function y=bessel(x)
    deff("y=f(t)",y="y=cos(x*sin(t))")
    y=1/%pi*integrate("f(t)",'t',0,%pi)
endfunction        

vals=[2 0.2239;2.1 0.1666;2.2 0.1104;2.3 0.0555; 2.4 0.0025;2.5 -0.0484]
x1=2.15
x2=2.35
tol=1/2*1e-6

p=interpolacionNewton(vals)
printf("J0(%e),tol=%e\n",x1,tol)
disp(horner(p,x1))
printf("Error cometido:%e\n",err(x1,vals(:,1),1))



printf("J0(%e),tol=%e\n",x2,tol)
disp(horner(p,x2))
printf("Error cometido:%e\n",err(x2,vals(:,1),1))
