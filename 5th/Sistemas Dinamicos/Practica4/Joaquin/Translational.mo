package Translational
  type Position = Real(unit = "m");
  type Distance = Real(unit = "m");
  type Velocity = Real(unit = "m/s");
  type Force = Real(unit = "N");
  type Mass = Real(unit = "Kg");
  
  model PointMass
    Translational.Flange flange annotation(
      Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {3, 41}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
    Position s;
    Velocity v;
    parameter Mass m = 1;
  equation
    s = flange.s;
    v = der(s);
    m*der(v) = flange.f;
  protected
    annotation(
      Icon(graphics = {Rectangle(origin = {6, -41}, fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, lineThickness = 1.5, extent = {{-68, 57}, {68, -57}})}));
  end PointMass;

  connector Flange
    Position s;
    flow Force f;
    annotation(
      Icon(graphics = {Ellipse(origin = {3, -1}, lineThickness = 6, extent = {{-85, 81}, {85, -81}}, endAngle = 360)}));
  end Flange;

  model Fixed
  Translational.Flange flange annotation(
      Placement(visible = true, transformation(origin = {-8, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {9, -1}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
    Position s0 = 0;
    
  equation
  flange.s = s0;  
  annotation(
      Icon(graphics = {Rectangle(origin = {-58.01, 0.26}, fillColor = {238, 238, 236}, fillPattern = FillPattern.Backward, lineThickness = 0.2, extent = {{-41.99, 99.74}, {41.99, -99.74}})}));end Fixed;

  partial model Compliant
    Translational.Flange flange1 annotation(
      Placement(visible = true, transformation(origin = {-222, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-52, -2}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
    Translational.Flange flange2 annotation(
      Placement(visible = true, transformation(origin = {-26, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {61, -1}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    Distance srel;
    Force f;
  equation 
    srel = flange2.s - flange1.s;
    flange2.f = f;
    flange1.f = -f;
  annotation(
      Icon);end Compliant;

  model Spring
    extends Translational.Compliant;
    parameter Real k = 1;
    parameter Real srel0 = 0;
  equation
    f = k *(srel - srel0);
  annotation(
      Icon(graphics = {Line(origin = {1.85, 0}, points = {{-33.8536, 0}, {-25.8536, 0}, {-19.8536, 40}, {-13.8536, -40}, {-5.85355, 40}, {4.14645, -40}, {10.1464, 40}, {18.1464, -40}, {24.1464, 0}, {34.1464, 0}, {38.1464, 0}}, thickness = 1.75)}));end Spring;

  model SinForce
  Translational.Flange flange annotation(
      Placement(visible = true, transformation(origin = {-8, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-47, -5}, extent = {{-61, -61}, {61, 61}}, rotation = 0)));
   parameter Force F = 1;
   parameter Real f = 1;
  equation
    flange.f = -F*sin(6.2832*f*time);
  annotation(
      Icon(graphics = {Line(origin = {34, -4}, points = {{-32, 0}, {32, 0}}, thickness = 3, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 12)}));end SinForce;

  model Damper
    extends Translational.Compliant;
    parameter Real b = 1;
  equation
  f = b*der(srel);
  annotation(
      Icon(graphics = {Line(origin = {-6.14, -3.2}, points = {{-25.2, 3.2}, {16.8, 3.2}, {16.8, 15.2}}, thickness = 1.75), Line(origin = {10.66, -7.33}, points = {{0, 7}, {0, -7}, {0, -5}}, thickness = 1.75), Line(origin = {10.98, 31.02}, points = {{-4.98079, -11.0192}, {9.01921, -11.0192}, {9.01921, -51.0192}, {-4.98079, -51.0192}, {9.01921, -51.0192}}, thickness = 1.75), Line(origin = {23.1287, 40.8393}, points = {{-1.8081, -40.1822}, {18.1919, -40.1822}, {20.1919, -30.1822}, {18.1919, -38.1822}}, thickness = 1.75)}));end Damper;

  model SpringDamperMass
  Translational.Fixed fixed annotation(
      Placement(visible = true, transformation(origin = {88, -2}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
  Translational.Damper damper(b = 100)  annotation(
      Placement(visible = true, transformation(origin = {57, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
  Translational.Spring spring(k = 10000)  annotation(
      Placement(visible = true, transformation(origin = {-29, 21}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Translational.Damper damper1(b = 100)  annotation(
      Placement(visible = true, transformation(origin = {-31, -33}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
  Translational.PointMass pointMass(m = 0.1)  annotation(
      Placement(visible = true, transformation(origin = {26, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Translational.Flange flange annotation(
      Placement(visible = true, transformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-88, 2}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  equation
    connect(pointMass.flange, damper.flange1) annotation(
      Line(points = {{26, -2}, {48, -2}}));
  connect(damper.flange2, fixed.flange) annotation(
      Line(points = {{68, 0}, {84, 0}, {84, -2}}));
  connect(spring.flange2, pointMass.flange) annotation(
      Line(points = {{-16, 22}, {26, 22}, {26, -2}}));
  connect(damper1.flange2, pointMass.flange) annotation(
      Line(points = {{-18, -32}, {26, -32}, {26, -2}}));
  connect(spring.flange1, damper1.flange1) annotation(
      Line(points = {{-42, 20}, {-60, 20}, {-60, -34}, {-44, -34}}));
  connect(flange, spring.flange1) annotation(
      Line(points = {{-90, -2}, {-76, -2}, {-76, 20}, {-42, 20}}));
  annotation(
      Icon(graphics = {Text(origin = {8, 2}, extent = {{-46, 52}, {46, -52}}, textString = "SDM"), Rectangle(origin = {2, 2}, lineThickness = 1.75, extent = {{-90, 88}, {90, -88}})}));end SpringDamperMass;

  model SpringDamperMassForce
  Translational.SpringDamperMass springDamperMass annotation(
      Placement(visible = true, transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Translational.SinForce sinForce(F = 500)  annotation(
      Placement(visible = true, transformation(origin = {32, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(springDamperMass.flange, sinForce.flange) annotation(
      Line(points = {{-24, 0}, {28, 0}}));
  end SpringDamperMassForce;
end Translational;