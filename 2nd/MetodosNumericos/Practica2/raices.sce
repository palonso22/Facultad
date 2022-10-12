
/*a,b,c son los coeficientes del polinomio
  - a es el coeficiente de grado 2
  - b el coeficiente de grado 1 
  - c el coeficiente de grado 0
*/
/*La salida es un vector x con las raices correspondientes
  - en la posicion 1 del vector se almacena la raiz x_
  - en la posicion 2 del vector se almacena la raiz x+
*/
function x=metodo1(a,b,c)
    val=-b+(b^2-4*a*c)^(1/2)
    x(1)=2*c/val// ecuacion 14
    x(2)=val/(2*a)// ecuacion 7
endfunction


function x=metodo2(a,b,c)
    val=-b-(b^2-4*a*c)^(1/2)
    x(1)=val/(2*a)//ecuacion 6
    x(2)=2*c/val// ecuacion 15
endfunction

/*raices toma un polinomio y devuelve un vector con las raices del mismo*/
function r=raices(p)
    c=coeff(p,0)
    b=coeff(p,1)
    a=coeff(p,2)
    if b<0 then
        r=metodo1(a,b,c)
    else
        r=metodo2(a,b,c)
    end
endfunction

// Test
//p = poly([-0.0001 10000.0 0.0001],"x","coeff");
p=poly([3 -2 1],"x","coeff")
e1 = 1e-8;
roots1 = raices(p);
r1 = roots1(2);
roots2 = roots(p);
r2 = roots2(2);
error1 = abs(r1-e1)/e1;
error2 = abs(r2-e1)/e1;
printf("Esperado : %e\n", e1);
printf("misraices (nuestro) : %e (error= %e)\n", r1, error1);
printf("roots (Scilab) : %e (error= %e)\n", r2, error2);










