package Mecs
  type Force = Real(unit = "N");
  type Mass = Real(unit = "Kg");
  type Velocity = Real(unit = "m/s");
  type Position = Real(unit = "m");
  type Distance = Real(unit = "m");

  connector Flange
    Position s;
    flow Force f;
    annotation(
      Icon(graphics = {Ellipse(origin = {5, -1}, fillColor = {115, 210, 22}, fillPattern = FillPattern.Solid, extent = {{-73, 67}, {73, -67}}, endAngle = 360), Ellipse(origin = {6.4, -2.6}, fillColor = {238, 238, 236}, fillPattern = FillPattern.Solid, extent = {{-49.6, 45.4}, {49.6, -45.4}}, endAngle = 360)}));
  end Flange;

  model PointMass
    Position s;
    Velocity v;
    parameter Mass m = 1;
    Mecs.Flange flange annotation(
      Placement(visible = true, transformation(origin = {21, -1}, extent = {{-33, -33}, {33, 33}}, rotation = 0), iconTransformation(extent = {{-53, -27}, {13, 39}}, rotation = 0)));
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape shape(height = 0.1, length = 0.1, r = {s, 0, 0}, shapeType = "sphere", width = 0.1)  annotation(
      Placement(visible = true, transformation(origin = {32, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    der(s) = v;
    m * der(v) = flange.f;
    s = flange.s;
    annotation(
      Diagram,
      Icon(graphics = {Ellipse(origin = {2.71, 1.3}, fillColor = {204, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-87.29, 77.3}, {87.29, -77.3}}, endAngle = 360)}));
  end PointMass;

  model Fixed
    parameter Position s0 = 0;
    Mecs.Flange flange annotation(
      Placement(visible = true, transformation(origin = {8, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {17, -1}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  equation
    flange.s = s0;
    annotation(
      Diagram,
      Icon(graphics = {Rectangle(origin = {-18, 1}, fillColor = {241, 228, 228}, fillPattern = FillPattern.Backward, extent = {{-20, 99}, {20, -99}})}));
  end Fixed;

  model Compliant
    Mecs.Flange flange_a annotation(
      Placement(visible = true, transformation(origin = {-99, 3}, extent = {{-33, -33}, {33, 33}}, rotation = 0), iconTransformation(origin = {-71, -3}, extent = {{-41, -41}, {41, 41}}, rotation = 0)));
    Mecs.Flange flange_b annotation(
      Placement(visible = true, transformation(origin = {89, 1}, extent = {{-33, -33}, {33, 33}}, rotation = 0), iconTransformation(origin = {71, -1}, extent = {{-39, -39}, {39, 39}}, rotation = 0)));
    Distance srel;
    Force f;
  equation
    srel = flange_b.s - flange_a.s;
    f = flange_b.f;
    flange_b.f + flange_a.f = 0;
  end Compliant;

  model spring
    extends Mecs.Compliant;
    parameter Real k = 1;
    parameter Real srel0 = 0;//longitud del resorte en reposo

        Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape shape(extra = 6, height = 0.01, length = srel, shapeType = "spring", width = 0.01)  annotation(
      Placement(visible = true, transformation(origin = {-28, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
    f = k*( srel-srel0);
    annotation(
      Icon(graphics = {Line(origin = {10.03, 5.96}, points = {{-54.0302, -5.95677}, {-24.0302, -5.95677}, {-18.0302, 28.0432}, {-12.0302, -29.9568}, {3.96978, 32.0432}, {11.9698, -31.9568}, {21.9698, -3.95677}, {53.9698, -5.95677}, {53.9698, -5.95677}}, color = {92, 53, 102}, thickness = 2)}));end spring;

  model MasaRes
    Fixed fixed annotation(
      Placement(visible = true, transformation(origin = {-66, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Mecs.spring spring(srel0 = 0.5)  annotation(
      Placement(visible = true, transformation(origin = {-18, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Mecs.PointMass pointMass(s(start = 1)) annotation(
      Placement(visible = true, transformation(origin = {26, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Mecs.Damper damper(b = 0.1)  annotation(
      Placement(visible = true, transformation(origin = {-18, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ConstantForce constantForce annotation(
      Placement(visible = true, transformation(origin = {66, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(fixed.flange, spring.flange_a) annotation(
      Line(points = {{-64, 2}, {-28, 2}}));
    connect(spring.flange_b, pointMass.flange) annotation(
      Line(points = {{-8, 2}, {26, 2}, {26, 0}}));
    connect(damper.flange_a, fixed.flange) annotation(
      Line(points = {{-26, -22}, {-70, -22}, {-70, 2}, {-64, 2}}));
    connect(damper.flange_b, pointMass.flange) annotation(
      Line(points = {{-10, -22}, {24, -22}, {24, 0}}));
  connect(constantForce.flange, pointMass.flange) annotation(
      Line(points = {{58, 0}, {24, 0}}));
  protected
  end MasaRes;

  model Damper
    extends Mecs.Compliant;
    parameter Real b=1;  
    Velocity vrel;
  equation
    vrel= der(srel);
    f=b*vrel;
  annotation(
      Icon(graphics = {Line(origin = {-21, -2}, points = {{-23, 0}, {23, 0}, {23, 0}}, thickness = 2), Line(origin = {2, 1}, points = {{0, 21}, {0, -21}, {0, -21}}, thickness = 2), Line(origin = {1, 0}, points = {{-7, 8}, {-19, 8}, {-19, 40}, {19, 40}, {19, -40}, {-19, -40}, {-19, -12}, {-7, -12}, {-7, -12}}, thickness = 2)}));end Damper;

  model Contact
    extends Mecs.Compliant;
    Boolean inContact;
  equation
    srel= if inContact then 0 else 0;
    f= if inContact then 1e10*srel else 1e-10*srel; 
    algorithm 
       when srel<0 then inContact := true;     
       elsewhen srel>0 then inContact :=false;
       end when; 

  annotation(
      Icon(graphics = {Line(origin = {-23, 2}, points = {{-23, 0}, {23, 0}, {23, 0}}, thickness = 3), Line(points = {{0, 42}, {0, -42}, {0, -42}}, thickness = 3)}));end Contact;

  model ConstantForce
  Mecs.Flange flange annotation(
      Placement(visible = true, transformation(origin = {-18, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-71, 1}, extent = {{-45, -45}, {45, 45}}, rotation = 0)));
  parameter Force F=1;
  equation
    flange.f=-F;
  annotation(
      Icon(graphics = {Line(origin = {29, 0}, points = {{-69, 0}, {69, 0}, {69, 0}}, thickness = 3), Line(origin = {69, 20}, points = {{29, -20}, {-29, 20}, {-29, 20}}, thickness = 3), Line(origin = {69, -20}, points = {{29, 20}, {-29, -20}, {-29, -20}}, thickness = 3)}));end ConstantForce;

  model Pelotita
  Mecs.PointMass pointMass(s(start = 1))  annotation(
      Placement(visible = true, transformation(origin = {2, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Mecs.spring spring(k = 1e5)  annotation(
      Placement(visible = true, transformation(origin = {-58, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Mecs.Damper damper(b = 30)  annotation(
      Placement(visible = true, transformation(origin = {20, 2}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Mecs.Contact contact annotation(
      Placement(visible = true, transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Mecs.Fixed fixed annotation(
      Placement(visible = true, transformation(origin = {-10, -66}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Mecs.ConstantForce constantForce(F = -9.8)  annotation(
      Placement(visible = true, transformation(origin = {64, 52}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(contact.flange_b, fixed.flange) annotation(
      Line(points = {{-10, -37}, {-10, -64}}));
  connect(damper.flange_b, contact.flange_a) annotation(
      Line(points = {{20, -6}, {-10, -6}, {-10, -22}}));
  connect(spring.flange_b, contact.flange_a) annotation(
      Line(points = {{-58, -8}, {-10, -8}, {-10, -22}}));
  connect(spring.flange_a, pointMass.flange) annotation(
      Line(points = {{-58, 8}, {0, 8}, {0, 58}}));
  connect(damper.flange_a, pointMass.flange) annotation(
      Line(points = {{20, 10}, {0, 10}, {0, 58}}));
  connect(constantForce.flange, pointMass.flange) annotation(
      Line(points = {{64, 60}, {0, 60}, {0, 58}}));
  end Pelotita;

  model Pelotita2
    Real x(start=1),v;
    Boolean contact(start=false);
    parameter Real b=30,k=1e5,m=1,g=9.8;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape shape(height = 0.1, length = 0.1, r = {0, x, 0}, shapeType = "sphere", width = 0.1)  annotation(
      Placement(visible = true, transformation(origin = {-16, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    der(x)=v;
    m*der(v)=if contact then  -m*g-k*x-b*v   else -m*g ;
    algorithm 
      when x<0 then contact:=true;
      elsewhen x>0 then contact:=false;
      end when;
  end Pelotita2;
  annotation(
    uses(Modelica(version = "4.0.0")));
end Mecs;