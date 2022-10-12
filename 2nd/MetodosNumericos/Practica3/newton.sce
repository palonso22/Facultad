
/*
Entrada:
  - f: funcion de la cual se quiere una raiz
  - x0: aproximacion de la raiz
  - tol : tolerancia de error
  - iter : numero total de iteraciones
Salida:
    - %nan si se llega al maximo de iteraciones
    - una aproximacion a la raiz de f
*/
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


function y=prueba(x)
    y=x^2-1
endfunction

function y=test(f,x0,error,iter)
    printf("Test con parametros\n")
    printf("x0:%e\n",x0)
    printf("error:%e\n",error)
    printf("iter:%e\n",iter)
    [alfa,i] = newton(prueba,5,0.001,100)
    if isnan(res) then
        printf("Error: maximo de iteraciones\n")
    else
        printf("Resultado:%e en %e iteracione\n",res,i)               
    end
    y=0
endfunction


for x=1:10
    //Genero x0,iter y error de forma aleatoria
    x0=grand('uin',-10,10)
    error=0.001
    test(prueba,x0,error,100)    
end







