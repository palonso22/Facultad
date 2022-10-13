package Circuitos
 model Resistor
     Real uR,uRp,uRn,iR;
     parameter Real R;
     equation 
        uR=R*iR;
        uR=uRp-uRn;
 end Resistor;
 
 
 model Capacitor
    Real uC,uCp,uCn,iC;
    parameter Real C;
    equation 
      C*der(uC)=iC;
      uC=uCp-uCn;
 end Capacitor;
 
 
 model Ground 
   Real uG,iG;
   equation 
     uG=0;
 end Ground;
 
 
 
 model RC 
   Resistor Res;
   Capacitor Cap;
   Ground G;
   equation 
     Res.uRn=Cap.uCp;
     Res.iR=Cap.iC;
     Cap.uCn=G.uG;
     Res.uRp=G.uG;
     Cap.iC-Res.iR-G.iG=0;
 end RC;     
          
end Circuitos;