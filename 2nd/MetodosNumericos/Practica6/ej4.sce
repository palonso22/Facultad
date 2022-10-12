clf()



a=[1,0,0;-1,0,1;-1,-1,2]
b=[1,0,0;-0.1,0,0.1;-0.1,-0.1,2]
c=[1,0,0;-0.25,0,0.25;-0.25,-0.25,2]
d=[4,-1,0;-1,4,-1;-1,-1,4]
e=[3,2,1;2,3,0;1,0,3]
f=[4.75,2.25,-0.25;2.25,4.75,1.25;-0.25,1.25,4.75]
g=[5,0,0,-1;1,0,-1,1;-1.5,1,-2,1;1,1,3,-3]



//intervalo en el eje x
axex=[-10,10]
//intervalo en el eje y
axey=[-10,10]
// isoview scaling
plot2d(0,0,0,"031"," ",[axex(1),axey(1),axex(2),axey(2)])
xgrid(5,1,7) 
function y=circ(r,x,y)
    xarc(x-r,y+r,2*r,2*r,0,360*64)   
    y=0
endfunction

/*
//circulo de radio 1.5 centrado en (2,3)
circ(1.5,2,3)

//circulo de radio 5 centrado en (0,0)
circ(5,0,0)

//circulo de radio 2.4 centrado en (-1,0)
circ(2.4,-1,0)
*/

function y=Gers(A)
    /*Dibuja todos los circulos de gerschgorin de una matriz A
     Entrada: matriz cuadrada A
     */
     [n,m]=size(A)
     if n<>m then
         disp("A debe ser una matriz cuadrada")
     end
     //calculo cotas para cada circulo de gershgorin de A     
     for i=1:n
         radio=sum(abs([A(i,1:i-1),A(i,i+1:n)]))
         //dibuja circulo de gerschgorin         
         circ(radio,real(A(i,i)),imag(A(i,i)))       
     end       
     y=0
endfunction    

function y=CircGersValor(A)
    disp(A)
    //marco circulos de gerschgorin
    Gers(A)
    //marco graficamente los autovalores de A
    e=spec(A)
    for i=1:length(e)
        plot2d(real(e(i)),imag(e(i)),-2)
    end
endfunction


//CircGersValor(a)
//CircGersValor(b)
//CircGersValor(c)
//CircGersValor(d)
//CircGersValor(e)
//CircGersValor(f)
CircGersValor(g)
