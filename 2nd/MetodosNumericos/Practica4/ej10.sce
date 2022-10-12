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



function [L,U]=doolittle(A)
    /*doolittle es un metodo de factorizacio de matrices que requiere poca memoria del ordenador*/
    [na,ma]=size(A)
    if na<>ma then
        disp("Error- Solo se admiten matrices cuadradas")
        abort
    end
    L=eye(na,na)
    U=eye(na,na)
    // Primer fila de U igual a la de A
    U(1,:)=A(1,:)
    // Primer columna de L
    L(:,1)=A(:,1)/U(1,1)
    for i=2:na
        for j=2:ma
            if i<=j then
                U(i,j)=A(i,j)-L(i,1:i-1)*U(1:i-1,j)
            else
                L(i,j)= (A(i,j)-L(i,1:j-1)*U(1:j-1,j))/U(j,j)
            end
        end            
    end
endfunction
//Test generico
n=floor(rand()*10)
M=rand(n,n)*10
[L,U]=doolittle(M)
disp("M")
disp(M)
disp("L*U")
disp(L*U)


/*M=[1 2 3 4;1 4 9 16;1 8 27 64;1 16 81 256]
b=[2 10 44 190]'
[L,U]=doolittle(M)
y=triangular_inferior(L,b)
x=triangular_superior(U,y)

disp("M*x")
disp(M*x')
disp("b")
disp(b)*/





