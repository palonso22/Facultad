

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

function y=errorMinimosCuadrados(p,vals)
    y=sum((horner(p,vals(:,1))-vals(:,2))^2)        
endfunction



function p=minimosCuadrados(vals,n)
    /*Entrada:
      -p: una matrix m*2 donde cada fila representa un par x,f(x)
      -n: grado del polinomio de aproximacion
      Salida:
      -p: un polinomio de aproximacion de grado n por el metodo de minimos cuadrados
    */
    //matriz con el sistema a resolver
    A=[]
    //abcisas
    xs=vals(:,1)
    //ordenadas
    ys=vals(:,2)
    for i=0:n
        A=[A xs^i]
    end
    Atr=A'
    [a,_]=gausselim(Atr*A,Atr*ys)
    p=poly(a,'x','c')    
endfunction


clf()
function y=test(f,a,b,ctos,g)
    /*Entrada
        -f: funcion para aproximar
        -a: limite inferior del intervalo
        -b: limite superior del intervalo
        -ctos: en cuantos subintervalos de divide [a,b]
        -g:grado del polinomio de aproximacion
    */
    x=a+modulo(rand(1,ctos)*100,b-a) 
    vals=[x' f(x)']
    p=minimosCuadrados(vals,g)
    disp(p)
    X=a:0.001:b
    plot2d(vals(:,1),vals(:,2),-2)
    plot2d(X,f(X),style=[color("red")])
    plot2d(X,horner(p,X),style=[color("blue")])
    y=0
endfunction




//aproximo una exponencial
//test(exp,0,1,10,2)
//aproximo cos
//test(cos,0,1,10,2)
//aproximo sin
//test(sin,-10,10,100,10)
//aproximo tangente
//test(tan,-1,1,20,10)
//aproximo tangente hiperbolica
test(tanh,-10,10,1000,15)
