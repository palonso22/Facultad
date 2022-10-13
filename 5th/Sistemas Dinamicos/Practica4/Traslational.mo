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
    equation
      connect(damper1.flange1,pointMass.flange); 
      connect(damper1.flange2,fixed.flange)  ; 
      connect(damper.flange2,pointMass.flange);    
      connect(spring.flange2,pointMass.flange);    
      connect(spring.flange1,damper.flange1);    
      connect(flange,spring.flange1);
  end SpringDamperMass;
  
  model SpringDamperMassForce
    SpringDamperMass springDamperMass;
    SinForce sf(F=500);
    equation
      connect(springDamperMass.flange,sf.flange);
  end SpringDamperMassForce;
  
  
end Traslacional;