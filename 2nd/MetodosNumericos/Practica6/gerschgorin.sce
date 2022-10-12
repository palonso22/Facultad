
function M=gerschgorin(A)
    /*Calcula circulos de gerschgorin
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
