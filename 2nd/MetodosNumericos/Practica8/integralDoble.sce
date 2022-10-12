
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

function z=f1(x,y)
    z=1
endfunction
function z=f2(x,y)
    z=2
endfunction
function z=f3(x,y)
    z=6*x^2*y-2*x
endfunction


function y=test(vr,va)
    disp("Valor real:")
    disp(vr)
    disp("Valor aproximado:")
    disp(va)
    y=0
endfunction



//test
//test(%pi,IntegralDoble("f1",0,2,"-sqrt(2*x-x^2)","sqrt(2*x-x^2)",250,250,"metodoCompuestoTrapecio"))


//test(1.66,IntegralDoble("f2",0,1,"sqrt(x)","1+x",250,250,"metodoCompuestoTrapecio"))


test(222,IntegralDoble("f3",1,4,"0","2",250,250,"metodoCompuestoTrapecio"))
