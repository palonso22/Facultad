clc // limpia la consola
clear // borra el contenido de la memoria
xdel(winsid()) // cierra ventanas gr´aficas


// Calculo de la derivada utilizando diferencias finitas
function y = derivar(f,v,o,h)
    if o == 0 then
        y = f(v)
    else        
        f1= derivar(f,v+h,o-1,h)
        f2= derivar(f,v,o-1,h)
        y = (f1-f2)./h;
    end    
endfunction

function y = cuadrado(x)
    y = x.*x;
endfunction

function y = cubo(x)
    y = x.*x.*x;
endfunction


/*my_dif = derivar(sin,2,2,0.2);
sci_dif = numderivative(sin,2, 0.2,2);
printf("Mi derivada es %e\n",my_dif);
printf("Con numderivative es %e",sci_dif);*/

//Inicio 
x = %pi/2; // Punto donde vamos a evaluar la derivada
ih = (0:32)';
h = (10.^-ih); // Vector con los valores de h
df_approx = derivar(sin,x,1,h); // Evaluaci´on de la derivada por diferencias finitas
df_scilab = numderivative(sin,x,[],order=1); // Derivada obtenida por numderivative
df_true = 0; // Valor verdadero de la derivada en x = 1

// Errores absolutos y relativos
err_abs = abs(df_approx - df_true);
err_rel = err_abs./abs(df_true);
err_abs_sci = abs(df_scilab - df_true);
err_rel_sci = err_abs_sci/abs(df_true);
// Grafica
plot(ih,log10(err_rel),'b*-'); // Gr´afica en escala logar´ıtmica en el eje y
title('Error relativo utilizando diferencias finitas');
xlabel('i');
ylabel('$log {10} (Err Rel)$');
plot(ih,log10(err_rel_sci*ones(length(ih),1)),'r-');
