function [t,S,I,R] = ej2_1(I0,S0,R0,N,a,g,tn)
  S = zeros(1,tn+1)
  I = zeros(1,tn+1)
  R = zeros(1,tn+1)
  S(1) = S0
  I(1) = I0
  R(1) = R0
  for k=1:tn
    c = a*S(k)*I(k)/N
    S(k+1) = S(k)- c
    I(k+1) = I(k)+ c - g*I(k)
    R(k+1) = R(k)+g*I(k)
  endfor
  t=[0:tn]
endfunction
#[t,S,I,R] = ej2_1(10,10^6,1,10^6,1,0.5,50)
#plot(t,S,t,I,t,R)  
#
#h = legend ("S", "I","R");
#legend (h, "location", "northeastoutside");
# Falta hacer un script que corra todo




