clear
function y=metodoCompuestoTrapecio(f,a,b,n)
    /*Entrada:
       - f: funcion a integrar
       - a: limite inferior de intragcion
       - b: limite superior de integracion
      Salida: aproximación de la integracion
    */
    if a==b then
        y=0
    else
        h=(b-a)/n
        nodos=a:h:b
        ctos=length(nodos)
        y=0.5*f(nodos(1))+0.5*f(nodos(ctos))
        for k=2:ctos-1        
            y=y+f(nodos(k))
        end
        y=h*y            
    end
    
endfunction


function [c,d]=limites(x)
    c=-sqrt(2*x-x^2)
    d=sqrt(2*x-x^2)
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



//Funcion a integrar
function z=fun(x,y)
    z=1
endfunction


function y=IntegralDoble(f,a,b,c,d,nx,ny,metodo)
    /*Cacula una integral doble
      Entrada:
      -f: funcion a integrar
      -a,b: intervalo de integracion variable x 
      -c,d: intervalo de integracion variable y
      -nx: numero de subintervalos en el eje x
      -ny: numero de subintervalos en el eje y
      -metodo: metodo usado para aproximar la integral
      Salida:
        - y:resultado de la aproximacion dado por el metodo
    */
    //Defino una función para calcular el intevarlo de integración en y
    deff("[c,d]=limites(x)","c="+c+";d="+d)        
    //Defino una función que depende de y
    deff("z=G2(y)","z="+f+"(x,y)")
    //Defino una funcion sobre x  que calcula la integral sobre y
    deff("z=G1(x)","[c,d]=limites(x);z="+metodo+"(G2,c,d,"+string(ny)+")")
    //Defino una función que calcula la integral sobre x
    deff("z=G()","z="+metodo+"(G1,a,b,"+string(nx)+")")
    y=G()        
endfunction




res1=IntegralDoble("fun",0,2,"-sqrt(2*x-x^2)","sqrt(2*x-x^2)",200,250,"metodoCompuestoTrapecio")
res2=IntegralDoble("fun",0,2,"-sqrt(2*x-x^2)","sqrt(2*x-x^2)",200,250,"metodoCompuestoSimpson")
disp(abs(res1-%pi))
disp(abs(res2-%pi))



