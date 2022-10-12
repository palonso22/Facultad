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
    for k=n:-1:1        
        div=diferenciasDivididas(p(1:k,:))
        dif=poly(p(k,1),'x','r')
        y=y*dif
        y=y+div
    end    
endfunction

clf()
vals=[0 1;0.2 1.2214; 0.4 1.4918; 0.6 1.8221]
x=1/3
X=0:0.01:0.6
p=interpolacionNewton(vals)
plot2d(X,horner(p,X),style=[color("red")])
plot2d(X,exp(X),style=[color("blue")])

