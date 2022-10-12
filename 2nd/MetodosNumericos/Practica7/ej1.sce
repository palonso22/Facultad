function p=Lk(vals,k)
        coefs=[vals(1:k-1) vals(k+1:length(vals))]
        v1=poly(coefs,'x','r')        
        v2=horner(v1,vals(k))
        p=v1/v2
endfunction    



function y=interpolacionLagrange(vals)
    /* Realiza una interpolacion de Lagrange de grado n usando los puntos de la matriz p
      Entrada:
         - x valor donde se quiere evaluar el polinomio
         - p: una matriz que representa n puntos donde cada fila representa un valor sobre la recta x e y su evaluación
         - g: grado de la interpolacion
       Salida :
         - y:Polinomio de interpolacion de lagrange
    */
    [n,m]=size(vals)
    if m<>2 then
        disp("p no representa una lista de puntos en el plano")
        abort
    end  
    y=0
    for k=1:n
      y=y+Lk(vals(:,1)',k)*vals(k,2)
    end    
endfunction



function y=diferenciasDivididas(p)
    /*Calcula las diferencias divididas para un arreglo
    Entrada:
       - p  una arreglo de valores
    Salida:
       -y: resultado de las diferencias divididas
    */
    [n,m]=size(p)
    if n==1 then        
        y=p(1,2)
    else
        y1=diferenciasDivididas(p(2:n,:)) 
        y2=diferenciasDivididas(p(1:n-1,:))
        y=(y1-y2)/(p(n,1)-p(1,1))
    end    
endfunction    

function y=interpolacionNewton(p)
    /* Realiza una interpolacion de Newton de grado n usando los puntos de la matriz p
      Entrada:
         - x valor donde se quiere evaluar el polinomio
         - p: una matriz que representa n puntos donde cada fila representa un valor sobre la recta x e y su evaluación
       Salida :
         - y:Polinomio de interpolacion de newton
    */
    [n,m]=size(p)
    if m<>2 then
        disp("p no representa una lista de puntos en el plano")
        abort
    end
    y=0
    // se usa la forma de las multiplicaciones encajadas
    index=gsort(1:n,'g','d')
    for k=index        
        div=diferenciasDivididas(p(1:k,:))
        dif=poly(p(k,1),'x','r')
        y=y*dif
        y=y+div
    end    
endfunction


function y=test(x,vals,valorReal)
    [n,_]=size(vals)
    printf("Interpolacion de grado %d\n",n-1)
    p=interpolacionLagrange(vals)
    v=horner(p,x)
    disp("Interpolacion de Lagrange:")
    disp(v)
    printf("Error absoluto:%f\n",abs(v-valorReal))    
    p=interpolacionNewton(vals)
    v=horner(p,x)
    disp("Interpolacion de Newton:")
    disp(v)
    printf("Error absoluto:%f\n",abs(v-valorReal))    
    y=0
endfunction



function y = err(x,vals,cota)
    /* Entrada:
           - x : x evaluado
           - val : nodos de interpolación
           - cota : cota de |f^n|
        Salida:
           - y: cota del error de interpolacion*/
    n = length(vals)
    y = prod(abs(x-vals))*cota/(factorial(n))        
endfunction



//Test
vals=[0 exp(0);0.2 exp(0.2); 0.4 exp(0.4); 0.6 exp(0.6)]
x=1/3

//a
//Interpolacion lineal
test(x,vals(2:3,:), 1.395612425)

//Interpolacion cubica
test(x,vals, exp(x))

//b
// Se tiene que f^(2)= exp, dado que exp es creciente, exp(x)<= exp(0.6), x en [0,0.6]
cota=exp(0.6)
//Error lineal
disp("Cota del error lineal")
disp(err(vals(2:3,1),x,cota))
//Error cubico
disp("Cota del error cubico")
disp(err(vals(1:4,1),x,cota))
