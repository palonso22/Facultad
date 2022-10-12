function y= determinante(A)
    // Entrada: Una matriz A cuadrada
    // Salida: Determinante de A
    
    [nA,mA] = size(A) 
    //printf("Dimensiones de A: %d %d\n",nA,nA)
    //printf("Dimensiones de b: %d %d\n",nb,nb)
    
    if nA<>mA then
        error('gausselim - La matriz A debe ser cuadrada');
        abort;
    end    
    
    n = nA;
    for k=1:n-1
        //replico la ecuacion k n-k veces
        mt=repmat(A(k,k+1:n),n-k,1) 
        //replico los multiplicadores n-k+1 veces
        mult=repmat(A(k+1:n,k)/A(k,k),1,n-k)
        //aplico producto miembro a miembro antes de realizar la resta  
        A(k+1:n,k+1:n)= A(k+1:n,k+1:n)-mt.*mult   
    end;
    y=prod(diag(A))
endfunction

n=floor(rand()*10)
M=rand(n,n)*10
x=determinante(M)
x_sci=det(M)
disp("Mi determinante:")
disp(x)
disp("Determinante scilab:")
disp(x_sci)
