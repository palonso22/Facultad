function [x,m] = gausselim(A,b)
// Esta función obtiene la solución del sistema de ecuaciones lineales A*x=b, 
// dada la matriz de coeficientes A y el vector b.
// La función implementa el método de Eliminación Gaussiana sin pivoteo. 
// Se asume que la matriz A es tridiagonal 
// Salida: vector solucion (x) y cantidad de calculos realizados (m)

[nA,mA] = size(A) 
//printf("Dimensiones de A: %d %d\n",nA,nA)
[nb,mb] = size(b)
//printf("Dimensiones de b: %d %d\n",nb,nb)

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
m=0
for k=1:n-1
    //aplico resta solo a la siguiente ecuacion
    mt=a(k,k+1:n+1)*a(k+1,k)/a(k,k)
    m=m+2//producto+division
    a(k+1,k+1:n+1)= a(k+1,k+1:n+1)-mt   
    m=m+1//resta
end;

// Sustitución regresiva
x(n) = a(n,n+1)/a(n,n);
for i = n-1:-1:1
    sumk=a(i,i+1)*x(i+1)
    m=m+1//producto
    x(i) = (a(i,n+1)-sumk)/a(i,i);
    m=m+2//resta+division
end;
endfunction

// Ejemplos de aplicación
function y=test(M,b)
    [x,m] = gausselim(M,b)
    disp("M*x")
    disp(M*x)
    disp("b")
    disp(b)
    disp("Cantidad de operaciones realizadas")
    disp(m)
    y=0    
endfunction





n=floor(rand()*10)
M=rand(n,n)
for k=1:n-2
    M(k,k+2:n)=zeros(1,n-k-1)
    M(k+2:n,k)=zeros(n-k-1,1)
end
disp(M)
b=rand(1,n)'
x=test(M,b)

