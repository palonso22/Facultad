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


//test
function y=test(f,a,b)
    clf
    h=(b-a)/10
    X=a:h:b
    vals=[X' f(X)']
    p=interpolacionLagrange(vals)
    plot2d(X,f(X),style=[color("blue")])
    plot2d(X,horner(p,X),style=[color("red")])
endfunction

function y=f1(x)
    y=x^2+1
endfunction

//test
//test(tan,-1,1)
//test(sin,-1,1)
//test(f1,-1,1)
