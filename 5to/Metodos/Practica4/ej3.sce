function x = gausselim(A,b)
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
    mt=repmat(a(k,k+1:n+mb),n-k,1) 
    //armo una matriz con los multiplicadores
    mult=repmat(a(k+1:n,k)/a(k,k),1,n-k+mb)
    //aplico producto miembro a miembro antes de realizar la resta  
    a(k+1:n,k+1:n+mb)= a(k+1:n,k+1:n+mb)-mt.*mult   
end;

// Sustitución regresiva
x(n,1:mb) =a(n,n+1:n+mb)/a(n,n);
for j=1:mb
    for i = n-1:-1:1
        sumk=a(i,i+1:n)*x(i+1:n,j)
        x(i,j) = (a(i,n+j)-sumk)/a(i,i);
    end;
end

endfunction


function y=test(M,b)
    x=gausselim(M,b)
    disp("M*x")
    disp(M*x)
    disp("b")
    disp(b)    
endfunction    



//Test generico
/*n=floor(rand()*10)
m=floor(rand()*10)
M=rand(n,n)*10
b=rand(n,m)
disp(n)
disp(m)
test(M,b)*/


//item b
/*M=[1,2,3;3,-2,1;4,2,-1]
b=[14,9,-2;2,-5,2;5,19,12]
test(M,b)*/



//item c
/*Calculo la inversa de M*/
/*n=floor(rand()*10)
disp(n)
M=rand(n,n)*10
b=eye(n,n)
x=gausselim(M,b)
disp("M*x")
disp(M*x)
disp("b")
disp(b)*/

