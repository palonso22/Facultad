function y=metodoCompuestoSimpson(f,a,b,n)
    /*Entrada:
      - f: funcion a integrar
      - a:limite inferior de integracion
      - b:limite superior de integracion
      Salida: aproximacion de la integracion
    */
    if modulo(n,2)<>0 then
        disp("n tiene que ser múltiplo de 2")
        abort
    end
    if a==b then
        y=0
    else
        h=(b-a)/n
        nodos=a:h:b
        ctos=length(nodos)
        y=0
        for i=1:2:ctos-2
            y=y+h/3*(f(nodos(i))+4*f(nodos(i+1))+f(nodos(i+2)))
        end                    
    end
endfunction


function y=ErrorSimpson(a,b,n,cota)
    h=(b-a)/n
    y=-h^4*(b-a)/180*cota
endfunction

