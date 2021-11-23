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
    
endfunction



tol=1e-2
iter=100
//A=[0 2 4;1 -1 -1;1 -1 2]
//b=[0 0.375 0]'
A=[1 -1 0;-1 2 -1;0 -1 1.1]
b=[0 1 0]'

x0=[0 0 0]'
x=jacobi(A,b,x0,tol,iter)
disp("A*x")
disp(A*x)
disp("b")
disp(b)
