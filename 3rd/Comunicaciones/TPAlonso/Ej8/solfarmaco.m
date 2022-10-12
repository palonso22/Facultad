function x = solfarmaco(x0,t)
  a=1
  x=zeros(size(t))
  x = x0*exp(-a*t)     
 end