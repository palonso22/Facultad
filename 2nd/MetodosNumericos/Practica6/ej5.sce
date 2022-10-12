a=[1,0,0;-1,0,1;-1,-1,2]
b=[1,0,0;-0.1,0,0.1;-0.1,-0.1,2]
c=[1,0,0;-0.25,0,0.25;-0.25,-0.25,2]
d=[4,-1,0;-1,4,-1;-1,-1,4]
e=[3,2,1;2,3,0;1,0,3]
f=[4.75,2.25,-0.25;2.25,4.75,1.25;-0.25,1.25,4.75]
g=[5,0,0,-1;1,0,-1,1;-1.5,1,-2,1;1,1,3,-3]


function [a,z]=potencia(A,iter)
    /*calcula el radio spectral de la matriz A*/
    /*calcula el radio spectral de la matriz A
    Entrada:
       - A: una matriz n*n
    Salida:
       - a: una aproximación del autovalor dominante en A
       - z: una aproximación del autovector asociado al autovalor a
    */
    [_,m]=size(A)
    z0=rand(m,1)
    z=z0
    w=z0
    for i=1:iter
            w=A*z0       
            z0=z
            z=w/norm(w,'i')                         
    end
    a=%nan
    for i=1:length(z0)
        if z0(i)<>0 then
            a=w(i)/z0(i)
            break
        end
    end        
endfunction






function y=test(A)    
    //radio spectral
    ro=max(abs(spec(A)))
    [n,m]=size(A)    
    //calculo autovalor dominante
    [a,v]=potencia(A,1000)
    //calculo autovector dominante
    // v=calcularAutovector(A,a)
    if isnan(a) then
        disp("Error al calcular el radio espectral")
    else
        disp("Mi radio espectral:")       
        disp(a)
        disp("Radio espectral de scilab:")
        disp(ro)
        disp("Error")
        disp(norm(ro-a,2))
        disp("A*v")
        disp(A*v)
        disp("a*v")
        disp(v*a)
        disp("Autovector v:")
        disp(v)
    end
    y=0
endfunction

test(a)
test(b)
test(c)
test(d)
test(e)
test(f)
test(g)

//item 6
A=[6,4,4,1;4,6,1,4;4,1,6,4;1,4,4,6]
B=[12,1,3,4;1,-3,1,5;3,1,6,-2;4,5,-2,-1]
//test(A)
test(B)

