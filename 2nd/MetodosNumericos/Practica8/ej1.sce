function y=reglaTrapecio(f,a,b)
    /*Entrada:
       - f: funcion a integrar
       - a: limite inferior de intragcion
       - b: limite superior de integracion
      Salida: aproximación de la integracion
    */
    y=metodoCompuestoTrapecio(f,a,b,1)   
endfunction

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



function y=reglaSimpson(f,a,b)
    /*Entrada:
      - f: funcion a integrar
      - a:limite inferior de integracion
      - b:limite superior de integracion
      Salida: aproximacion de la integracion
    */
    y=metodoCompuestoSimpson(f,a,b,2)
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
    trap=reglaTrapecio(f,a,b)
    disp(trap)
    disp("Regla simpson:")
    simpson=reglaSimpson(f,a,b)
    disp(simpson)
    disp("Integracion scilab:")
    sci_integrate=integrate("log(x)",'x',a,b)    
    disp(sci_integrate)    
    y=0
endfunction


function y=f1(x)
    y=x^(1/3)
endfunction

function y=f2(x)
    y=sin(x)^2
endfunction

function y=errorSimpson(b,a,f4,n,x)
    h=(b-a)/n    
    y=-h^4*(b-a)/180*f4(x)
endfunction

function y=errorTrapecio(b,a,f,n,x)
    h=(b-a)/n    
    y=-h^2*(b-a)/12*f(x)
endfunction



function y=d4f1(x)
    y=-80/81*x^(-11/3)
endfunction

function y=d2f1(x)
    y=-2/9*x^(-5/3)
endfunction

function y=d2f2(x)
    y=2*cos(2*x)
endfunction


function y=d4f2(x)
    y=-8*cos(2*x)
endfunction


disp("log(x)")
test(log,1,2,100)
disp("x^(1/3)")
test(f1,0,0.1,100)
disp("sin(x)^2")
test(f2,0,%pi/3,100)
/*trap=reglaTrapecio(f2,0,%pi/3)
simpson=reglaSimpson(f2,0,%pi/3)
sci_int=integrate("f2(x)",'x',0,%pi/3)
vError=abs(simpson-integrate("f2(x)",'x',0,%pi/3))*/
//cotaError=abs(errorTrapecio(0,%pi/3,d2f2,1,0))
/*cotaError=abs(errorSimpson(0,%pi/3,d4f2,1,0))
disp("Error cometido:")
disp(vError)
disp("Cota del error")
disp(cotaError)*/
