
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


function y=errorTrapecio(b,a,f,n,x)
    h=(b-a)/n    
    y=-h^2*(b-a)/12*f(x)
endfunction




function y=test(ley,a,b,n)
    deff("y=f(x)","y="+ley)
    disp("Regla trapecio:")
    trap=metodoCompuestoTrapecio(f,a,b,n)
    disp(trap)
    disp("Regla simpson:")
    simpson=metodoCompuestoSimpson(f,a,b,n)
    disp(simpson)
    disp("Integracion scilab:")
    
    sci_integrate=integrate(ley,'x',a,b)    
    disp(sci_integrate)    
    y=0
endfunction

disp("a(x)=1")
test("1",1,3,4)
disp("b(x)=x^3")
test("x^3",0,2,4)
disp("c(x)=x*(1+x^2)^(1/2)")
test("x*(1+x^2)^(1/2)",0,3,6)
disp("d(x)=sin(%pi*x)")
test("sin(%pi*x)",0,1,4)
disp("e(x)=x*sin(x)")
test("x*sin(x)",0,2*%pi,8)
disp("ff(x)=x^2*exp(x)")
test("x^2*exp(x)",0,1,8)
