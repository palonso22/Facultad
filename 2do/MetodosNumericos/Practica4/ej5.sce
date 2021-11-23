
function x= gausselimPP(A,b)
// Esta función obtiene la solución del sistema de ecuaciones lineales A*x=b, 
// dada la matriz de coeficientes A y el vector b.
// La función implementa el método de Eliminación Gaussiana con pivoteo parcial.

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
n = nA;    // Tamaño de la matriz

// Eliminación progresiva con pivoteo parcial
for k=1:n-1
    kpivot = k; amax = abs(a(k,k));  //pivoteo
    for i=k+1:n
        if abs(a(i,k))>amax then
            kpivot = i; amax = abs(a(i,k));
        end;
    end;
    //intercambio de filas
    temp = a(kpivot,:); a(kpivot,:) = a(k,:); a(k,:) = temp;
    
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

// Ejemplos de aplicación
function y=test(M,b)
    x = gausselimPP(M,b)
    disp("M*x")
    disp(M*x)
    disp("b")
    disp(b)    
    y=0    
endfunction


/*M=[1,1,0,3;2,1,-1,1;3,-1,-1,2;-1,2,3,-1]
b=[4,1,-3,4]'
test(M,b)*/


/*M=[1,-1,2,-1;2,-2,3,-3;1,1,1,0;1,-1,4,3]
b=[-8,-20,-2,4]'
test(M,b)*/

/*x = umfpack(sparse(M),'\',b);
disp(x)
disp("M*x")
disp(M*x)
disp("b")
disp(b)*/




/*
M=[1,1,0,4;2,1,-1,1;4,-1,-2,2;3,-1,-1,2]
b=[2,1,0,3]'
test(M,b)*/

//x = umfpack(sparse(M),'\',b);

//Test generico
/*n=100
M=rand(n,n)*10
b=rand(1,n)'
test(M,b)*/



// Ejemplo de aplicación
/*M=[1,-1,2,-1;2,-2,3,-3;1,1,1,0;1,-1,4,3]
b=[-8,-20,-2,4]'*/






