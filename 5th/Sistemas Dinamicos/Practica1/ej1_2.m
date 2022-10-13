function [t,P] = ej1_2(P0,b,a,tf)
  P = zeros(1,tf+1);
  P(1)=P0;
  for k=1:tf
    P(k+1) = P(k)*(1+b-a*P(k));
  endfor  
  t = [0:tf];  
endfunction



