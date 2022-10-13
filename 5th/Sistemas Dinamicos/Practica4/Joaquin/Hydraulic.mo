package Hydraulic
  type Volume = Real (unit = "m^3");
  type Flow = Real (unit = "m^3/s");
  type Pressure = Real (unit = "Pa");

  connector FluidPort
    Pressure p;
    flow Flow q;
  annotation(
      Icon(graphics = {Rectangle(origin = {-3, -6}, fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, lineThickness = 1.25, extent = {{-49, 54}, {49, -54}})}));
  end FluidPort;

  model ConstPressure
  Hydraulic.FluidPort port annotation(
      Placement(visible = true, transformation(origin = {-12, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {48, 0}, extent = {{52, -52}, {-52, 52}}, rotation = 90)));
  parameter Pressure P = 0;
  equation
port.p=P;
  annotation(
      Icon(graphics = {Line(origin = {-52, 0}, points = {{-36, 0}, {36, 0}}, thickness = 1.25, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 7)}));end ConstPressure;

  model SinPressure
  Hydraulic.FluidPort port annotation(
      Placement(visible = true, transformation(origin = {-10, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {29, -3}, extent = {{-45, -45}, {45, 45}}, rotation = 90)));
  parameter Pressure P = 0;
  parameter Real f = 1;
  equation
  port.p = P*sin(6.2832*f*time);
  annotation(
      Icon(graphics = {Line(origin = {-49.19, -3.95}, points = {{-44.8066, -4.05374}, {-28.8066, 19.9463}, {-18.8066, -20.0537}, {1.19338, 19.9463}, {9.19338, -20.0537}, {17.1934, 3.94626}, {31.1934, 3.94626}, {37.1934, 3.94626}, {41.1934, 3.94626}, {45.1934, 3.94626}}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 7)}));end SinPressure;

  partial model TwoPort
  Pressure prel;
  Flow q;
  Hydraulic.FluidPort port1 annotation(
      Placement(visible = true, transformation(origin = {-28, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, -64}, extent = {{-52, -52}, {52, 52}}, rotation = 0)));
  Hydraulic.FluidPort port2 annotation(
      Placement(visible = true, transformation(origin = {8, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 70}, extent = {{-52, -52}, {52, 52}}, rotation = 0)));
  equation
  prel=port1.p-port2.p;
  q=port1.q;
  q=-port2.q;
  end TwoPort;

  model Valve
    extends Hydraulic.TwoPort;
  parameter Real R = 1;
  equation
  prel = R*q;
  end Valve;

  model OneWayValve
    extends Hydraulic.TwoPort;
  parameter Real R = 1;
  parameter Real Roff = 1e9;
  equation
  prel = if q > 0 then R*q else q*Roff;
  annotation(
      Icon(graphics = {Line(origin = {-4, 20}, points = {{0, 0}}), Line(origin = {-0.351695, 2.2088}, points = {{0, 11}, {0, -37}}, thickness = 1.5), Line(origin = {14.8728, 14.4836}, points = {{-43, 0}, {13, 0}}, thickness = 1.5)}));end OneWayValve;

  model WaterColumn
    extends Hydraulic.TwoPort;
    parameter Real h = 1;
    constant Real g = 9.8;
    parameter Real rho = 997;
  equation
  prel = h*g*rho;
  annotation(
      Icon(graphics = {Rectangle(origin = {1, 0},fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, lineThickness = 1.25, extent = {{-39, 82}, {39, -82}})}));end WaterColumn;

  model Tank
  Volume vol;
  parameter Real A=1;
  constant Real g=9.8;
  constant Real rho=997;
  Hydraulic.FluidPort port annotation(
      Placement(visible = true, iconTransformation(origin = {2, -70}, extent = {{-48, -48}, {48, 48}}, rotation = 0)));
  equation
  port.p*A=vol*rho*g;
  der(vol)=port.q;
  annotation(
      Icon(graphics = {Rectangle(origin = {1.12, -1.74}, lineThickness = 1.25, extent = {{-77.12, 43.74}, {77.12, -43.74}}), Rectangle(origin = {1, -20}, fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, extent = {{-77, 26}, {77, -26}})}));end Tank;

  model PumpTank
  Hydraulic.FluidPort fluidPort annotation(
      Placement(visible = true, transformation(origin = {-78, -6}, extent = {{8, -8}, {-8, 8}}, rotation = 90), iconTransformation(origin = {-87, -5}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  Hydraulic.OneWayValve valve1(R = 1e5)  annotation(
      Placement(visible = true, transformation(origin = {0, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Hydraulic.ConstPressure constpressure annotation(
      Placement(visible = true, transformation(origin = {0, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  OneWayValve valve2(R = 1e5)  annotation(
      Placement(visible = true, transformation(origin = {0, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  WaterColumn wc(h = 3)  annotation(
      Placement(visible = true, transformation(origin = {0, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Tank tank annotation(
      Placement(visible = true, transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(constpressure.port, valve1.port1) annotation(
      Line(points = {{0, -84}, {0, -64}}));
  connect(valve1.port2, valve2.port1) annotation(
      Line(points = {{0, -50}, {0, 8}}));
  connect(fluidPort, valve2.port1) annotation(
      Line(points = {{-78, -6}, {0, -6}, {0, 8}}));
  connect(valve2.port2, wc.port1) annotation(
      Line(points = {{0, 22}, {0, 48}}));
  connect(wc.port2, tank.port) annotation(
      Line(points = {{0, 62}, {0, 84}}));
    annotation(
      Icon(graphics = {Rectangle(origin = {-4, -6}, fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-84, 84}, {84, -84}}), Text(origin = {0, -5}, extent = {{-50, 35}, {50, -35}}, textString = "PumpTank")}));end PumpTank;

  model Pumping
  Hydraulic.PumpTank pumpTank annotation(
      Placement(visible = true, transformation(origin = {51, 3}, extent = {{-41, -41}, {41, 41}}, rotation = 0)));
  Hydraulic.SinPressure sinPressure(P = 50000, f = 1)  annotation(
      Placement(visible = true, transformation(origin = {-75, 1}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  equation
    connect(sinPressure.port, pumpTank.fluidPort) annotation(
      Line(points = {{-70, 0}, {16, 0}}));
  annotation(
      Icon(graphics = {Rectangle(fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-96, 98}, {96, -98}}), Text(origin = {-4, 4}, extent = {{-70, 56}, {70, -56}}, textString = "Pumping")}));end Pumping;
  
end Hydraulic;