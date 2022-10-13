package TPModelica

package Traslacional
  type Position=Real(unit="m");
  type Distance=Real(unit="m"); 
  type Velocity=Real(unit="m/s");
  type Force=Real(unit="N");
  type Mass = Real(unit = "Kg");
  
  connector Flange
    Position s;
    flow Force f;
  end Flange;
  
  model PointMass
    Flange flange;
    Position s;
    Velocity v;
    parameter Mass m=1;
    equation 
      s=flange.s;
      v=der(s);
      m*der(v)=flange.f;
  end PointMass;
  
  model Fixed
    Flange flange;
    Position s0=0;
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
    Spring spring(k=10000);
    Flange flange,flange1;
    equation
      connect(damper1.flange1,pointMass.flange); 
      connect(damper1.flange2,fixed.flange)  ; 
      connect(damper.flange2,pointMass.flange);    
      connect(spring.flange1,damper.flange1);
      connect(spring.flange2,pointMass.flange);    
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
    extends TwoPort;
    parameter Real R=1;
        //Resistencia hidraulica
    equation
      prel=R*q;
  end Valve;
  
  model OneWayValve
     extends TwoPort;
     parameter Real R=1;
     parameter Real Roff=1e9;
        //Resistencia de fuga
    equation
      prel=if q>0 then R*q else q*Roff;    
  end OneWayValve;
  
  
  // Columna de agua
  model WaterColumn
    extends TwoPort;
    parameter Real h=1;//altura de la columna
    parameter Real g=9.8;//gravedad
    parameter Real rho=997;
        // densidad del agua
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
    Tank tank(A=1);
    equation 
      connect(valve1.port1,constPressure.port);
      connect(valve1.port2,valve2.port1);
      connect(valve2.port2,wc.port1);
      connect(wc.port2,tank.port); 
      connect(fluidPort,valve2.port1);         
  end PumpTank;
  
  model Pumping
    PumpTank pumpTank;
    SinPressure sp(P=50000,f=1);
    equation
      connect(sp.port,pumpTank.fluidPort);
  end Pumping;
 
 end Hydraulic;

  

package HydroMec
  
 
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
   
   
   model FricInertia
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






package RotoTraslacional

model RodCrank
  Rotational.Flange flangerot;
  Traslacional.Flange flange;
  Traslacional.Force F;
  Traslacional.Position x;
  Rotational.Angle th;
  parameter Real r=0.1;
  parameter Real l=1;
  parameter Real x0=(-r)-l;
  equation 
    th=flangerot.th;
    x+x0=flange.s;
    r^2+x^2=l^2+2*r*x*cos(th);    
    flange.f=F*sqrt(1-(r*sin(th)/l)^2);
    flangerot.tau=r*x*sin(th)*F;
end RodCrank;


model RodCrankMass
  RodCrank rodCrank;
  Traslacional.SpringDamperMass springDM;
  Rotational.Flange flangeR;
  Traslacional.Flange flangeT;
  equation
     connect(rodCrank.flangerot,flangeR);
     connect(springDM.flange,rodCrank.flange);
     connect(springDM.flange1,flangeT);     
end RodCrankMass;



  model RodCrankMassTau
    extends RodCrankMass;
    Rotational.Inertia inertia ;
    Rotational.ConstTorque constTorque(Tau = 0.5);
  equation
    connect(inertia.flange, flangeRotational) ;
    connect(constTorque.flange, flangeRotational) ;
  end RodCrankMassTau;



end RotoTraslacional;


package Electrical
   type Voltage = Real(unit="V");
   type Current = Real(unit="A");
   
   
   connector Pin 
      Voltage v;//Voltaje
      flow  Current i;// Corriente
   end Pin;  

  partial model OnePort
     Pin p,n;
     Voltage v;
     Current i;
     equation
        v=p.v-n.v;
        i= p.i;
        i= -n.i;
   end OnePort;
  
   
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
    
    
    model RLOpen
       ConstVoltage constVoltage(V=800);//Genera la corriente
       Resistor resistor(R=1);//limita la corriente que circula
       Inductor inductor(L=1);//forma un campo magnetico y genera movimiento
       Ground ground;
       Pin pinA,pinB;
       equation 
         connect(inductor.n,pinA);
         connect(ground.p,pinB);
         connect(resistor.n,inductor.p);
         connect(constVoltage.p,resistor.p);
         connect(ground.p,constVoltage.n);                          
    end RLOpen;
    
    
    model RL
    RLOpen rlOpen;      
    equation
      connect(rlOpen.pinA,rlOpen.pinB);      
    end RL;
    
end Electrical;




package ElectroMec


model ElMecConv
   extends Electrical.OnePort;
   Rotational.Flange flange;
   Rotational.AngSpeed w;
   parameter Real K=1;
   equation
     flange.tau=-K*i;
     v=K*w;
     der(flange.th)=w;
end ElMecConv;



model DCMotor
  Electrical.RLOpen rlOpen;//circuito electrico
  Rotational.FricInertia fricInertia;//simularia el eje o manivela
  ElMecConv elMecConv;//conversor de energía electrica en energía mecanica
  Rotational.Flange flange;
  equation
     connect(rlOpen.pinA,elMecConv.p);
     connect(rlOpen.pinB,elMecConv.n);
     connect(elMecConv.flange,fricInertia.flange);
     connect(flange,fricInertia.flange);
end DCMotor;
   


end ElectroMec;



model SistemaCompleto
   ElectroMec.DCMotor dcMotor;
   RotoTraslacional.RodCrankMass rodCM;
   HydroMec.PistonPumpTank pistonPT;
   equation 
      connect(rodCM.flangeT,pistonPT.flange);
      connect(rodCM.flangeR,dcMotor.flange);   
end SistemaCompleto;


end TPModelica;