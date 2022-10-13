package Circuitos2
   connector Pin 
      Real v;//Potencial
      flow  Real i;// Corriente
   end Pin;
   
   model Resistor 
     Pin p,n;
     Real u,i;
     parameter Real R=1;
     equation
       u=p.v-n.v;
       i=p.i;
       p.i+n.i=0;   
       u=R*i;
   end Resistor;
   
   model Capacitor 
     Pin p,n;
     Real u,i;
     parameter Real C=1;
     equation  
       u=p.v-n.v;
       i=p.i;
       p.i+n.i=0;
       C*der(u)=i;
    end Capacitor;
    
    
    model Ground 
     Pin p;
     equation 
      p.v=0;
    end Ground;
    
    
    model RC 
     Resistor Res ;
     Capacitor Cap(u.start=1);
     Ground G; 
     equation 
      connect(Res.n,Cap.p);
      connect(Cap.n,G.p);
      connect(Res.p,G.p);
    end RC;
   
end Circuitos2;