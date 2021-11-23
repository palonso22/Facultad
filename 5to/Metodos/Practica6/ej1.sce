c=[1,0,0;-0.25,0,0.25;-0.25,-0.25,2]
d=[4,-1,0;-1,4,-1;-1,-1,4]
f=[4.75,2.25,-0.25;2.25,4.75,1.25;-0.25,1.25,4.75]


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

//Chequear 
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


function y=test(A)
    i=0
    M=gerschgorin(A) 
    disp("Centro   Radio")
    disp(M)   
    e=spec(A)
    disp("Autovalores de A")
    disp(e)
    n=length(e)
    seguir=%T
    while seguir && i<n
        i=i+1    
        seguir=checkCota(M,e(i))
    end
    if i==n then
        disp("Se cumple el teorema de gerschgorin")
    else
        disp("No se cumple el teorema de gerschgorin")
    end
    printf("\n\n\n")        
    y=0
endfunction

//test generico
/*n=floor(rand()*10)
disp(n)
A=rand(n,n)
test(A)*/

test(c)
test(d)
test(f)




