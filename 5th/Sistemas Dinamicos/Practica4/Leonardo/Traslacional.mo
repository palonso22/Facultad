package Traslacional
  //type Mass = Real(unit = "Kg");
  type Position = Real(unit = "m");
  type Distance = Real(unit = "m");
  type Velocity = Real(unit = "m/s");
  type Force = Real(unit = "N");

  connector flange
    Position s;
    flow Force f;
    annotation(
      Icon(graphics = {Ellipse(origin = {-1, -1}, lineColor = {239, 41, 41}, lineThickness = 1, extent = {{-67, 63}, {67, -63}}, endAngle = 360), Ellipse(origin = {-1, -2}, extent = {{-43, 40}, {43, -40}}, endAngle = 360)}));
  end flange;

  model PointMass
    Traslacional.flange flange annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1.68754e-14, -1.68754e-14}, extent = {{-84, -84}, {84, 84}}, rotation = 0)));
    Position s;
    Velocity v;
    parameter Real m = 1;
  equation
    s = flange.s;
    v = der(s);
    m * der(v) = flange.f;
    annotation(
      Icon(graphics = {Rectangle(origin = {1, -2}, fillColor = {206, 92, 0}, fillPattern = FillPattern.Sphere, extent = {{-93, 92}, {93, -92}})}));
  end PointMass;

  model Fixed
    parameter Real s0 = 0;
    Traslacional.flange flange annotation(
      Placement(visible = true, transformation(origin = {-28, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {34, -4}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  equation
    flange.s = s0;
    annotation(
      Icon(graphics = {Rectangle(origin = {66, -1}, fillColor = {211, 215, 207}, pattern = LinePattern.DashDot, fillPattern = FillPattern.Backward, lineThickness = 0.15, extent = {{-22, 97}, {22, -97}})}));
  end Fixed;

  partial model Compliant
    Traslacional.flange flange1 annotation(
      Placement(visible = true, transformation(origin = {-64, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-79, -1}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
    Traslacional.flange flange2 annotation(
      Placement(visible = true, transformation(origin = {-66, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {79, -1}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
    Distance srel;
    Force f;
  equation
    srel = flange2.s - flange1.s;
    flange2.f = f;
    flange1.f = -f;
  end Compliant;

  model Spring
    extends Traslacional.Compliant;
    parameter Real k = 1;
    parameter Real srel0 = 0;
  equation
    f = k * (srel - srel0);
    annotation(
      Icon(graphics = {Line(origin = {-1.37078, 1.57653}, points = {{62.0528, -2.01586}, {38.0528, -2.01586}, {24.0528, -24.0159}, {22.0528, 21.9841}, {12.0528, -24.0159}, {4.05279, 23.9841}, {-7.94721, -26.0159}, {-13.9472, 23.9841}, {-21.9472, -24.0159}, {-31.9472, 23.9841}, {-31.9472, -26.0159}, {-35.9472, -2.01586}, {-39.9472, -2.01586}, {-61.9472, -2.01586}})}));
  end Spring;

  model Damper
    extends Traslacional.Compliant;
    parameter Real b = 1;
  equation
    f = b * der(srel);
    annotation(
      Icon(graphics = {Line(origin = {-20.4393, 0}, points = {{-44, 0}, {18, 0}, {18, 0}, {38, 0}}), Line(origin = {14, 0}, points = {{-26, 8}, {-26, 20}, {26, 20}, {26, -16}, {26, -20}, {-26, -20}, {-26, -8}, {-26, -8}}), Line(origin = {18, 3}, points = {{0, 9}, {0, -13}}), Line(origin = {52, 0}, points = {{-12, 0}, {12, 0}})}));
  end Damper;

  model SinForce
    Traslacional.flange flange annotation(
      Placement(visible = true, transformation(origin = {0, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {69, -1}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
    parameter Force F = 1;
    parameter Real f = 1;
  equation
    flange.f = -F * sin(6.2832 * f * time);
    annotation(
      Icon(graphics = {Line(origin = {4.5, 0}, points = {{63.5, 0}, {-64.5, 0}, {-58.5, 0}}), Line(origin = {-11.61, 2.02}, points = {{9.60957, 13.9832}, {-10.3904, -2.01679}, {9.60957, -14.0168}, {9.60957, -14.0168}}, thickness = 0.75)}));
  end SinForce;

  model SpringDamperMass
    Traslacional.Damper damper(b = 100) annotation(
      Placement(visible = true, transformation(origin = {-39, -31}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
    Traslacional.Spring spring(k = 10000) annotation(
      Placement(visible = true, transformation(origin = {-38, 2}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    Traslacional.Fixed fixed annotation(
      Placement(visible = true, transformation(origin = {77, -17}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
    Traslacional.PointMass pointMass(m = 0.1) annotation(
      Placement(visible = true, transformation(origin = {16, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Traslacional.Damper damper1(b = 100) annotation(
      Placement(visible = true, transformation(origin = {54, -18}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
    Traslacional.flange flange annotation(
      Placement(visible = true, transformation(origin = {-102, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -2}, extent = {{-54, -54}, {54, 54}}, rotation = 0)));
  equation
    connect(damper.flange2, pointMass.flange) annotation(
      Line(points = {{-11, -31}, {0.55, -31}, {0.55, -17.45}, {16.55, -17.45}}));
  connect(damper1.flange2, fixed.flange) annotation(
      Line(points = {{72, -18}, {86, -18}}));
  connect(damper1.flange1, pointMass.flange) annotation(
      Line(points = {{36, -18}, {16, -18}}));
    connect(damper.flange1, flange) annotation(
      Line(points = {{-66, -32}, {-80, -32}, {-80, -18}, {-102, -18}}));
    connect(spring.flange1, flange) annotation(
      Line(points = {{-62, 2}, {-80, 2}, {-80, -18}, {-102, -18}}));
  connect(spring.flange2, pointMass.flange) annotation(
      Line(points = {{-14, 2}, {0, 2}, {0, -18}, {16, -18}}));
  protected
  end SpringDamperMass;

  model SpringDamperMassForce
    Traslacional.SpringDamperMass springDamperMass annotation(
      Placement(visible = true, transformation(origin = {-49, 1}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
    Traslacional.SinForce sinForce(F = 500)  annotation(
      Placement(visible = true, transformation(origin = {56, -8.88178e-16}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
  equation
    connect(sinForce.flange, springDamperMass.flange) annotation(
      Line(points = {{78, 0}, {-18, 0}}));
  end SpringDamperMassForce;
end Traslacional;