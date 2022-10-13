package Hidraulico
  type Volume = Real(unit = "m^3");
  type Flow = Real(unit = "m^3/s");
  type Pressure = Real(unit = "Pa");

  connector FluidPort
    Pressure p;
    flow Flow q;
    annotation(
      Icon(graphics = {Rectangle(origin = {-0.42, -3.46997}, lineColor = {239, 41, 41}, fillColor = {237, 212, 0}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-18.1, 28.35}, {18.1, -28.35}})}));
  end FluidPort;

  model ConstPressure
    Hidraulico.FluidPort port annotation(
      Placement(visible = true, transformation(origin = {-48, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 4}, extent = {{-74, -74}, {74, 74}}, rotation = 0)));
    parameter Pressure P = 0;
  equation
    port.p = P;
  end ConstPressure;

  model SinPressure
    Hidraulico.FluidPort port annotation(
      Placement(visible = true, transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {96, 2}, extent = {{-76, -76}, {76, 76}}, rotation = 0)));
    parameter Pressure P = 0;
    parameter Real f = 1;
  equation
    port.p = P * sin(6.2832 * f * time);
  end SinPressure;

  partial model TwoPort
    Hidraulico.FluidPort port1 annotation(
      Placement(visible = true, transformation(origin = {-80, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, -93}, extent = {{-75, -75}, {75, 75}}, rotation = 0)));
    Hidraulico.FluidPort port2 annotation(
      Placement(visible = true, transformation(origin = {40, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-1, 105}, extent = {{-75, -75}, {75, 75}}, rotation = 0)));
    Pressure prel;
    Flow q;
  equation
    prel = port1.p - port2.p;
    q = port1.q;
    q = -port2.q;
  end TwoPort;

  model Valve
    extends Hidraulico.TwoPort;
    //resistencia hidráulica
    parameter Real R = 1;
  equation
    prel = R * q;
  end Valve;

  model OneWayValve
    extends Hidraulico.TwoPort;
    //resistencia hidráulica
    parameter Real R = 1;
    //resistencia de fuga
    parameter Real Roff = 1e9;
  equation
    prel = if q > 0 then q * R else q * Roff;
  end OneWayValve;

  model WaterColumn
    extends Hidraulico.TwoPort;
    //Altura de la columna de agua
    parameter Real h = 1;
    //La densidad del agua
    parameter Real rho = 997;
    //La aceleración de la gravedad
    constant Real g = 9.8;
  equation
    prel = h * g * rho;
  end WaterColumn;

  model Tank
    Hidraulico.FluidPort port annotation(
      Placement(visible = true, transformation(origin = {-40, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, -33}, extent = {{-51, -51}, {51, 51}}, rotation = 0)));
    Volume vol;
    //el area de la base del tanque
    parameter Real A = 1;
    constant Real g = 9.8;
    constant Real rho = 997;
  equation
    port.p * A = vol * rho * g;
    der(vol) = port.q;
    annotation(
      Icon(graphics = {Rectangle(origin = {-1, 22}, fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, extent = {{-71, 42}, {71, -42}})}));
  end Tank;

  model PumpTank
    Hidraulico.ConstPressure constpressure(P = 0) annotation(
      Placement(visible = true, transformation(origin = {-74, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Hidraulico.OneWayValve valve1(R = 1e5) annotation(
      Placement(visible = true, transformation(origin = {-30, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Hidraulico.OneWayValve valve2(R = 1e5) annotation(
      Placement(visible = true, transformation(origin = {-30, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Hidraulico.WaterColumn wc(h = 3) annotation(
      Placement(visible = true, transformation(origin = {16, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Hidraulico.FluidPort fluidPort annotation(
      Placement(visible = true, transformation(origin = {99, -11}, extent = {{-15, -15}, {15, 15}}, rotation = 0), iconTransformation(origin = {-102, 2}, extent = {{-86, -86}, {86, 86}}, rotation = 0)));
    Tank tank annotation(
      Placement(visible = true, transformation(origin = {16, 76}, extent = {{-34, -34}, {34, 34}}, rotation = 0)));
  equation
    connect(valve1.port1, constpressure.port) annotation(
      Line(points = {{-30.1, -53.3}, {-30.1, -65.3}, {-52.1, -65.3}, {-52.1, -45}, {-64, -45}}, color = {239, 41, 41}));
    connect(valve1.port2, valve2.port1) annotation(
      Line(points = {{-30, -34}, {-30, -11}}, color = {239, 41, 41}));
    connect(valve2.port2, wc.port1) annotation(
      Line(points = {{-30, 8.5}, {-30, 16.5}, {16, 16.5}, {16, 25}}, color = {239, 41, 41}));
    connect(valve2.port1, fluidPort) annotation(
      Line(points = {{-30, -11}, {99, -11}}, color = {239, 41, 41}));
    connect(wc.port2, tank.port) annotation(
      Line(points = {{16, 44.5}, {16, 65}}, color = {239, 41, 41}));
    connect(valve2.port1, valve2.port2) annotation(
      Line(points = {{16, -12}, {16, 8}}, color = {239, 41, 41}));
  end PumpTank;

  model Pumping
    Hidraulico.PumpTank pumpTank annotation(
      Placement(visible = true, transformation(origin = {44, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Hidraulico.SinPressure sinPressure(P = 50000, f = 1) annotation(
      Placement(visible = true, transformation(origin = {-40, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(sinPressure.port, pumpTank.fluidPort) annotation(
      Line(points = {{-30.4, 4.2}, {-4.4, 4.2}, {-4.4, 4}, {34, 4}}, color = {239, 41, 41}));
  end Pumping;
end Hidraulico;