function X=ej4_modelo(pre_x,t)
  al=1 # tasa de contacto
  gam=0.5 # tasa de recuperación
  NPoblacion=1e6 # población 
  mu=0.5 # 
  TI = 3 # Tiempo hasta la infección
  TR  = 12 # Tiempo hasta la recuperación  
  R0 =  1.5 # Individuos expuestos por cada infectado  
  pre_S=pre_x(1)
  pre_E=pre_x(2)  
  pre_I=pre_x(3)  
  pre_R=pre_x(4)  
  N = zeros(1,TR)
  for k=1:TR
    N(k) = pre_x(4+k)
  endfor
  N0 = R0/(TR-TI)*pre_I*pre_S/NPoblacion  
  S = pre_S - N0
  E = pre_E+N0-N(TI)
  I = pre_I + N(TI) - N(TR)
  R = pre_R + N(TR)
  #N(k+1) = N(k) para k=2,...,TR
  for k=0:(TR-2)
    N(TR-k)=N(TR-(k+1))
  endfor  
  N(1)=N0
  X=[S;E;I;R;N']
endfunction

#[t,X]=ej2_simulacion(@ej4_modelo,[1e6-10;0;10;0;N'],0,300)