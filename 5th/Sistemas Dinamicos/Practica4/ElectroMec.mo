package ElectroMec

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




package Rotational
   type Torque=Real(unit="N.m");
   type Angle=Real(unit="rad");
   type AngSpeed=Real(unit="rad/s");
   
   
   connector Flange
      Angle th;
      flow Torque tau;
   end Flange; 
   
   model Inertia  
      Flange flange;
      AngSpeed w;
      parameter Real J=1;
      equation
         J*der(w)=flange.tau;
         der(flange.th)=w;         
   end Inertia;
   
   
   model Friction 
   // Este tiene más ecuaciones q variables
      Flange flange;
      AngSpeed w;
      parameter Real b=1;
      equation       
        flange.tau=b*w;
        der(flange.th) = w;
   end Friction;
   
   
   model ConsTorque 
     Flange flange;
     parameter Torque Tau=1;
     equation 
       flange.tau=-Tau;
   end ConsTorque;
   
   
   partial model FricInertia
     Friction friction;
     Inertia inertia;
     Flange flange;
     equation
       connect(friction.flange,inertia.flange);
       connect(flange,inertia.flange);
   end FricInertia;
   
   model FricInertiaTau
      extends FricInertia;
      ConsTorque consTorque;
      equation 
        connect(inertia.flange,consTorque.flange);
   end FricInertiaTau;
   
end Rotational;


model ElMecConv
   extends Electrical.OnePort;
   Rotational.Flange flange;
   Rotational.AngsSpeed w;
   parameter Real K=1;
   equation
     flage.tau=-K*i;
     v=K*w;
     der(flange.th)=w;
end ElMecConv;



model DCMotor
  Electrical.RLOpen rlOpen;
  Rotational.FricInertia fricInertia;
  ElMecConv elMecConv;
  Rotational.Flange flange;
  equation
     connect(rlOpen.pinA,elMecConv.p);
     connect(rlOpen.pinB,elMecConv.n);
     connect(elMecConv.flange,fricInertia.flange);
     connect(flange,fricInertia.flange);
end DCMotor;
   


end ElectroMec;