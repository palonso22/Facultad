clear
clc



function y=myHorner(x0,coefs)
    len = length(coefs)
    coef1 = coefs(1)
    if len == 1 then
        y=coef1
    else
        y= coef1+x0*myHorner(x0,coefs(2:len))
    end    
endfunction



function y=myHorner2(x0,coefs)
    len = length(coefs)
    y = coefs(len)
    for i=1:(len-1)
        y = coefs(len-i)+y*x0
    end
endfunction


//Test
//Cada vez que se ejecuta el script genero un polinomio diferente
n=grand('uin',0,10)
coef=grand(1,n,'unf',-5,5)

p=poly(coef,"x","coeff");
printf("El resultado de mi horner recursivo es %e\n",myHorner(2,coeff(p)));
printf("El resultado de mi horner iterativo es %e\n",myHorner2(2,coeff(p)));
printf("El resultado de sci_horner es %e\n",horner(p,2));
