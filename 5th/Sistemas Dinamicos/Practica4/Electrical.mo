package Electrical
   type Voltage = Real(unit="V");
   type Current = Real(unit="A");
   
   
   connector Pin 
      Real v;//Voltaje
      flow  Real i;// Corriente
   end Pin;
   
   model ConstVoltage
      Pin p,n;
      parameter Voltage V=1;
      equation
        p.v-n.v=V;
        p.i+n.i=0;
   end ConstVoltage;
   
   model Ground 
      Pin p;
      equation 
        p.v=0;
   end Ground;
   
   
   partial model OnePort
     Pin p,n;
     Voltage v;
     Current i;
     equation
        v=p.v-n.v;
        i= p.i;
        i= -n.i;
   end OnePort;
  
   
   model Resistor 
     extends OnePort;
     parameter Real R=1;
     equation
       v=R*i;       
   end Resistor;
   
   model Inductor 
     extends OnePort;     
     parameter Real L=1;
     equation  
       L*der(i)=v;       
    end Inductor;
    
    
    partial model RLOpen
       ConstVoltage va(V=12);
       Resistor ra(R=1);
       Inductor la(L=0.001);
       Ground gr;
       Pin pinA,pinB;
       equation 
         connect(va.p,ra.p);
         connect(va.n,gr.p);
         connect(ra.n,la.p);
         connect(gr.p,la.n);
         connect(la.n,pinA);
         connect(gr.p,pinB);
    end RLOpen;
    
    
    model RL
    RLOpen rlOpen;      
    equation
      connect(rlOpen.pinA,rlOpen.pinB);      
    end RL;
    
end Electrical;