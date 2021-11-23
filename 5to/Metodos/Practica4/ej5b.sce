function y=defError(x1,x2)
    // Entrada: 2 vectores
    // Salida: devuelve true cuando el error en todas la componentes de los 2 vectores
    // es menor a eps
    eps=1e-8
    n=length(x1)
    i=0
    while i<n &&abs(x1(i+1)-x2(i+1))<eps
        i=i+1
    end
    y=i==n
endfunction






function iter=gauss_seidel(A,b,x0)
    //A matriz de coeficientes
    // b coeficientes libres del sistema
    //x0 aproximacion inicial de la solucion
    k=0
    x=x0
    [n,m]=size(A)
    iter=0
    while ~defError(sol,x)
        iter=iter+1
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
endfunction




function iter=SOR(A,b,x0)
    //A matriz de coeficientes
    // b coeficientes libres del sistema
    //x0 aproximacion inicial de la solucion
    //tol cota mayor del error buscado
    //iter: maxima cantidad de iteraciones
    k=0
    x=x0
    [n,m]=size(A)
    //matriz diagonal de A
    D=eye(n,n).*repmat(diag(A),1,n)
    //calculo matriz de iteracion
    T=eye(n,n)-inv(D)*A
    //calculo radio espectral
    ro=max(spec(T))
    //calculo factor de escala
    w=2/(1+sqrt(1-ro^2))
    
    //solucion del sistema
    sol=[3 4 -5]    
    iter=0
    while ~defError(sol,x)
        iter=iter+1
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
           x(i)=(1-w)*x(i)+w/A(i,i)*(b(i)-suma)           
           end
           k=k+1
           error=norm(x0-x)
    end    
endfunction


tol=1e-2
iter=100
A=[4 3 0;3 4 -1;0 -1 4]
b=[24 30 -24]'
x0=[0 0 0]'
i1=SOR(A,b,x0)
i2=gauss_seidel(A,b,x0)

printf("SOR tardo %d iteraciones\n",i1)
printf("gauss_seidel tardo %d iteraciones\n",i2)
