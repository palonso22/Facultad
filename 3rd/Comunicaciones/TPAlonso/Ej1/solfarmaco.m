function x = solfarmaco(a,x0,t)
  x=zeros(size(t))
  x = x0*exp(-a*t)     
 end