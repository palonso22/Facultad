

function [x,a] = gausselim(A,b)
// Esta función obtiene la solución del sistema de ecuaciones lineales A*x=b, 
// dada la matriz de coeficientes A y el vector b.
// La función implementa el método de Eliminación Gaussiana sin pivoteo.  

[nA,mA] = size(A) 
[nb,mb] = size(b)

if nA<>mA then
    error('gausselim - La matriz A debe ser cuadrada');
    abort;
elseif mA<>nb then
    error('gausselim - dimensiones incompatibles entre A y b');
    abort;
end;

a = [A b]; // Matriz aumentada

// Eliminación progresiva
n = nA;
for k=1:n-1
    for i=k+1:n
        for j=k+1:n+1
            a(i,j) = a(i,j) - a(k,j)*a(i,k)/a(k,k);
        end;
        for j=1:k        // no hace falta para calcular la solución x
            a(i,j) = 0;  // no hace falta para calcular la solución x
        end              // no hace falta para calcular la solución x
    end;
end;

// Sustitución regresiva
x(n) = a(n,n+1)/a(n,n);
for i = n-1:-1:1
    sumk = 0
    for k=i+1:n
        sumk = sumk + a(i,k)*x(k);
    end;
    x(i) = (a(i,n+1)-sumk)/a(i,i);
end;
endfunction



function p=minimosCuadrados(p,n)
    /*Entrada:
      -p: una matrix m*2 donde cada fila representa un par x,f(x)
      -n: grado del polinomio de aproximacion
      Salida:
      -p: un polinomio de aproximacion de grado n por el metodo de minimos cuadrados
    */
    //matriz con el sistema a resolver
    A=[]
    //abcisas
    xs=p(:,1)
    //ordenadas
    ys=p(:,2)
    for i=0:n
        A=[A xs^i]
    end
    Atr=A'
    [a,_]=gausselim(Atr*A,Atr*ys)
    p=poly(a,'x','c')    
endfunction





function y=test(n,vals)
    disp("Polinomio:")
    p=minimosCuadrados(vals,n)
    disp(p)
    disp("Error:")
    disp(errorMinimosCuadrados(p,vals))    
    y=0
endfunction


function y=test2(n,vals,c)
    disp("Polinomio:")
    p=minimosCuadrados(vals,n)
    disp(p)
    disp("Error:")
    disp(errorMinimosCuadrados(p,vals))    
    X=0:0.1:10
    plot2d(X,horner(p,X),style=[color(c)])
    y=0
endfunction


vals=[4 102.56; 4.2 113.18; 4.5 130.11; 4.7 142.05; 5.1 167.53; 5.5 195.14; 5.9 224.87; 6.3 256.73; 6.8 299.5; 7.1 326.72]
//test(1,vals)
//test(2,vals)
//test(3,vals)


//ejb 
clf()
plot2d(vals(:,1),vals(:,2),-1)
test2(1,vals,"red")
test2(2,vals,"brown")
test2(3,vals,"blue")
