

function y =sucesion(f,x0,n)
    y=f(x0)
    for i=1:n
        y=f(y)
    end
    printf("Fin\n")
endfunction

function y=f1(x)
    //c=1/sqrt(5)
    c=-1/5
    y=x+c*(x^2-5)
endfunction

