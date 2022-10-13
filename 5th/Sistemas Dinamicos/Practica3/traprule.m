function [t,x] = traprule(f,x0,t0,tf,h)
  t=[t0:h:tf]
  x=zeros(length(x0),length(t))
  x(:,1)=x0
  FZ= "x-x(k)-0.5*(h*f(x,t(k)+h)+f(x(k),t(k)))"
  FZ=strrep(FZ,'h',mat2str(h))
  for k=1:length(t)-1
    FZ1=strrep(FZ,"x(k)",mat2str(x(:,k)))
    FZ1=strrep(FZ1,"t(k)",mat2str(t(k)))
    F=inline(FZ1)
    x(:,k+1)=fsolve(F,x(:,k))
    endfor
  endfor
endfunction