function [t,x] = ej2_simulacion(f,x0,ti,tf)
  t=[ti:tf]
  x(:,1)=x0
  for k=1:length(t)-1    
    x(:,k+1)=f(x(:,k),t(k))
  end  
endfunction
    