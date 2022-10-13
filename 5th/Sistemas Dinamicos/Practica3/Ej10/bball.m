function dx = bball(x,t)
  dx1=x(2)
  k=1e6
  m=1
  b=30
  g = 9.8
  if x(1)>0
    dx2=-g
  else
    dx2=-g-k/m*x(1)-b/m*x(2)
  endif
  dx=[dx1;dx2]
endfunction