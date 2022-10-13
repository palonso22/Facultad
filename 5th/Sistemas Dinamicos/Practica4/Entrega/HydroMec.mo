package HydroMec
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
    Damper damper(b=100), damper1(b=100);  
    PointMass pointMass(m=0.1);
    Fixed fixed;
    Spring spring(k=500);
    Flange flange;
    equation
      connect(damper1.flange1,pointMass.flange); 
      connect(damper1.flange2,fixed.flange)  ; 
      connect(damper.flange2,pointMass.flange);    
      connect(spring.flange1,damper.flange1);
      connect(spring.flange2,pointMass.flange);    
      connect(flange,spring.flange1);
  end SpringDamperMass;
  
  model SpringDamperMassForce
    SpringDamperMass springDamperMass;
    SinForce sf(F=500);
    equation
      connect(springDamperMass.flange,sf.flange);
  end SpringDamperMassForce;
  end Traslacional;
  
  
 package Hydraulic
  type Volume=Real(unit="m^3");
  type Flow=Real(unit="m^3/s");
  type Pressure=Real(unit="Pa");
  
  connector FluidPort
    Pressure p;
    flow Flow q;
  end FluidPort;
  
  model ConstPressure 
    FluidPort port;
    parameter Pressure P=0;
    equation 
      port.p=P;
  end ConstPressure;
  
  
  model SinPressure
     FluidPort port;
     parameter Pressure P=0;
     parameter Real f=1;
     equation 
      port.p=P*sin(6.2832*f*time);    
  end SinPressure;
  
  
  partial model TwoPort
    FluidPort port1,port2;
    Pressure prel;
    Flow q;
    equation
      prel=port1.p-port2.p;
      q=port1.q;
      q=-port2.q;
  end TwoPort;
  
  model Valve
    parameter Real R=1;//Resistencia hidraulica
    extends TwoPort;
    equation
      prel=R*q;
  end Valve;
  
  model OneWayValve
     parameter Real R=1;
     parameter Real Roff=1e9;//Resistencia de fuga
    extends TwoPort;
    equation
      prel=if q>0 then q*R else q*Roff;    
  end OneWayValve;
  
  
  // Columna de agua
  model WaterColumn
    parameter Real h=1;//altura de la columna
    parameter Real g=9.8;//gravedad
    parameter Real rho=997;// densidad del agua
    extends TwoPort;
    equation
       prel=h*g*rho;       
  end WaterColumn;
  
  model Tank
     FluidPort port;
     Volume vol;
     parameter Real A=1;
     constant Real g=9.8;
     constant Real rho=997;
     equation 
       port.p*A=vol*rho*g;
       der(vol)=port.q;     
  end Tank;
  
  
  model PumpTank
    FluidPort fluidPort;
    ConstPressure constPressure(P=0);
    OneWayValve valve1(R=1e5),valve2(R=1e5);
    WaterColumn wc(h=3);
    Tank tank;
    equation 
      connect(valve1.port1,constPressure.port);
      connect(valve1.port2,valve2.port1);
      connect(valve2.port2,wc.port1);
      connect(wc.port2,tank.port); 
      connect(fluidPort,valve2.port1);         
  end PumpTank;
  
  model Pumping
    PumpTank pumpTank;
    SinPressure sp(P=35000);
    equation
      connect(sp.port,pumpTank.fluidPort);
  end Pumping;
 
 end Hydraulic;


  model Piston
   Traslacional.Flange flange;
   Hydraulic.FluidPort port;
   parameter Real A=1;
   equation
     flange.f=port.p*A;
     der(flange.s)*A=-port.q;
  end Piston;
  
  model PistonPumpTank
     Hydraulic.PumpTank pumpTank;
     Piston piston(A=0.01);
     Traslacional.Flange flange;         
     equation
       connect(pumpTank.fluidPort, piston.port);       
       connect(piston.flange, flange);
  end PistonPumpTank;
  
  model PistonPumpTankForce
     Traslacional.SinForce sinForce(F=450);
     HydroMec.PistonPumpTank pistonPumpTank;
     equation
       connect(pistonPumpTank.flange, sinForce.flange);
  end PistonPumpTankForce;


end HydroMec;
