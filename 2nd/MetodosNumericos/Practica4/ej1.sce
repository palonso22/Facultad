
/* triangular_superior resuelve Mx=b mediante sustitucion regresiva
   Entrada: 
          -una matriz triangular superior M
          -un vector de coeficientes libres         
   Salida: un vector solucion x*/
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

// triangular_inferior resuelve Mx=b mediante sustitucion progresiva
//Entrada: una matriz triangular inferior M
//Salida: un vector solucion x

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


//Test generico
/*M=triu(rand(3,3)*10)
b=rand(3,1)
x=triangular_superior(M,b)
disp("M*x")
disp(M*x)
disp("b")
disp(b)
*/

/*M=tril(rand(3,3)*10)
b=rand(3,1)
x=triangular_inferior(M,b)
disp("M*x")
disp(M*x)
disp("b")
disp(b)*/





