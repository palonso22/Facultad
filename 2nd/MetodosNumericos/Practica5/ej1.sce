
function x=jacobi(A,b,x0,tol,iter)
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
               suma=A(i,1:i-1)*x0(1:i-1)+A(i,i+1:n)*x0(i+1:n)
           else
               suma=A(i,1:n-1)*x0(1:n-1)               
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



function b=cumpleCorolarioJacobi(A)
    D=repmat(diag(A),1,3).*eye(3,3)
    matrizIteracion=eye(3,3)-inv(D)*A
    ro=max(abs(spec(matrizIteracion)))
    b=ro<1
endfunction


function b=cumpleCorolarioGaussSeidel(A)
    N=tril(A)
    matrizIteracion=eye(3,3)-inv(N)*A
    ro=max(abs(spec(matrizIteracion)))
    b=ro<1
endfunction



tol=1e-6
iter=1000
x0=zeros(3,1)

//Primer sistema
A=[0,2,4;1,-1,-1;1,-1,2]
b=[0,0.375,0]'
//Permuto fila 1 y 3
fila1=A(1,:)
fila3=A(3,:)
A(1,:)=fila3
A(3,:)=fila1
//Permuto columnas 1 y 2
col1=A(:,1)
col2=A(:,2)
A(:,1)=col2
A(:,2)=col1


if cumpleCorolarioJacobi(A) then
    disp("Se cumple el corolario de la estabilidad asíntotica para Jacobi")
else
    disp("No se cumple el corolario de estabilidad")    
end

if cumpleCorolarioGaussSeidel(A) then
    disp("Se cumple el corolario de la estabilidad asíntotica para GaussSeidel")
else
    disp("No se cumple el corolario de estabilidad")    
end



/*
x=jacobi(A,b([3 2 1]),x0,tol,iter)
x=x([2 1 3])
disp("A*x")
disp(A*x([2 1 3]))
disp("b")
disp(b)*/






//Segundo sistema
/*A=[1,-1,0;-1,2,-1;0,-1,1.1]
b=[0,1,0]'
if cumpleCorolarioJacobi(A) then
    disp("Se cumple el corolario de la estabilidad asíntotica")
else
    disp("No se cumple el corolario de estabilidad")    
end

x0=zeros(3,1)
x=gauss_seidel(A,b,x0,tol,iter)
x=x([2 1 3])
disp("A*x")
disp(A*x([2 1 3]))
disp("b")
disp(b)*/




/*tol=1e-2
iter=100
P=[0 1 0;1 0 0;0 0 1]
A=[0 2 4;1 -1 -1;1 -1 2]
A2=[;;0 2 4]
b=[0 0.375 0]'
//A=[1 -1 0;-1 2 -1;0 -1 1.1]
//b=[0 1 0]'
x0=[0 0 0]'<
x=jacobi(P*A,P*b,x0,tol,iter)

//x2=P*x
disp("A*x")
disp(A*x)
disp("b")
disp(b)
disp("x")
disp(x)*/
