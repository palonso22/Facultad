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
    /*Calcula las diferencias divididas para un arreglo de indices i
    Entrada:
       - i una lista de indices 
       - p  una lista de valores
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

function y=interpolacionNewton(x,p,g)
    /* Realiza una interpolacion de Newton de grado n usando los puntos de la matriz p
      Entrada:
         - x valor donde se quiere evaluar el polinomio
         - p: una matriz que representa n puntos donde cada fila representa un valor sobre la recta x e y su evaluación
         - g: grado de la interpolacion
       Salida :
         - y:Evaluacion de x en la interpolacion de Lagrange
    */
    [n,m]=size(p)
    if m<>2 then
        disp("p no representa una lista de puntos en el plano")
        abort
    end
    if g>n+1  then
        disp("no se puede hacer una interpolacion de grado g")
        abort
    end
    y=0
    restas=x-p(:,1)
    for k=1:g+1
        val=diferenciasDivididas(p(1:k,:))
        if k>1 then
            val=val*prod(restas(1:k-1))
        end            
        y=y+val
    end    
endfunction


function y=eval(x,p,g,metodo)
    y=metodo(x,p,g)
    disp("Resultado de la extrapolacion:")
    disp(y)
endfunction




//Test
p=poly([18 3 -13 2],'x','c')
tab=gsort([6 -1 1.5 0],'g','i')
vals=[tab' horner(p,tab)']
p2=interpolacionLagrange(vals)

X=-10:0.1:10
clf()
plot2d(X,horner(p,X),style=[color("green")])
//plot2d(X,horner(p2,X))


//eval(x,p,3,interpolacionNewton)
//eval(x,p,3,interpolacionLagrange)
