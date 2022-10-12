
function y=newton_multivariable(f,x0,tol)
    i=0
    norma=1
    x1=x0
    while norma> tol && i< 10000
        x0=x1
        x1=x0-inv(numderivative(f,x0))*f(x0)
        norma=norm(x1-x0,2)
    end   
    if i==10000 then
        y=%inf
    else
        y=x1        
    end

endfunction


function y=hessiana(x)
    x11=16*x(1)^2*exp(2*x(1)^2+x(2)^2)+4*exp(2*x(1)^2+x(2)^2)
    x12=8*x(2)*x(1)*exp(2*x(1)^2+x(2)^2)
    x21=8*x(2)*x(1)*exp(2*x(1)^2+x(2)^2)
    x22=6+exp(2*x(1)^2+x(2)^2)*4*x(2)^2+2*exp(2*x(1)^2+x(2)^2)
    y=[x11,x12;x21,x22]
endfunction


function y=definida_positiva(h)    
    b=spec(h)>0
    disp("Autovalores")
    disp(spec(h))
    y=%T
    for i=1:length(b)
       y=y&&b(i)
    end
endfunction



function y=derivada(x)
    y(1)=2+exp(2*x(1)^2+x(2)^2)*4*x(1)
    y(2)=6*x(2)+exp(2*x(1)^2+x(2)^2)*2*x(2)
endfunction

tol=10^(-2)
x0=[1;1]
x=newton_multivariable(derivada,x0,tol)
if isinf(x) then
    disp("Diverge")
else
    
    disp("Df:")
    disp(derivada(x))
end

h=hessiana(x)
disp("Hessiana:")
disp(h)
if definida_positiva(h) then
    disp("Es un minimo")
else
    disp("Nada q  ver")    
end








