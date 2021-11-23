function y=metodoCompuestoTrapecio(f,a,b,n)
    /*Entrada:
       - f: funcion a integrar
       - a: limite inferior de intragcion
       - b: limite superior de integracion
       - n: número de intervalos
      Salida: aproximación de la integracion
    */
    h=(b-a)/n
    nodos=a:h:b
    ctos=length(nodos)
    y=0.5*f(nodos(1))+0.5*f(nodos(ctos))
    for i=2:ctos-1        
        y=y+f(nodos(i))
    end
    y=h*y    
endfunction


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
    h=(b-a)/n
    nodos=a:h:b
    ctos=length(nodos)
    y=0
    for i=1:2:n
        y=y+h/3*(f(nodos(i))+4*f(nodos(i+1))+f(nodos(i+2)))
    end    
endfunction


function y=test(f,a,b,n)
    disp("Regla trapecio:")
    trap=metodoCompuestoTrapecio(f,a,b,n)
    disp(trap)
    disp("Regla simpson:")
    simpson=metodoCompuestoSimpson(f,a,b,n)
    disp(simpson)
    disp("Integracion scilab:")
    sci_integrate=integrate("f1(x)",'x',a,b)
    disp(sci_integrate)
    y=0
endfunction


function y=f1(x)
    y=(x+1)^(-1)
endfunction



test(f1,0,1.5,10)



