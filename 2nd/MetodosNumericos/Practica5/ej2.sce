function [x,k]=jacobi(A,b,x0,tol,iter)
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


function [x,k]=gauss_seidel(A,b,x0,tol,iter)
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


function y=test(metodo)
    A=[10 1 2 3 4;1 9 -1 2 -3;2 -1 7 3 -5;3 2 3 12 -1;4 -3 -5 -1 15]
    x0=[0 0 0 0 0]'
    b=[12 -27 14 -17 12]'
    [x,k]=metodo(A,b,x0,1e-6,100)    
    disp("A*x")
    disp(A*x)
    disp("b")
    disp(b)
    disp("x")
    disp(x)
    disp("Iteraciones:")
    disp(k)
    y=0
endfunction


disp("Jacobi")
test(jacobi)
disp("Gauss_seidel")
test(gauss_seidel)



