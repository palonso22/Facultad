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

A=[2,1,1,0;4,3,3,1;8,7,9,5;6,7,9,8]
/*n=floor(rand()*10)
A=rand(n,n)*10*/
[P,L,U]=factorizacion(A)
disp("P*A")
disp(P*A)
disp("L*U")
disp(L*U)
