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
     printf("Las cotas de los autovalores son:%d,%d\n",a,b)
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
    disp(A)
    for i=1:n-2
        A(i,i+1)=1        
    end
    A(n-1,:)=-coefs(1:n-1)
    disp(A)
    [a,b]=gerschgorin(A)    
endfunction

function y=test(p)
    [a,b]=acotarRaices(p)
    disp("Las raices de:")
    disp(p)
    disp("Estan entre:")
    printf("%e y %e",a,b)
    y=0
endfunction

// i
//p=poly([1 zeros(1,8) 8 1],'x','c')
//test(p)

 
// ii
p=poly([1 -1 1 -1 1 -4 1],'x','c')
test(p)
