model ej8
  parameter Real alpha = 1;
  parameter Real gamma = 0.5;
  parameter Real N = 1e6;
  parameter Real m = 0.01;
  parameter Real I0 = 10;
Modelica.Blocks.Discrete.UnitDelay S(samplePeriod = 1, y_start = 1e6)  annotation(
    Placement(visible = true, transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Discrete.UnitDelay I(samplePeriod = 1, y_start = I0)  annotation(
    Placement(visible = true, transformation(origin = {70, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Discrete.UnitDelay R(samplePeriod = 1)  annotation(
    Placement(visible = true, transformation(origin = {50, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Math.Add add(k2 = -alpha / N)  annotation(
    Placement(visible = true, transformation(origin = {-8, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-74, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Math.Add add1(k1 = alpha / N, k2 = 1 - gamma)  annotation(
    Placement(visible = true, transformation(origin = {-8, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Math.Add add2(k1 = gamma)  annotation(
    Placement(visible = true, transformation(origin = {-10, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealInput imp annotation(
    Placement(visible = true, transformation(origin = {-156, 76}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
Modelica.Blocks.Interfaces.RealOutput exp annotation(
    Placement(visible = true, transformation(origin = {154, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Math.Add add4(k1 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-70, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Math.Gain gain1(k = m)  annotation(
    Placement(visible = true, transformation(origin = {116, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Math.Add add3 annotation(
    Placement(visible = true, transformation(origin = {34, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(add.y, S.u) annotation(
    Line(points = {{4, 50}, {38, 50}}, color = {0, 0, 127}));
  connect(add2.y, R.u) annotation(
    Line(points = {{2, -32}, {38, -32}}, color = {0, 0, 127}));
  connect(product.y, add.u2) annotation(
    Line(points = {{-62, 8}, {-44, 8}, {-44, 44}, {-20, 44}}, color = {0, 0, 127}));
  connect(S.y, add.u1) annotation(
    Line(points = {{62, 50}, {78, 50}, {78, 82}, {-42, 82}, {-42, 56}, {-20, 56}}, color = {0, 0, 127}));
  connect(S.y, product.u1) annotation(
    Line(points = {{62, 50}, {78, 50}, {78, 82}, {-98, 82}, {-98, 14}, {-86, 14}}, color = {0, 0, 127}));
  connect(product.y, add1.u1) annotation(
    Line(points = {{-62, 8}, {-20, 8}}, color = {0, 0, 127}));
connect(I.y, add2.u1) annotation(
    Line(points = {{81, 8}, {84, 8}, {84, -12}, {-42, -12}, {-42, -26}, {-22, -26}}, color = {0, 0, 127}));
  connect(R.y, add2.u2) annotation(
    Line(points = {{62, -32}, {70, -32}, {70, -52}, {-44, -52}, {-44, -38}, {-22, -38}}, color = {0, 0, 127}));
connect(I.y, product.u2) annotation(
    Line(points = {{81, 8}, {84, 8}, {84, -12}, {-98, -12}, {-98, 2}, {-86, 2}}, color = {0, 0, 127}));
connect(I.y, add1.u2) annotation(
    Line(points = {{81, 8}, {84, 8}, {84, -12}, {-42, -12}, {-42, -4}, {-20, -4}}, color = {0, 0, 127}));
  connect(exp, add4.u1) annotation(
    Line(points = {{154, 56}, {154, 100}, {-106, 100}, {-106, 62}, {-82, 62}}, color = {0, 0, 127}));
  connect(imp, add4.u2) annotation(
    Line(points = {{-156, 76}, {-106, 76}, {-106, 50}, {-82, 50}}, color = {0, 0, 127}));
connect(I.y, gain1.u) annotation(
    Line(points = {{81, 8}, {84, 8}, {84, 56}, {104, 56}}, color = {0, 0, 127}));
  connect(gain1.y, exp) annotation(
    Line(points = {{127, 56}, {154, 56}}, color = {0, 0, 127}));
connect(add1.y, add3.u2) annotation(
    Line(points = {{4, 2}, {22, 2}}, color = {0, 0, 127}));
connect(add3.y, I.u) annotation(
    Line(points = {{45, 8}, {58, 8}}, color = {0, 0, 127}));
connect(add4.y, add3.u1) annotation(
    Line(points = {{-58, 56}, {-48, 56}, {-48, 20}, {10, 20}, {10, 14}, {22, 14}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {11, 5}, extent = {{-65, 29}, {65, -29}}, textString = "SIR")}));
    end ej8;
