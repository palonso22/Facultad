lambda=1.5;
a=0.01;
N=zeros(1,50);
P=zeros(1,50);
N(1)=120;
P(1)=40;
for k=1:50
  N(k+1)=lambda*N(k)*exp(-a*P(k))
  P(k+1)=N(k)*(1-exp(-a*P(k)))
endfor
t=[0:50];
plot(t,N,t,P);
 