function y=metodoCompuestoTrapecio(f,a,b,n)
    /*Entrada:
       - f: funcion a integrar
       - a: limite inferior de intragcion
       - b: limite superior de integracion
       - n: número de intervalos
      Salida: aproximación de la integracion
    */
    if a==b then
        y=0
    else
        h=(b-a)/n
        nodos=a:h:b
        ctos=length(nodos)
        y=0.5*f(nodos(1))+0.5*f(nodos(ctos))
        for i=2:ctos-1        
            y=y+f(nodos(i))
        end
        y=h*y            
    end
endfunction


function y=ErrorTrapecio(a,b,n,cota)
    h=(b-a)/n
    y=-h^2*(b-a)/12*cota
endfunction
