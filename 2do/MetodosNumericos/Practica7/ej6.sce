
//a

function y=pol(x)
    y=2+(x+1)*(1+(x-1)*(-2+(x-2)*2))
endfunction


x=0
disp("Interpolacion")
disp(pol(0))

vals=[-1 1 2 4]

//p=poly(vals,'x','r')
//disp(p)
//X=-1:0.001:4
//plot2d(X,horner(p,X))
/*p2=poly([6 14 -18 4],'x','c')
r=roots(p2)
disp(r)
disp(horner(p,r))*/


//b

//Calcula cota para el error de interpolacion
function y=err(vals,x,cota)
    y=abs(prod(x-vals)*cota)/factorial(length(vals))    
endfunction


//calculo cota del error
disp("Cota del error")
disp(err(vals,0,33.6))


