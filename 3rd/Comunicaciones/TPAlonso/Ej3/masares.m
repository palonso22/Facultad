function dx = masares(x,t)
  k=1
  b=1
  m=1
  F=1
  dx1=x(2)
  dx2=-k/m*x(1)-b/m*x(2)-F/m
  dx=[dx1;dx2]
endfunction