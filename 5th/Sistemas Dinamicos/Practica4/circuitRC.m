function dx=circuitRC(x,t)
  R=1
  C1=1
  C2=1
  uC1=x(1)
  uC2=x(2)
  uR=x(3)
  iR=uR/R
  F=@(duC1) circuitRC_implicit(duC1,iR)
  duC1=fsolve(F,0)
  duR=duC1
  duC2=duR
  iC2=C2*duC2
  iC1=iR-iC2
  dx=[duC1;duC2;duR]
endfunction