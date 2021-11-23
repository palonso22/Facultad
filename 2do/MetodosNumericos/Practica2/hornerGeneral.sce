clear
clc

/*hornerGeneral
  entrada:
       -x0 donde se realiza la evaluacion, 
       -una lista de coeficientes ordenados de menor a mayor grado
  salida:
     -b, el resultado obtenido en b0
     -d, el resultado obtenido de aplicar q(x0)
*/


function [b,d]=hornerGeneral2(x0,coefs)
    n = length(coefs)
    b = coefs(n)
    d = 0
    for i=1:(n-1)
        d = b*x0^(n-i-1) + d            
        b = coefs(n-i)+b*x0        
    end
endfunction

//Test
// Genero un polinomio de forma aleatoria
n=grand('uin',0,10)
coef=grand(1,n,'unf',-5,5)

p=poly(coef,"x","coeff");
[b,d]=hornerGeneral2(2,coeff(p));
printf("b0 es %e\n",b);
printf("q(x0) es %e\n",d);
printf("El resultado de sci_horner es %e\n",horner(p,2));
printf("El resultado de sci_q(X0) es %e\n",horner(derivat(p),2));


