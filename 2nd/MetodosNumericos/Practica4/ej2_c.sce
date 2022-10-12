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
m=0;
for k=1:n-1
    for i=k+1:n
        // aplica operaciones a toda la fila
        for j=k+1:n+1
            a(i,j) = a(i,j) - a(k,j)*a(i,k)/a(k,k);
            m=m+1
        end;
        /*for j=1:k        // no hace falta para calcular la solución x
            a(i,j) = 0;  // no hace falta para calcular la solución x
        end              // no hace falta para calcular la solución x*/
    end;
end;

// Sustitución regresiva
x(n) = a(n,n+1)/a(n,n);
disp(m)
for i = n-1:-1:1
    sumk = 0
    for k=i+1:n
        sumk = sumk + a(i,k)*x(k);
        m=m+1
    end;
    x(i) = (a(i,n+1)-sumk)/a(i,i);
     m=m+1
end;
endfunction



// Ejemplos de aplicación

/*M=[1,1,0,3;2,1,-1,1;3,-1,-1,2;-1,2,3,-1]
b=[4,1,-3,4]'
[x,m] = gausselim(M,b)
disp("M*x")
disp(M*x)
disp("b")
disp(b)
disp("Cantidad de operaciones realizadas")
disp(m)*/

//Consultar porque me queda nan
/*M=[1,-1,2,-1;2,-2,3,-3;1,1,1,0;1,-1,4,3]
b=[-8,-20,-2,4]'
[x,_] = gausselim(M,b)
M=[1,-1,2,-1;2,-2,3,-3;1,1,1,0;1,-1,4,3]
b=[-8,-20,-2,4]'
x = umfpack(sparse(M),'\',b);
disp(x)
disp("M*x")
disp(M*x)
disp("b")
disp(b)*/





/*M=[1,1,0,4;2,1,-1,1;4,-1,-2,2;3,-1,-1,2]
b=[2,1,0,3]'
[x,_] = gausselim(M,b)
disp("M*x")
disp(M*x)
disp("b")
disp(b)*/


//x = umfpack(sparse(M),'\',b);

//Test generico
n=100
M=rand(n,n)*10
b=rand(1,n)'
[x,m]=gausselim(M,b)
disp("M*x")
disp(M*x)
disp("b")
disp(b)
disp("Cantidad de operaciones realizadas")
disp(m)
