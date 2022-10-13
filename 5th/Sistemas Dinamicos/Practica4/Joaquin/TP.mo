package TP

  model TP
    ElectroMec.DCMotor dCMotor annotation(
      Placement(visible = true, transformation(origin = {-83, 1}, extent = {{-33, -33}, {33, 33}}, rotation = 180)));
  HydroMec.PistonPumpTank pistonPumpTank annotation(
      Placement(visible = true, transformation(origin = {88, 0}, extent = {{-34, -34}, {34, 34}}, rotation = 0)));
    RotoTranslational.RodCrankMass rodCrankMass annotation(
      Placement(visible = true, transformation(origin = {4, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  equation
    connect(rodCrankMass.flange, pistonPumpTank.flange) annotation(
      Line(points = {{34, 0}, {56, 0}}));
  connect(rodCrankMass.flangeRotational, dCMotor.flange) annotation(
      Line(points = {{-26, 0}, {-52, 0}, {-52, 2}}));
  protected
  end TP;

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
      m * der(v) = flange.f;
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
        Icon(graphics = {Rectangle(origin = {-58.01, 0.26}, fillColor = {238, 238, 236}, fillPattern = FillPattern.Backward, lineThickness = 0.2, extent = {{-41.99, 99.74}, {41.99, -99.74}})}));
    end Fixed;

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
        Icon);
    end Compliant;

    model Spring
      extends Translational.Compliant;
      parameter Real k = 1;
      parameter Real srel0 = 0;
    equation
      f = k * (srel - srel0);
      annotation(
        Icon(graphics = {Line(origin = {1.85, 0}, points = {{-33.8536, 0}, {-25.8536, 0}, {-19.8536, 40}, {-13.8536, -40}, {-5.85355, 40}, {4.14645, -40}, {10.1464, 40}, {18.1464, -40}, {24.1464, 0}, {34.1464, 0}, {38.1464, 0}}, thickness = 1.75)}));
    end Spring;

    model SinForce
      Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-8, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-47, -5}, extent = {{-61, -61}, {61, 61}}, rotation = 0)));
      parameter Force F = 1;
      parameter Real f = 1;
    equation
      flange.f = -F * sin(6.2832 * f * time);
      annotation(
        Icon(graphics = {Line(origin = {34, -4}, points = {{-32, 0}, {32, 0}}, thickness = 3, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 12)}));
    end SinForce;

    model Damper
      extends Translational.Compliant;
      parameter Real b = 1;
    equation
      f = b * der(srel);
      annotation(
        Icon(graphics = {Line(origin = {-6.14, -3.2}, points = {{-25.2, 3.2}, {16.8, 3.2}, {16.8, 15.2}}, thickness = 1.75), Line(origin = {10.66, -7.33}, points = {{0, 7}, {0, -7}, {0, -5}}, thickness = 1.75), Line(origin = {10.98, 31.02}, points = {{-4.98079, -11.0192}, {9.01921, -11.0192}, {9.01921, -51.0192}, {-4.98079, -51.0192}, {9.01921, -51.0192}}, thickness = 1.75), Line(origin = {23.1287, 40.8393}, points = {{-1.8081, -40.1822}, {18.1919, -40.1822}, {20.1919, -30.1822}, {18.1919, -38.1822}}, thickness = 1.75)}));
    end Damper;

    model SpringDamperMass
      Translational.Fixed fixed annotation(
        Placement(visible = true, transformation(origin = {88, -2}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
      Translational.Damper damper(b = 100) annotation(
        Placement(visible = true, transformation(origin = {57, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
      Translational.Spring spring(k = 10000) annotation(
        Placement(visible = true, transformation(origin = {-29, 21}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
      Translational.Damper damper1(b = 100) annotation(
        Placement(visible = true, transformation(origin = {-31, -33}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
      Translational.PointMass pointMass(m = 0.1) annotation(
        Placement(visible = true, transformation(origin = {26, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-88, 2}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
      Translational.Flange flange1 annotation(
        Placement(visible = true, transformation(origin = {26, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {97, 1}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
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
      connect(flange1, pointMass.flange) annotation(
        Line(points = {{26, 80}, {26, 2}}));
      annotation(
        Icon(graphics = {Text(origin = {8, 2}, extent = {{-46, 52}, {46, -52}}, textString = "SDM"), Rectangle(origin = {2, 2}, lineThickness = 1.75, extent = {{-90, 88}, {90, -88}})}));
    end SpringDamperMass;

    model SpringDamperMassForce
      Translational.SpringDamperMass springDamperMass annotation(
        Placement(visible = true, transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
      Translational.SinForce sinForce(F = 500) annotation(
        Placement(visible = true, transformation(origin = {32, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(springDamperMass.flange, sinForce.flange) annotation(
        Line(points = {{-7, 0}, {28, 0}}));
    end SpringDamperMassForce;
  end Translational;
  package Hydraulic
    type Volume = Real(unit = "m^3");
    type Flow = Real(unit = "m^3/s");
    type Pressure = Real(unit = "Pa");

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
      port.p = P;
      annotation(
        Icon(graphics = {Line(origin = {-52, 0}, points = {{-36, 0}, {36, 0}}, thickness = 1.25, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 7)}));
    end ConstPressure;

    model SinPressure
      Hydraulic.FluidPort port annotation(
        Placement(visible = true, transformation(origin = {-10, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {29, -3}, extent = {{-45, -45}, {45, 45}}, rotation = 90)));
      parameter Pressure P = 0;
      parameter Real f = 1;
    equation
      port.p = P * sin(6.2832 * f * time);
      annotation(
        Icon(graphics = {Line(origin = {-49.19, -3.95}, points = {{-44.8066, -4.05374}, {-28.8066, 19.9463}, {-18.8066, -20.0537}, {1.19338, 19.9463}, {9.19338, -20.0537}, {17.1934, 3.94626}, {31.1934, 3.94626}, {37.1934, 3.94626}, {41.1934, 3.94626}, {45.1934, 3.94626}}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 7)}));
    end SinPressure;

    partial model TwoPort
      Pressure prel;
      Flow q;
      Hydraulic.FluidPort port1 annotation(
        Placement(visible = true, transformation(origin = {-28, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, -64}, extent = {{-52, -52}, {52, 52}}, rotation = 0)));
      Hydraulic.FluidPort port2 annotation(
        Placement(visible = true, transformation(origin = {8, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 70}, extent = {{-52, -52}, {52, 52}}, rotation = 0)));
    equation
      prel = port1.p - port2.p;
      q = port1.q;
      q = -port2.q;
    end TwoPort;

    model Valve
      extends Hydraulic.TwoPort;
      parameter Real R = 1;
    equation
      prel = R * q;
    end Valve;

    model OneWayValve
      extends Hydraulic.TwoPort;
      parameter Real R = 1;
      parameter Real Roff = 1e9;
    equation
      prel = if q > 0 then R * q else q * Roff;
      annotation(
        Icon(graphics = {Line(origin = {-4, 20}, points = {{0, 0}}), Line(origin = {-0.351695, 2.2088}, points = {{0, 11}, {0, -37}}, thickness = 1.5), Line(origin = {14.8728, 14.4836}, points = {{-43, 0}, {13, 0}}, thickness = 1.5)}));
    end OneWayValve;

    model WaterColumn
      extends Hydraulic.TwoPort;
      parameter Real h = 1;
      constant Real g = 9.8;
      parameter Real rho = 997;
    equation
      prel = h * g * rho;
      annotation(
        Icon(graphics = {Rectangle(origin = {1, 0}, fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, lineThickness = 1.25, extent = {{-39, 82}, {39, -82}})}));
    end WaterColumn;

    model Tank
      Volume vol;
      parameter Real A = 1;
      constant Real g = 9.8;
      constant Real rho = 997;
      Hydraulic.FluidPort port annotation(
        Placement(visible = true, iconTransformation(origin = {2, -70}, extent = {{-48, -48}, {48, 48}}, rotation = 0)));
    equation
      port.p * A = vol * rho * g;
      der(vol) = port.q;
      annotation(
        Icon(graphics = {Rectangle(origin = {1.12, -1.74}, lineThickness = 1.25, extent = {{-77.12, 43.74}, {77.12, -43.74}}), Rectangle(origin = {1, -20}, fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, extent = {{-77, 26}, {77, -26}})}));
    end Tank;

    model PumpTank
      Hydraulic.FluidPort fluidPort annotation(
        Placement(visible = true, transformation(origin = {-78, -6}, extent = {{8, -8}, {-8, 8}}, rotation = 90), iconTransformation(origin = {-87, -5}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
      OneWayValve valve1(R = 1e5) annotation(
        Placement(visible = true, transformation(origin = {0, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      OneWayValve valve2(R = 1e5) annotation(
        Placement(visible = true, transformation(origin = {0, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      WaterColumn wc(h = 3) annotation(
        Placement(visible = true, transformation(origin = {0, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Tank tank(A = 1) annotation(
        Placement(visible = true, transformation(origin = {0, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Hydraulic.ConstPressure constPressure(P = 0) annotation(
        Placement(visible = true, transformation(origin = {0, -90}, extent = {{10, -10}, {-10, 10}}, rotation = -90)));
    equation
      connect(constPressure.port, valve1.port1) annotation(
        Line(points = {{0, -86}, {0, -48}}));
      connect(valve1.port2, valve2.port1) annotation(
        Line(points = {{0, -34}, {0, 12}}));
      connect(valve2.port2, wc.port1) annotation(
        Line(points = {{0, 26}, {0, 50}}));
      connect(wc.port2, tank.port) annotation(
        Line(points = {{0, 64}, {0, 90}}));
      connect(fluidPort, valve2.port1) annotation(
        Line(points = {{-78, -6}, {0, -6}, {0, 12}}));
      annotation(
        Icon(graphics = {Rectangle(origin = {-4, -6}, fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-84, 84}, {84, -84}}), Text(origin = {0, -5}, extent = {{-50, 35}, {50, -35}}, textString = "PumpTank")}));
    end PumpTank;

    model Pumping
      Hydraulic.PumpTank pumpTank annotation(
        Placement(visible = true, transformation(origin = {51, 3}, extent = {{-41, -41}, {41, 41}}, rotation = 0)));
      Hydraulic.SinPressure sinPressure(P = 50000, f = 1) annotation(
        Placement(visible = true, transformation(origin = {-75, 1}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
    equation
      connect(sinPressure.port, pumpTank.fluidPort) annotation(
        Line(points = {{-70, 0}, {16, 0}}));
      annotation(
        Icon(graphics = {Rectangle(fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-96, 98}, {96, -98}}), Text(origin = {-4, 4}, extent = {{-70, 56}, {70, -56}}, textString = "Pumping")}));
    end Pumping;
  end Hydraulic;

  package HydroMec
    model Piston
      parameter Real A = 1;
      Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-24, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-92, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Hydraulic.FluidPort port annotation(
        Placement(visible = true, transformation(origin = {2, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {59, 35}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    equation
      flange.f = port.p * A;
      der(flange.s) * A = -port.q;
      annotation(
        Icon(graphics = {Rectangle(origin = {4, -5}, lineThickness = 1.5, extent = {{-80, 35}, {80, -35}}), Rectangle(origin = {-35, -2}, fillColor = {193, 125, 17}, fillPattern = FillPattern.Solid, extent = {{-49, 4}, {49, -4}}), Rectangle(origin = {18, -5}, fillColor = {193, 125, 17}, fillPattern = FillPattern.Solid, extent = {{-6, 33}, {6, -33}})}));
    end Piston;

    model PistonPumpTank
      HydroMec.Piston piston(A = 0.01) annotation(
        Placement(visible = true, transformation(origin = {-23, -11}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      Hydraulic.PumpTank pumpTank annotation(
        Placement(visible = true, transformation(origin = {56, 16}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
      Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-88, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-93, -1}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
    equation
      connect(piston.port, pumpTank.fluidPort) annotation(
        Line(points = {{-8, -2}, {-8, 14}, {34, 14}}));
      connect(flange, piston.flange) annotation(
        Line(points = {{-88, -12}, {-46, -12}}));
      annotation(
        Icon(graphics = {Rectangle(fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, lineThickness = 1.25, extent = {{-94, 94}, {94, -94}}), Text(origin = {7, 1}, lineThickness = 1.5, extent = {{-77, 59}, {77, -59}}, textString = "PistonPumpTank")}));
    end PistonPumpTank;

    model PistonPumpTankForce
      HydroMec.PistonPumpTank pistonPumpTank annotation(
        Placement(visible = true, transformation(origin = {-1, -61}, extent = {{-39, -39}, {39, 39}}, rotation = -90)));
      Translational.SinForce sinForce(F = 450) annotation(
        Placement(visible = true, transformation(origin = {-2, 64}, extent = {{-28, -28}, {28, 28}}, rotation = 90)));
    equation
      connect(pistonPumpTank.flange, sinForce.flange) annotation(
        Line(points = {{-2, -24}, {0, -24}, {0, 50}}));
    end PistonPumpTankForce;
  end HydroMec;

  package Rotational
    type Torque = Real(unit = "N.m");
    type Angle = Real(unit = "rad");
    type AngSpeed = Real(unit = "rad/s");

    connector Flange
      Angle th;
      flow Torque tau;
      annotation(
        Icon(graphics = {Ellipse(origin = {2, -1}, fillColor = {0, 85, 0}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-38, 37}, {38, -37}}, endAngle = 360), Ellipse(origin = {2, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-28, 27}, {28, -27}}, endAngle = 360)}));
    end Flange;

    model Inertia
      AngSpeed w;
      parameter Real J = 1;
      Rotational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {5, 13}, extent = {{-39, -39}, {39, 39}}, rotation = 0), iconTransformation(origin = {8, 10}, extent = {{-46, -46}, {46, 46}}, rotation = 0)));
    equation
      J * der(w) = flange.tau;
      der(flange.th) = w;
      annotation(
        Diagram(graphics = {Ellipse(origin = {-45, 12}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-37, 38}, {37, -38}}, endAngle = 360), Text(origin = {-46, 13}, extent = {{-26, 15}, {26, -15}}, textString = "Inertia")}),
        Icon(graphics = {Ellipse(origin = {-45, 12}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, lineThickness = 0.75, extent = {{-37, 38}, {37, -38}}, endAngle = 360), Text(origin = {-44, 14}, extent = {{-26, 12}, {26, -12}}, textString = "Inertia")}));
    end Inertia;

    model Friction
      AngSpeed w;
      parameter Real b = 1;
      Rotational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-8, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {54, 2}, extent = {{-46, -46}, {46, 46}}, rotation = 0)));
    equation
      flange.tau = b * w;
      der(flange.th) = w;
      annotation(
        Icon(graphics = {Line(origin = {11, -0.5}, points = {{25, 0.5}, {-25, 0.5}, {-25, 12.5}, {-25, -13.5}, {-25, 12.5}}, thickness = 1.25), Line(origin = {-21, 0}, points = {{1, 30}, {-19, 30}, {-19, -30}, {19, -30}, {19, -30}}, thickness = 1.25)}));
    end Friction;

    model ConstTorque
      parameter Torque Tau = 1;
      Rotational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-4, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {33, 3}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
    equation
      flange.tau = -Tau;
      annotation(
        Icon(graphics = {Line(origin = {-4.2, 9.65}, points = {{-37.7968, -33.648}, {-17.7968, -49.648}, {14.2032, -51.648}, {36.2032, -31.648}, {38.2032, 16.352}, {38.2032, 16.352}, {16.2032, 36.352}, {-23.7968, 26.352}, {-15.7968, 52.352}, {-23.7968, 26.352}, {2.20322, 12.352}}, thickness = 1.25)}));
    end ConstTorque;

    model FricInertia
      Rotational.Inertia inertia annotation(
        Placement(visible = true, transformation(origin = {-46, 10}, extent = {{-48, -48}, {48, 48}}, rotation = 0)));
      Rotational.Friction friction annotation(
        Placement(visible = true, transformation(origin = {27, 41}, extent = {{-43, -43}, {43, 43}}, rotation = 180)));
      Rotational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-41, -57}, extent = {{-21, -21}, {21, 21}}, rotation = 0), iconTransformation(origin = {-45, -1}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
    equation
      connect(friction.flange, inertia.flange) annotation(
        Line(points = {{4, 42}, {-42, 42}, {-42, 15}}));
      connect(flange, inertia.flange) annotation(
        Line(points = {{-40, -56}, {-42, -56}, {-42, 14}}));
      annotation(
        Icon(graphics = {Rectangle(fillColor = {0, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-40, 40}, {40, -40}}), Text(origin = {0, 2}, lineThickness = 0.5, extent = {{-46, 34}, {46, -34}}, textString = "FI")}));
    end FricInertia;

    model FricInertiaTau
      extends Rotational.FricInertia;
      Rotational.ConstTorque constTorque annotation(
        Placement(visible = true, transformation(origin = {25, -31}, extent = {{-59, 59}, {59, -59}}, rotation = 180)));
    equation
      connect(constTorque.flange, inertia.flange) annotation(
        Line(points = {{6, -30}, {-44, -30}, {-44, 0}}));
    end FricInertiaTau;
  end Rotational;
  
  package RotoTranslational
    model RodCrank
      Rotational.Flange flangerot annotation(
        Placement(visible = true, transformation(origin = {-50, 8}, extent = {{-46, -46}, {46, 46}}, rotation = 0), iconTransformation(origin = {-34, 22}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
      Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {44, 8}, extent = {{-38, -38}, {38, 38}}, rotation = 0), iconTransformation(origin = {-24, 66}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Translational.Force F;
      Translational.Position x;
      Rotational.Angle th;
      parameter Real r = 0.1;
      parameter Real l = 1;
      parameter Real x0 = (-r) - l;
    equation
      th = flangerot.th;
      x + x0 = flange.s;
      r ^ 2 + x ^ 2 = l ^ 2 + 2 * r * x * cos(th);
      flange.f = F * sqrt(1 - (r * sin(th) / l) ^ 2);
      flangerot.tau = r * x * sin(th) * F;
      annotation(
        Icon(graphics = {Ellipse(origin = {-34, 21}, lineThickness = 1, extent = {{-46, 45}, {46, -45}}, endAngle = 360), Line(origin = {31.6111, 49.8333}, points = {{-46, 13}, {46, -13}, {46, -13}}, thickness = 1), Line(origin = {-56, -18}, points = {{22, 40}, {-22, -40}}, thickness = 1)}));
    end RodCrank;
  
    model RodCrankMass
      RotoTranslational.RodCrank rodCrank annotation(
        Placement(visible = true, transformation(origin = {-5, 67}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
      Translational.SpringDamperMass springDamperMass annotation(
        Placement(visible = true, transformation(origin = {32, -7.10543e-15}, extent = {{-38, -38}, {38, 38}}, rotation = 0)));
      Rotational.Flange flangeRotational annotation(
        Placement(visible = true, transformation(origin = {-102, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -3.55271e-15}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
      Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    equation
    connect(rodCrank.flangerot, flangeRotational) annotation(
        Line(points = {{-15, 73}, {-81, 73}, {-81, -12}, {-102, -12}}));
    connect(springDamperMass.flange, rodCrank.flange) annotation(
        Line(points = {{14, 0}, {-13, 0}, {-13, 86}, {-12, 86}}));
      connect(springDamperMass.flange1, flange) annotation(
        Line(points = {{50, 0}, {100, 0}}));
    annotation(
        Icon(graphics = {Rectangle(origin = {0, -1}, fillColor = {143, 89, 2}, fillPattern = FillPattern.Solid, lineThickness = 1.25, extent = {{-98, 99}, {98, -99}}), Text(origin = {0, -1}, extent = {{-68, 27}, {68, -27}}, textString = "RodCrankMass")}));end RodCrankMass;
  
    model RodCrankMassTau
      extends RotoTranslational.RodCrankMass;
      Rotational.Inertia inertia annotation(
        Placement(visible = true, transformation(origin = {-84, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Rotational.ConstTorque constTorque(Tau = 0.5) annotation(
        Placement(visible = true, transformation(origin = {-88, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(inertia.flange, flangeRotational) annotation(
        Line(points = {{-84, 58}, {-102, 58}, {-102, -12}}));
      connect(constTorque.flange, flangeRotational) annotation(
        Line(points = {{-84, 82}, {-102, 82}, {-102, -12}}));
    end RodCrankMassTau;
  end RotoTranslational;

  package Electrical
    type Voltage = Real(unit = "V");
    type Current = Real(unit = "A");

    connector Pin
      Voltage v;
      //potencial
      flow Current i;
      //corriente
      annotation(
        Icon(graphics = {Ellipse(origin = {-1, 1}, fillColor = {0, 0, 208}, fillPattern = FillPattern.Solid, extent = {{-51, 53}, {51, -53}}, endAngle = 360)}));
    end Pin;

    partial model OnePort
      Electrical.Pin p annotation(
        Placement(visible = true, transformation(origin = {2, 96}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, 96}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
      Electrical.Pin n annotation(
        Placement(visible = true, transformation(origin = {2, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, -95}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
      Voltage v;
      Current i;
    equation
      v = p.v - n.v;
      i = p.i;
      i = -n.i;
      annotation(
        Icon(graphics = {Text(origin = {-113, 113}, extent = {{-37, 31}, {95, -91}}, textString = "+")}));
    end OnePort;

    model Resistor
      extends Electrical.OnePort;
      parameter Real R = 1;
    equation
      v = R * i;
      annotation(
        Icon(graphics = {Line(origin = {6.39, 3.36}, points = {{-6.3878, 80.6397}, {-6.3878, 50.6397}, {33.6122, 34.6397}, {-34.3878, 10.6397}, {31.6122, -15.3603}, {-34.3878, -37.3603}, {35.6122, -55.3603}, {-6.3878, -71.3603}, {-6.3878, -83.3603}, {-4.3878, -81.3603}}, thickness = 1.5), Text(origin = {82, -6}, extent = {{-56, 44}, {40, -34}}, textString = "R")}, coordinateSystem(initialScale = 0.1)));
    end Resistor;

    model Capacitor
      extends Electrical.OnePort;
      parameter Real C = 1;
    equation
      C * der(v) = i;
      annotation(
        Icon(graphics = {Line(origin = {-2, 61}, points = {{0, 23}, {0, -15}, {0, -23}}), Line(origin = {12, 40}, points = {{-58, 0}, {44, 0}, {58, 0}}), Line(origin = {12, -20}, points = {{-52, 0}, {52, 0}}), Line(origin = {0, -47}, points = {{0, 25}, {0, -25}, {0, -25}})}));
    end Capacitor;

    model Ground
      Electrical.Pin p annotation(
        Placement(visible = true, transformation(origin = {-2, 90}, extent = {{-36, -36}, {36, 36}}, rotation = 0), iconTransformation(origin = {-2, 90}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
    equation
      p.v = 0;
      annotation(
        Icon(graphics = {Line(origin = {-1.5, 54}, points = {{-0.5, 16}, {-0.5, -16}, {39.5, -16}, {-38.5, -16}, {-38.5, -16}}), Line(origin = {-2, 32}, points = {{-22, 0}, {22, 0}, {22, 0}}), Line(origin = {-2, 24}, points = {{-14, 0}, {14, 0}})}));
    end Ground;

    model RC
      Resistor Res(R = 0.2) annotation(
        Placement(visible = true, transformation(origin = {-60, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Capacitor Cap(v(start = 1)) annotation(
        Placement(visible = true, transformation(origin = {-14, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Ground G annotation(
        Placement(visible = true, transformation(origin = {-36, -18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(Res.p, Cap.p) annotation(
        Line(points = {{-60, 32}, {-14, 32}, {-14, 32}, {-14, 32}}));
      connect(Res.n, G.p) annotation(
        Line(points = {{-60, 12}, {-36, 12}, {-36, -8}, {-36, -8}}));
      connect(Cap.n, G.p) annotation(
        Line(points = {{-14, 12}, {-36, 12}, {-36, -8}, {-36, -8}}));
    end RC;

    model Inductor
      extends Electrical.OnePort;
      parameter Real L = 1;
    equation
      L * der(i) = v;
      annotation(
        Icon(graphics = {Rectangle(origin = {2, -1}, lineThickness = 2, extent = {{-54, 89}, {46, -83}})}));
    end Inductor;

    model RLC
      Electrical.Resistor resistor annotation(
        Placement(visible = true, transformation(origin = {12, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Capacitor capacitor(v(start = 1)) annotation(
        Placement(visible = true, transformation(origin = {-42, 26}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Electrical.Inductor inductor annotation(
        Placement(visible = true, transformation(origin = {-24, 62}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Ground ground annotation(
        Placement(visible = true, transformation(origin = {-14, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(capacitor.p, inductor.n) annotation(
        Line(points = {{-42, 36}, {-42, 62}, {-34, 62}}));
      connect(inductor.p, resistor.p) annotation(
        Line(points = {{-14, 62}, {12, 62}, {12, 36}}));
      connect(resistor.n, ground.p) annotation(
        Line(points = {{12, 16}, {-14, 16}, {-14, 2}}));
      connect(capacitor.n, ground.p) annotation(
        Line(points = {{-42, 16}, {-14, 16}, {-14, 2}, {-14, 2}}));
    end RLC;

    model RCNetwork
      constant Integer N = 10;
      Inductor ind(i.start = 1);
      Resistor res[N];
      Capacitor cap[N];
      Ground gr;
    equation
      connect(ind.n, res[1].p);
      connect(ind.p, gr.p);
      for i in 1:N loop
        connect(res[i].n, cap[i].p);
        connect(cap[i].n, gr.p);
      end for;
      for i in 2:N loop
        connect(res[i].p, res[i - 1].n);
      end for;
    end RCNetwork;

    model ConstVoltage
      extends Electrical.OnePort;
    equation
      v = 12;
    end ConstVoltage;

    model RLOpen
      Electrical.ConstVoltage constVoltage annotation(
        Placement(visible = true, transformation(origin = {-60, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Electrical.Resistor resistor annotation(
        Placement(visible = true, transformation(origin = {10, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Electrical.Ground ground annotation(
        Placement(visible = true, transformation(origin = {100, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Electrical.Inductor inductor(L = 0.001) annotation(
        Placement(visible = true, transformation(origin = {92, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Electrical.Pin pinA annotation(
        Placement(visible = true, transformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Electrical.Pin pinB annotation(
        Placement(visible = true, transformation(origin = {100, -62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(inductor.n, pinA);
      connect(ground.p, pinB);
      connect(resistor.n, inductor.p) annotation(
        Line(points = {{19.5, 60}, {82, 60}}));
      connect(constVoltage.p, resistor.p) annotation(
        Line(points = {{-60, 20}, {-60, 60}, {0, 60}}));
      connect(ground.p, constVoltage.n) annotation(
        Line(points = {{100, -60}, {-60, -60}, {-60, 0.5}}));
    protected
    end RLOpen;

    model RL
      Electrical.RLOpen rLOpen annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(rLOpen.pinA, rLOpen.pinB) annotation(
        Line(points = {{10, 6}, {30, 6}, {30, -6}, {10, -6}}));
    end RL;
  end Electrical;

  package ElectroMec
    model ElMecConv
      extends Electrical.OnePort;
      Rotational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 2}, extent = {{-48, -48}, {48, 48}}, rotation = 0)));
      Rotational.AngSpeed w;
      parameter Real K = 1;
    equation
      flange.tau = -K * i;
      v = K * w;
      der(flange.th) = w;
    end ElMecConv;

    model DCMotor
      Electrical.RLOpen rLOpen annotation(
        Placement(visible = true, transformation(origin = {-40, -6.66134e-16}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
      Rotational.FricInertia fricInertia annotation(
        Placement(visible = true, transformation(origin = {87, -3}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
      ElectroMec.ElMecConv elMecConv annotation(
        Placement(visible = true, transformation(origin = {24, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Rotational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {74, -52}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {-93, -1}, extent = {{-49, -49}, {49, 49}}, rotation = 0)));
    equation
      connect(rLOpen.pinA, elMecConv.p) annotation(
        Line(points = {{-24, 10}, {24, 10}}));
      connect(elMecConv.n, rLOpen.pinB) annotation(
        Line(points = {{24, -9.5}, {-2, -9.5}, {-2, -10}, {-24, -10}}));
      connect(elMecConv.flange, fricInertia.flange) annotation(
        Line(points = {{34, 0}, {50, 0}, {50, -3}, {74, -3}}));
      connect(flange, fricInertia.flange) annotation(
        Line(points = {{74, -52}, {74, -4}}));
      annotation(
        Icon(graphics = {Rectangle(origin = {3, 0}, fillColor = {233, 185, 110}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-91, 96}, {91, -96}}), Text(origin = {10, 2}, extent = {{-54, 46}, {54, -46}}, textString = "DCMotor")}));
    end DCMotor;
  end ElectroMec;
end TP;