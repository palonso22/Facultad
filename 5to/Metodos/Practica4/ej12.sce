function x=triangular_superior(M,b)
    n=size(M,'r')
    x=eye(n,1)
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
    x=eye(n,1)
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




function [U,ind] = cholesky(A)
// Factorización de Cholesky.
// Trabaja únicamente con la parte triangular superior.
//
// ind = 1  si se obtuvo la factorización de Cholesky.
//     = 0  si A no es definida positiva
//
//******************
eps = 1.0e-8
//******************

n = size(A,1)
U = zeros(n,n)

t = A(1,1)
if t <= eps then
    printf('Matriz no definida positiva.\n')
    ind = 0
    return
end
U(1,1) = sqrt(t)
for j = 2:n
    U(1,j) = A(1,j)/U(1,1)
end
    
for k = 2:n
    t = A(k,k) - U(1:k-1,k)'*U(1:k-1,k)
    if t <= eps then
        printf('Matriz no definida positiva.\n')
        ind = 0
        return
    end
    U(k,k) = sqrt(t)
    for j = k+1:n
        U(k,j) = ( A(k,j) - U(1:k-1,k)'*U(1:k-1,j) )/U(k,k)
    end
end
ind = 1

endfunction

A=[16 -12 8;-12 18 -6;8 -6 8]
b=[76,-66,46]'

function y=test(A,b)
    [U,_]=cholesky(A)
    y=triangular_inferior(U',b)
    x=triangular_superior(U,y)
    
    disp("A*x")
    disp(A*x)
    disp("b")
    disp(b)
endfunction

/*n=floor(rand()*10)+3
disp(n)
A=rand(n,n)*10
b=rand(n,1)
