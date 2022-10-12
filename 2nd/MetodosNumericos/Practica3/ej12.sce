
function y=newton_multivariable(f,x0,tol)
    i=0
    norma=1
    x1=x0
    while norma> tol && i< 10000
        x0=x1
        x1=x0-inv(numderivative(f,x0))*f(x0)
        norma=norm(x1-x0,2)
        i=i+1
    end   
    if i==10000 then
        y=%inf
    else
        y=x1        
    end
endfunction


function y=presion(k)
    y(1)=k(1)*exp(k(2))+k(3)-10
    y(2)=k(1)*exp(2*k(2))+2*k(3)-12
    y(3)=k(1)*exp(3*k(2))+3*k(3)-15
endfunction




k0=[2,2,2]'
k=newton_multivariable(presion,k0,1e-1)

/*if isinf(l) then
    disp("Diverge")
else
    disp("Raiz:")
    disp(k(1))   
    disp(k(2))   
    disp(k(3))   
    disp("presion(r)")
    disp(presion(k))
end*/

//solucion obtenida en el item anterior
 k=[8.7870346,0.2684243,-1.4793298]'



//item b
function y=radio(r)
    y=%pi*r^2*(k(1)*exp(k(2)*r)+r*k(3))-500
endfunction



r0=2
r=newton_multivariable(radio,r0,1e-1)
if isinf(r) then
    disp("Diverge")
else    
    disp("Raiz:")
    disp(r)
    disp("radio(r)")
    disp(radio(r))
end

//El radio mínimo obtenido fue 3.1664663
