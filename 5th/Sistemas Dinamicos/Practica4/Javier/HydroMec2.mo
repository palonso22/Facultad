package HydroMec2
  model Piston
    parameter Real A = 1;
    Hydraulic.FluidPort port annotation(
      Placement(visible = true, transformation(origin = {38, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {87, 1}, extent = {{-43, -43}, {43, 43}}, rotation = 0)));
    Translational.Flange flange annotation(
      Placement(visible = true, transformation(origin = {-38, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-85, 1}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  equation
    flange.f = port.p * A;
    der(flange.s) * A = -port.q;
    annotation(
      Icon(graphics = {Rectangle(origin = {-0.87, -0.121162}, lineThickness = 0.75, extent = {{-95.13, 32.0588}, {95.13, -32.0588}}), Line(origin = {-55, 1.23944}, points = {{-39, -0.5}, {39, -0.5}, {39, 31.5}, {39, -30.5}}, thickness = 2)}));
  end Piston;

  model PistonPumpTank
    Hydraulic.PumpTank pumpTank annotation(
      Placement(visible = true, transformation(origin = {47, 55}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
  HydroMec.Piston piston(A = 0.01)  annotation(
      Placement(visible = true, transformation(origin = {-50, -46}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  Translational.Flange flange annotation(
      Placement(visible = true, transformation(origin = {91, -11}, extent = {{-17, -17}, {17, 17}}, rotation = 0), iconTransformation(origin = {-95, -3}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  equation
    connect(pumpTank.fluidPort, piston.port) annotation(
      Line(points = {{75, 56}, {-30, 56}, {-30, -46}}));
  connect(piston.flange, flange) annotation(
      Line(points = {{-70, -46}, {92, -46}, {92, -10}}));
  protected
  annotation(
      Icon(graphics = {Rectangle(origin = {62, 0}, fillColor = {32, 74, 135}, fillPattern = FillPattern.Solid, borderPattern = BorderPattern.Engraved, extent = {{-38, 26}, {38, -26}}), Rectangle(origin = {-36.4554, -0.210221}, lineThickness = 0.75, extent = {{-59.5446, 32.1479}, {59.5446, -32.1479}}), Line(origin = {-79.4014, 0.130285}, points = {{-39, -0.5}, {39, -0.5}, {39, 31.5}, {39, -30.5}}, thickness = 2)}));
  end PistonPumpTank;

  model PistonPumpTankForce
  Translational.SinForce sinForce(F = 450)  annotation(
      Placement(visible = true, transformation(origin = {-34, -30}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  HydroMec.PistonPumpTank pistonPumpTank annotation(
      Placement(visible = true, transformation(origin = {30, 34}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
  equation
    connect(pistonPumpTank.flange, sinForce.flange) annotation(
      Line(points = {{0, 34}, {-54, 34}, {-54, -30}}));
  end PistonPumpTankForce;
end HydroMec2;