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





//Funcion de la cual se quiere la integral
function z=fun(x,y)
    z=sin(x+y)
endfunction

function z=prueba(x,y)
    z=x^2*y
endfunction

function y=IntegralDoble(f,a,b,c,d,nx,ny,metodo)
    /*
    Entrada:
      -f: funcion de 2 variables a integrar
      - a,b: intervalo de integracion del eje x
      - c,d: intervalo de integracion del eje y
      - nx: cantidad de intervalos en el eje x
      - ny: cantidad de intervalos en el eje y
      - metodo: metodo de aproximacion de la integral en 1 variable
    Salida:
      - y: aproxima de la integral en 2 variables
    */
    //Defino una función para calcular el intevarlo de integración en y
    deff("[c,d]=limites(x)","c="+c+";d="+d)        
    //Defino una función que depende de y
    deff("z=G2(y)","z="+f+"(x,y)")
    //Defino una funcion sobre x   
    deff("z=G1(x)","[c,d]=limites(x);z="+metodo+"(G2,c,d,"+string(ny)+")")
    //Defino una función que calcula la integral sobre x
    deff("z=G()","z="+metodo+"(G1,a,b,"+string(nx)+")")
    y=G()        
endfunction


//disp(IntegralDoble("fun",0,2,"0","1",2,2,"metodoCompuestoTrapecio"))
disp(IntegralDoble("prueba",1,3,"0","2",500,500,"metodoCompuestoTrapecio"))



