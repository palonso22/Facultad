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