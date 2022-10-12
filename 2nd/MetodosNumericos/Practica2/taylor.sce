//clc // limpia la consola
clear // borra el contenido de la memoria
xdel(winsid()) // cierra ventanas gr´aficas


function y = derivar(f,v,o,h)
    if o == 0 then
        y = f(v)
    else        
        f1= derivar(f,v+h,o-1,h)
        f2= derivar(f,v,o-1,h)
        y = (f1-f2)./h;
    end    
endfunction




function y=derivar2(f,v,o,h)
    y=numderivative(f,v,h,order=o);
endfunction


/*function y=derivar3(f,v,o,h)
    if o == 0 then
        y = f(v)
    else
            sumax =0
            sumaxh=0
            for i=1:o
                resx = f(v+h*i)-f(v+h*(i-1))
                fx=(resx-sumax)/h^i
                sumax = sumax +resx
                // derivada iesima
                y=fx       
            end        
    end    
endfunction*/


function d=derivar3(f,v,o,h)
    deff("y=df0(x)","y=f(x)")
    for i=1:o
            deff("y=df"+string(i)+"(x)","y=(df"+string(i-1)+"(x+h)-df"+string(i-1)+"(x))/h")                    
    end
    deff("y=der(x)","y=df"+string(o)+"(x)")
    d=der(v)
endfunction


// Calculo del polinomio de taylor
function y = taylor(f,v,o,h)
    fact = factorial(0:o)
    y=0
    for i=0:o
        der=derivar3(f,v,i,h)
        y = y + der./fact(i+1)*h^i
    end        
endfunction

// Calculo del polinomio de taylor
function y = taylorExp(x,o)
    coef=[0:o]
    coef=1./(factorial(coef))
    p=poly(coef,'x','coeff')
    y=horner(p,x)
endfunction



//d2=derivar2(cubo,2,3,0.1);
//printf("Con numderivative es %e",d2);




