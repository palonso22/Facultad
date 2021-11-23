



function x=gauss_seidel(A,b,x0,tol,iter)
    //A matriz de coeficientes
    // b coeficientes libres del sistema
    //x0 aproximacion inicial de la solucion
    k=0
    x=x0
    [n,m]=size(A)
    error=1
    while k<iter && error>tol
        x0=x
        for i=1:n
           suma=0
           if i == 1 then
               suma=A(i,2:n)*x0(2:n)
           elseif i<n 
               suma=A(i,1:i-1)*x(1:i-1)+A(i,i+1:n)*x0(i+1:n)
           else
               suma=A(i,1:n-1)*x(1:n-1)               
           end
           x(i)=inv(A(i,i))*(b(i)-suma)           
           end
           k=k+1
           error=norm(x0-x)
    end
    if k==iter then
        disp("Diverge")
    end    
endfunction



function [x,a] = gausselimPP(A,b)
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
            kpivot = i; amax = a(i,k);
        end;
    end;
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












N=500
A = 8*eye(N,N) + 2*diag(ones(N-1,1),1) + 2*diag(ones(N-1,1),-1)+ diag(ones(N-3,1),3) + diag(ones(N-3,1),-3)
b = ones(N,1)

tic();gauss_seidel(A,b,zeros(N,1),1e-6,1000);t=toc()
printf("Gauss_seidel tarda %e",t)


tic();gausselimPP(A,b);t=toc()
printf("GausselimPP tarda %e",t)


//Resultado:Gauss_seidel tarda 2.094096e-01GausselimPP tarda 2.246796e+02

