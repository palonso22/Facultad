function [P,L,U]=factorizacion(A)
    /*Encuentra la factorizacion PLU de M*/
    /*Entrada: una matriz A cuadrada
      Salida: una matriz de permutacion P, una matriz triangular inferior, una matriz triangular superior
      tales que PA=LU
    */
    
    [n,m]=size(A)
    if n <> m then
        disp("M debe ser una matriz cuadrada")
        abort
    end
    P=eye(n,n)
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
        //intercambio de filas P
        temp = P(kpivot,:); P(kpivot,:) = P(k,:); P(k,:) = temp;  
        
        for j=k+1:m
            L(j,k)=U(j,k)/U(k,k)
            U(j,k:m)=U(j,k:m)-L(j,k)*U(k,k:m)
        end                                                      
    end
       
endfunction


A=[1.012 -2.132 3.104;-2.132 4.096 -7.013;3.104 -7.013 0.014]
B=[2.1756 4.0231 -2.1732 5.1967;-4.0231 6.0000 0 1.1973;-1.0000 5.2107 1.1111 0;6.0235 7.0000 0 4.1561]
function y=test(A)
    [P,L,U]=factorizacion(A)
    disp("Mi metodo:")
    disp("P*A")
    disp(P*A)
    disp("L*U")
    disp(L*U)
    [L,U,P]=lu(A)
    disp("Metodo de scilab:")
    disp("P*A")
    disp(P*A)
    disp("L*U")
    disp(L*U)
    y=0
endfunction

test(A)
test(B)


