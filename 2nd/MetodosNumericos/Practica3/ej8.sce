
function y =iteracion(f,x0,n)
    y=f(x0)
    for i=1:n
        y=f(y)
    end
endfunction

function y=g1(x)
    y=exp(x)/3
endfunction

function y=g2(x)
    y=(exp(x)-x)/2
endfunction


function y=g3(x)
    y=log(3*x)
endfunction

function y=g4(x)
    y=exp(x)-2*x
endfunction

x0=2
x=iteracion(g3,x0,100)
disp("x0:")
disp(x0)
if x==%inf then
    disp("Diverge")
else
    disp("Raiz:")
    disp(x)
end


