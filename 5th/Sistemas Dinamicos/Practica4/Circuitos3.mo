package Circuitos3
   connector Pin 
      Real v;//Potencial
      flow  Real i;// Corriente
   end Pin;
   
   partial model onePort
      Pin p,n;
      Real u,i;
      equation
         u=p.v-n.v;
         i=p.i;
         p.i+n.i=0;         
   end onePort;
   
   model Resistor 
     extends onePort;
     parameter Real R=1;
     equation
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
    
    model Inductor
       extends onePort;
       parameter Real L=1;
    equation 
       L*der(i)=u;
    end Inductor;   
    
    
    model RLC 
     Resistor Res(R=2) ;
     Capacitor Cap(u.start=1);
     Inductor Ind;
     Ground G; 
     equation 
      connect(Res.n,Cap.p);
      connect(Cap.n,G.p);
      connect(Res.p,G.p);
      connect(Cap.p,Ind.p);
      connect(Cap.n,Ind.n);
    end RLC; 
   
end Circuitos3;