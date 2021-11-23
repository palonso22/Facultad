
// ej c

function M=gerschgorin(A)
    /*Determina cotas maxima y minima de todos los autovalores de A
     Entrada: matriz cuadrada A
     Salida: matriz n*
       -M una matriz n*2 donde cada fila es un par c,r
       -c centro de un circulo de gersghorin
       -r radio de un circulo de gersghorin
     */
     [n,m]=size(A)
     if n<>m then
         disp("A debe ser una matriz cuadrada")
     end
     //calculo centro y radio para cada circulo de gershgorin de A     
     M=zeros(n,2)
     for i=1:n
         suma=sum(abs([A(i,1:i-1),A(i,i+1:n)]))
         M(i,:)=[A(i,i) suma]         
     end              
endfunction    

function M=acotarRaices(p)
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
    disp(A)
    M=gerschgorin(A)    
endfunction


function y=checkCota(M,v)
    /*Entrada:
       -M una matriz n*2 donde cada fila es un par c,r
       -c centro de un circulo de gersghorin
       -r radio de un circulo de gersghorin
       - v : un numero complejo
      Salida:
        - true si un valor esta dentro de alguna de los circulos expresados en m
        - sino false      
    */
    [n,_]=size(M)
    y=%F
    for i=1:n               
        if norm(v-M(i,1))<= M(i,2) then 
            y=%T
        end        
    end
endfunction


function y=test(p)
    disp("Poly")
    disp(p)
    M=acotarRaices(p)
    disp("Cotas")
    disp(M)
    raices=roots(p)
    for i=1:length(raices)
        disp("Raiz:")
        disp(raices(i))
        if checkCota(M,raices(i)) then
            disp("La raiz esta dentro de las cotas")
        end 
    end 
    y=0
endfunction



// i
p=poly([1 zeros(1,8) 8 1],'x','c')
test(p)

 
// ii
//p=poly([1 -1 1 -1 1 -4 1],'x','c')
//test(p)
