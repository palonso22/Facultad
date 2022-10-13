function x = ltiSolve(A,B,u,x0,t)
  N=length(t)
  n=length(x0)
  x=zeros(n,N)
  for k=1:N
    x(:,k)=expm(A*t(k))*x0+inv(A)*(expm(A*t(k))-eye(size(A)))*B*u    
  endfor

endfunction