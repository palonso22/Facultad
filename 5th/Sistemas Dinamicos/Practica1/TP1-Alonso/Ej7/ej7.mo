model ej7
  parameter Real alpha = 1;
  parameter Real gamma = 0.5;
  parameter Real N = 1e6;
  Modelica.Blocks.Discrete.UnitDelay S(samplePeriod = 1, y_start = 1e6)  annotation(
    Placement(visible = true, transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Discrete.UnitDelay I(samplePeriod = 1, y_start = 10)  annotation(
    Placement(visible = true, transformation(origin = {64, 12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
equation
  connect(add.y, S.u) annotation(
    Line(points = {{4, 50}, {38, 50}}, color = {0, 0, 127}));
connect(add1.y, I.u) annotation(
    Line(points = {{3, 2}, {35.5, 2}, {35.5, 12}, {52, 12}}, color = {0, 0, 127}));
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
    Line(points = {{76, 12}, {84, 12}, {84, -12}, {-42, -12}, {-42, -26}, {-22, -26}}, color = {0, 0, 127}));
connect(R.y, add2.u2) annotation(
    Line(points = {{62, -32}, {70, -32}, {70, -52}, {-44, -52}, {-44, -38}, {-22, -38}}, color = {0, 0, 127}));
connect(I.y, product.u2) annotation(
    Line(points = {{76, 12}, {84, 12}, {84, -12}, {-98, -12}, {-98, 2}, {-86, 2}}, color = {0, 0, 127}));
connect(I.y, add1.u2) annotation(
    Line(points = {{76, 12}, {84, 12}, {84, -12}, {-42, -12}, {-42, -4}, {-20, -4}}, color = {0, 0, 127}));
end ej7;
