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

clf()
function y=test(vals)
    X=-1:0.01:1
    p=interpolacionLagrange(vals)
    plot2d(X,exp(X)-horner(p,X),style=[color("blue")])
    //plot2d(vals(:,1),vals(:,2)-horner(p,vals(:,1)),style=[color(colors(i))])    
    y=0
endfunction

function t=cambioVariable(a,b,x)
       t=((b+a)-x*(b-a))/2
endfunction


clf()
function y=test(vals)
    X=0:0.01:%pi/2
    p=interpolacionLagrange(vals)
    disp(p)
    plot2d(X,horner(p,X),style=[color("blue")])
    plot2d(X,cos(X),style=[color("red")])
    //plot2d(vals(:,1),vals(:,2)-horner(p,vals(:,1)),style=[color(colors(i))])    
    y=0
endfunction

function r=raicesChebyshev(n)
    /*Calcula las raices del polinomio de chebyshev
    Entrada:
          -n: grado del polinomio de chebyshev
    Salidaa:
          -r: un vector con las raices de Tn
    */
    if n==0 then
        r=[]
    end
    p0=1
    p1=poly([0 1],'x','c')   
    pn=p1
    for i=2:n        
        p2=poly([0 2],'x','c')
        pn=p2*p1-p0
        p0=p1
        p1=pn                            
    end
    r=roots(pn)    
endfunction


//Tomamos como nodos para la interpolacion las raices del polinomio T4
X=raicesChebyshev(4)
a=0
b=%pi/2
//Calculamos T
T=cambioVariable(a,b,X)
//disp(T)
Y=cos(T)
vals=[T Y]
test(vals)



