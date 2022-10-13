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
    OneWayValve valve1(R=1e10),valve2(R=1e5);
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
    SinPressure sp(P=50000);
    equation
      connect(sp.port,pumpTank.fluidPort);
  end Pumping;


end Hydraulic;