function [a,b]=gerschgorin(A)
    /*Determina cotas maxima y minima de todos los autovalores de A
     Entrada: matriz cuadrada A
     Salida: 
       -r radio del circulo*/
     [n,m]=size(A)
     if n<>m then
         disp("A debe ser una matriz cuadrada")
     end
     //calculo cotas para cada circulo de gershgorin de A
     a=0
     b=0
     for i=1:n
         suma=sum(abs([A(i,1:i-1),A(i,i+1:n)]))
         ai=A(i,i)-suma
         bi=A(i,i)+suma
         if ai<a  then
            a=ai              
         end
         
         if bi>b then
             b=bi
         end         
     end       
endfunction   

function [a,b]=acotarRaices(p)
    /*
    Acotar raices de un polinomio mediante circulos de gorschgorin
    Entrada:
       - p: polinomio de grado n
       - c: cota máxima y minima para las raices de p
    */
    coefs=coeff(p)
    n=length(coefs)
    A=zeros(n-1,n-1)
    for i=1:n-2
        A(i,i+1)=1        
    end
    A(n-1,:)=-coefs(1:n-1)
    [a,b]=gerschgorin(A)    
endfunction




function A=matrix(k)
    eps=0.1*k
    A=[1,-1,0;-2,4,-2;0,-1,1+eps]
endfunction

for k=0:10
    A=matrix(k)
    p=poly(A,'x')
    disp(p)
    eigens=roots(p)
    [a,b]=acotarRaices(p)
    printf("Las cotas son %f y %f\n",a,b)
    disp("Los autovalores son:")
    disp(eigens')
end
