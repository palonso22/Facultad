
function [x,m] = gausselim(A,b)
// Esta función obtiene la solución del sistema de ecuaciones lineales A*x=b, 
// dada la matriz de coeficientes A y el vector b.
// La función implementa el método de Eliminación Gaussiana sin pivoteo.  
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
for k=1:n-1
    //replico la ecuacion k n-k veces
    mt=repmat(a(k,k+1:n+1),n-k,1) 
    //replico los multiplicadores n-k+1 veces
    mult=repmat(a(k+1:n,k)/a(k,k),1,n-k+1)
    //aplico producto miembro a miembro antes de realizar la resta  
    a(k+1:n,k+1:n+1)= a(k+1:n,k+1:n+1)-mt.*mult   
end;

// Sustitución regresiva
x(n) = a(n,n+1)/a(n,n);
disp(m)
for i = n-1:-1:1
    sumk=a(i,i+1:n)*x(i+1:n)
    //sumk = a(i,i+1:n)*x(i+1:n)'    
    x(i) = (a(i,n+1)-sumk)/a(i,i);
end;
endfunction

n=4
M=rand(n,n)*10
b=rand(1,n)'
[x,m]=gausselim(M,b)
disp("M*x")
disp(M*x)
disp("b")
disp(b)
