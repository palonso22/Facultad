function [t,P] = ej1(P0,b,d,tf)
  P = zeros(1,tf+1);
  P(1)=P0;
  for k=1:tf
    P(k+1) = P(k)*(1+b-d);
  endfor  
  t = [0:tf];  
endfunction



