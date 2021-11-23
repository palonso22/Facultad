
function y =sucesion(f,x0,n)
    y=f(x0)
    for i=1:n
        y=f(y)
    end
endfunction

function y=f1(x)
    y=2^(x-1)
endfunction

// La iteracion converge para x0<=2, con lim 1 si x0<2 y lim 2 si x0=2

//D

function y=test(x0)
    printf("x(n+1)=2^(xn-1)")
    printf("Test con x0=%e\n",x0)
    x=sucesion(f1,0.5,100000)
    if x == %inf then
        printf("Diverge\n")
    else
        printf("El limite de la iteracion es %e\n",x)
    end   
    y=0 
endfunction


test(0.5)
test(-1)
test(1.5)
test(2)
test(2.5)



    

