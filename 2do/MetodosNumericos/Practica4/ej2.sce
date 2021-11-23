

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
                m=m+3// resta+producto+division
            end;            
        end;
    end;
    
    // Sustitución regresiva
    x(n) = a(n,n+1)/a(n,n);
    m=m+1//division
    for i = n-1:-1:1
        sumk = 0
        for k=i+1:n
            sumk = sumk + a(i,k)*x(k);
            m=m+2//suma + producto
        end;
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





M=[1,1,0,4;2,1,-1,1;4,-1,-2,2;3,-1,-1,2]
b=[2,1,0,3]'
test(M,b)

//x = umfpack(sparse(M),'\',b);

//Test generico
/*n=100
M=rand(n,n)*10
b=rand(1,n)'
test(M,b)*/
