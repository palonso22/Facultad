package RotoTraslacional

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

package Traslacional
  type Position=Real(unit="m");
  type Distance=Real(unit="m"); 
  type Velocity=Real(unit="m/s");
  type Force=Real(unit="N");
  
  connector Flange
    Position s;
    flow Force f;
  end Flange;
  
  model PointMass
    Flange flange;
    Position s;
    Velocity v;
    parameter Real m=1;
    equation 
      s=flange.s;
      v=der(s);
      m*der(v)=flange.f;
  end PointMass;
  
  model Fixed
    Flange flange;
    parameter Position s0=0;
    equation
      flange.s=s0;
  end Fixed;
  
  
  partial model Compliant
    Flange flange1,flange2;
    Distance srel;
    Force f;
    equation 
      srel=flange2.s-flange1.s;
      flange2.f=f;
      flange1.f=-f;          
  end Compliant;
  
  model Spring 
    extends Compliant;
      parameter Real k=1;
      parameter Real srel0=0;
    equation
      f=k*(srel-srel0);
  end Spring;
  
  
  model Damper 
    extends Compliant;
    parameter Real b=1;
    equation
      f=b*der(srel);
  end Damper;
  
  
  model SinForce 
    Flange flange;
    parameter Force F=1;
    parameter Real f=1;    
    equation 
      flange.f=-F*sin(6.2832*f*time);
  end SinForce;
  
  model SpringDamperMass
    Damper damper(b=1000), damper1(b=100);  
    PointMass pointMass(m=100);
    Fixed fixed;
    Spring spring(k=1000);
    Flange flange;
    Flange flange1;
    equation
      connect(damper1.flange1,pointMass.flange); 
      connect(damper1.flange2,fixed.flange)  ; 
      connect(damper.flange2,pointMass.flange);    
      connect(spring.flange2,pointMass.flange);    
      connect(spring.flange1,damper.flange1);    
      connect(flange,spring.flange1);
      connect(flange1,pointMass.flange);
  end SpringDamperMass;
  
  model SpringDamperMassForce
    SpringDamperMass springDamperMass;
    SinForce sf(F=500);
    equation
      connect(springDamperMass.flange,sf.flange);      
  end SpringDamperMassForce;
  
  
end Traslacional;

model RodCrank
  Rotational.Flange flangerot;
  Traslacional.Flange flange;
  Traslacional.Force F;
  Traslacional.Position x;
  Rotational.Angle th;
  parameter Real r=0.1;
  parameter Real l=1;
  parameter Real x0=-r-1;
  equation 
    th=flangerot.th;
    x+x0=flange.s;
    r^2+x^2=l^2-2*r*l*cos(th);
    flange.f=F*sqrt(1-(r*sin(th)/l)^2);
    flangerot.tau=-r*x*sin(th)*F;
end RodCrank;


model RodCrankMass
  RodCrank rodCrank;
  SpringDamperMass springDM;
  Rotational.Flange flangeR;
  Traslacional.Flange flangeT;
  equation
     connect(rodCrank.flangerot,flangeR);
     connect(springDM.flange,rodCrank.flange);
     connect(springDM.flange1,flangeT);     
end RodCrankMass;


end RotoTraslacional;