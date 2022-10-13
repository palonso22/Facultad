function res = circuitRC_implicit(duC1,iR)  
  R=1
  C1=1
  C2=1
  duR=duC1
  duC2=duR
  iC2=C2*duC2
  iC1=-iR-iC2
  res=duC1-iC1/C1
endfunction 