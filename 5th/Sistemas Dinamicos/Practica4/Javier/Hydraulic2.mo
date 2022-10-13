package Hydraulic2

type Volume=Real(unit="m^3");
type Flow=Real(unit="m^3/s");
type Pressure=Real(unit="Pa");

  connector FluidPort
  
  Pressure p;
  flow Flow q;
  annotation(
      Icon(graphics = {Ellipse(origin = {8, -3}, fillColor = {32, 74, 135}, fillPattern = FillPattern.Solid, extent = {{-94, 95}, {94, -95}}, endAngle = 360), Ellipse(origin = {8, -4}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-56, 56}, {56, -56}}, endAngle = 360)}));
  
  
  end FluidPort;

  partial model AbstractPressure
  Hydraulic.FluidPort port annotation(
      Placement(visible = true, transformation(origin = {-6, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-76, -2}, extent = {{-40, -40}, {40, 40}}, rotation = 0)));
  parameter Pressure P=0;
  equation

  annotation(
      Icon(graphics = {Line(origin = {26.8576, -2.36831}, points = {{-64, 0}, {70, 0}}, thickness = 4.25, arrow = {Arrow.None, Arrow.Open}, arrowSize = 37)}));end AbstractPressure;

  model ConstPressure
    extends Hydraulic.AbstractPressure;  
  equation
  port.p=P;
  annotation(
      Icon(graphics = {Text(origin = {0, 59}, extent = {{-68, 23}, {68, -23}}, textString = "const")}));end ConstPressure;

  model SinPressure
    extends Hydraulic.AbstractPressure;
    parameter Real f=1;
  equation
    port.p=P*sin(6.2832*f*time);

  annotation(
      Icon(graphics = {Text(origin = {3, 47}, extent = {{-47, 25}, {47, -25}}, textString = "sin")}));end SinPressure;

  partial model TwoPort
    Pressure prel;
    Flow q;
  Hydraulic.FluidPort port1 annotation(
      Placement(visible = true, iconTransformation(origin = {0, -64}, extent = {{-42, -42}, {42, 42}}, rotation = 90)));
  Hydraulic.FluidPort port2 annotation(
      Placement(visible = true, iconTransformation(origin = {-2, 56}, extent = {{-42, -42}, {42, 42}}, rotation = 90)));
  equation
    prel=port1.p-port2.p;
    q=port1.q;
    q=-port2.q;
  annotation(
      Icon(graphics = {Text(origin = {-58, -58}, extent = {{-16, 46}, {16, -46}}, textString = "1"), Text(origin = {-60, 64}, extent = {{-16, 46}, {16, -46}}, textString = "2")}));end TwoPort;

  model Valve
    extends Hydraulic.TwoPort;
    parameter Real R=1;
  equation
    prel=R*q;
  annotation(
      Icon(graphics = {Line(origin = {1.95422, -4.56687}, rotation = -90, points = {{-47.5, 0.5}, {48.5, 0.5}, {44.5, 0.5}, {44.5, 2.5}, {44.5, -1.5}}, thickness = 6.25), Line(origin = {46.2359, 2.54952}, rotation = -90, points = {{0.5, -41}, {0.5, 41}, {-63.5, 41}, {62.5, 41}}, thickness = 5.25)}));end Valve;

  model OneWayValve
    extends Hydraulic.TwoPort;
    parameter Real Roff=1e9;
    parameter Real R=1;
  equation
prel=if q>0 then q*R else q*Roff;
  annotation(
      Icon(graphics = {Line(origin = {46.5211, 4.02842}, rotation = -90, points = {{0.5, -41}, {0.5, 41}, {-63.5, 41}, {0.5, 41}}, thickness = 5.25), Line(origin = {1.86972, -0.130282}, rotation = -90, points = {{-47.5, 0.5}, {48.5, 0.5}, {44.5, 0.5}, {44.5, 2.5}, {44.5, -1.5}}, thickness = 6.25)}));end OneWayValve;

  model WaterColumn
    extends Hydraulic.TwoPort;
    parameter Real h=1;
    parameter Real rho=997;
    constant Real g=9.8;
  equation
  prel=h*g*rho;
  annotation(
      Icon(graphics = {Rectangle(origin = {0, 4}, lineColor = {52, 101, 164}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Forward, lineThickness = 1, extent = {{-32, 52}, {32, -52}})}));end WaterColumn;

  model Tank
  Hydraulic.FluidPort port annotation(
      Placement(visible = true, transformation(origin = {0, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, -48}, extent = {{-46, -46}, {46, 46}}, rotation = 0)));
    parameter Real A=1;
    constant Real g=9.8;
    constant Real rho=997;
    Volume vol;
  equation
    port.p*A=vol*rho*g;
    der(vol)=port.q;
  annotation(
      Icon(graphics = {Rectangle(origin = {0, 33}, fillColor = {32, 74, 135}, fillPattern = FillPattern.Solid, borderPattern = BorderPattern.Engraved, extent = {{-96, 59}, {96, -59}})}));end Tank;

  model PumpTank
  Hydraulic.ConstPressure constPressure annotation(
      Placement(visible = true, transformation(origin = {-48, -68}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Hydraulic.OneWayValve valve1(R = 1e5)  annotation(
      Placement(visible = true, transformation(origin = {8, -54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydraulic.OneWayValve valve2(R = 1e5)  annotation(
      Placement(visible = true, transformation(origin = {8, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydraulic.WaterColumn wc(h = 3)  annotation(
      Placement(visible = true, transformation(origin = {8, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydraulic.Tank tank annotation(
      Placement(visible = true, transformation(origin = {8, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydraulic.FluidPort fluidPort annotation(
      Placement(visible = true, transformation(origin = {86, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {72, 2}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  equation
  connect(valve1.port1, constPressure.port) annotation(
      Line(points = {{8, -60.4}, {8.5, -60.4}, {8.5, -68.4}, {-63, -68.4}, {-63, -68}}));
  connect(valve1.port2, valve2.port1) annotation(
      Line(points = {{7.8, -48.4}, {7.8, -24.4}}));
  connect(valve2.port2, wc.port1) annotation(
      Line(points = {{7.8, -12.4}, {7.8, 11.6}}));
  connect(wc.port2, tank.port) annotation(
      Line(points = {{7.8, 23.6}, {7.8, 58.6}}));
  connect(valve2.port1, fluidPort) annotation(
      Line(points = {{8, -24}, {86, -24}, {86, -22}}));
  annotation(
      Icon(graphics = {Rectangle(origin = {-14.5416, -0.0776997}, extent = {{-80.5416, 65.9223}, {80.5416, -65.9223}}), Text(origin = {-24, 0}, extent = {{-64, 30}, {64, -30}}, textString = "PTank")}));end PumpTank;

  model Pumping
  Hydraulic.PumpTank pumpTank annotation(
      Placement(visible = true, transformation(origin = {-35, 39}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  Hydraulic.SinPressure sinPressure(P = 50000)  annotation(
      Placement(visible = true, transformation(origin = {-36, -58}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  equation
    connect(sinPressure.port, pumpTank.fluidPort) annotation(
      Line(points = {{-54, -58}, {-10, -58}, {-10, 40}}));
  end Pumping;



end Hydraulic2;