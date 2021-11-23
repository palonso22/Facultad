function x=triangular_superior(M,b)
    n=size(M,'r')
    x=eye(1,n)
    for i=1:n     
        k=n-i+1
        suma=0
        //calcular suma del producto entre coefs y 
        for j=k+1:n
            suma=suma+M(k,j)*x(j)
        end
        x(k)=inv(M(k,k))*(b(k)-suma)
    end           
endfunction


function x=triangular_inferior(M,b)
    n=size(M,'r')
    x=eye(1,n)
    for i=1:n     
        k=i
        suma=0
        //calcular suma del producto entre coefs y 
        for j=1:k-1
            suma=suma+M(k,j)*x(j)
        end
        x(k)=inv(M(k,k))*(b(k)-suma)
    end           
endfunction




function [x,P]= gausselimPP(A,b)
// Esta función obtiene la solución del sistema de ecuaciones lineales A*x=b, 
// dada la matriz de coeficientes A y el vector b.
// La función implementa el método de Eliminación Gaussiana con pivoteo parcial.
//Salida: vector solucion y matriz de permutacion

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
P=eye(n,n)
// Eliminación progresiva con pivoteo parcial
for k=1:n-1
    kpivot = k; amax = abs(a(k,k));  //pivoteo
    for i=k+1:n
        if abs(a(i,k))>amax then
            kpivot = i; amax = abs(a(i,k));
        end;
    end;
    //intercambio de filas a
    temp = a(kpivot,:); a(kpivot,:) = a(k,:); a(k,:) = temp;
    //intercambio de filas P
    temp = P(kpivot,:); P(kpivot,:) = P(k,:); P(k,:) = temp;  

    
    for i=k+1:n
        for j=k+1:n+1
            a(i,j) = a(i,j) - a(k,j)*a(i,k)/a(k,k);
        end;
        for j=1:k        // no hace falta para calcular la solución x
            a(i,j) = 0;  // no hace falta para calcular la solución x
        end              // no hace falta para calcular la solución x
    end;
end;
endfunction







function [L,U]=factorizacionLU(A)
    /*Encuentra la factorizacion LU de M*/
    
    [n,m]=size(A)
    if n <> m then
        disp("M debe ser una matriz cuadrada")
        abort
    end
    L=eye(n,n)
    U=A    
    for k=1:n-1
        kpivot = k; amax = abs(U(k,k));  //pivoteo
        for i=k+1:n
            if abs(U(i,k))>amax then
                kpivot = i; amax = abs(U(i,k));
            end;
        end;
        //intercambio de filas U
        temp = U(kpivot,k:n); U(kpivot,k:n) = U(k,k:n); U(k,k:n) = temp;
        
        //intercambio de filas L
        temp = L(kpivot,1:k-1); L(kpivot,1:k-1) = L(k,1:k-1); L(k,1:k-1) = temp;       
        
        for j=k+1:m
            L(j,k)=U(j,k)/U(k,k)
            U(j,k:m)=U(j,k:m)-L(j,k)*U(k,k:m)
        end                                                      
    end
       
endfunction

/*A=[1,2,-2,1;4,5,-7,6;5,-25,-15,-3;6,-12,-6,22]
b=[1,2,0,1]'
b2=[2,2,1,0]'
*/
//Test generico
n=floor(rand()*10)
A=rand(n,n)
b=rand(n,1)
b2=rand(n,1)
[x,P]=gausselimPP(A,b)
[L,U]=factorizacionLU(P*A)


y=triangular_inferior(L,P*b2)
x2=triangular_superior(U,y)    

disp("A*x")
disp(A*x2')
disp("b2")
disp(b2)


