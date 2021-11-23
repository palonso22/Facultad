clear()
clf()
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

function y=f(x)
    y=(1+x^2)^(-1)
endfunction


colors=["red" "blue" "yellow" "green" "black"]
n=[2 4 6 10 14]
function y=test(i)
    disp(i)
    X=-5:10/n(i):5
    vals=[X' f(X)']
    p=interpolacionLagrange(vals)
    X=-5:0.1:5
    plot2d(X,f(X)-horner(p,X),style=[color(colors(i))])    
    y=0
endfunction


for i=1:5
    test(i)
end


//Comentario: se observa que el error en los extremos del intervalo de interpolacion tiende a crecer cuando se aumenta el n.
// Esto se debe al fenómeno de Runge que puede aparecer cuando se está interpolando un polinomio de alto grado.
// El producto entre la distancia de los nodos con respecto a x forma un función oscilante en los extremos, causando que el error oscile.





