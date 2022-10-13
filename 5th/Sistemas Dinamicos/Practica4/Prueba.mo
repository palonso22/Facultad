class Prueba
   Real uC(start=1),uCp,uCn,iC;
   Real uR,uRp,uRn,iR;
   Real uG;
   parameter Real C=0.5,R=2;
equation 
   uR=R*iR;
   uR=uRp-uRn;
   C*der(uC)=iC;
   uG=uRp;
   uG=uCn;
   uRn=uCp;
   iR-iC+iG=0;
   iR=iC;
   uG=0;
end Prueba;