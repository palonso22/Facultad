
function y=cos_n(x,n)
    y=x
    for x=1:n
        y=cos(y)
        printf("Y:%e\n",y)
    end   
endfunction

function y=sin_n(x,n)
    y=x
    for x=1:n
        y=sin(y)
        printf("Y:%e\n",y)
    end   
endfunction




cos_n(0.3,45)
printf("Fin\n")

