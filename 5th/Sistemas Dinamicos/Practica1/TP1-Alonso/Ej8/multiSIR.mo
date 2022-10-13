model multiSIR
  ej8 poblacion1 annotation(
    Placement(visible = true, transformation(origin = {-44, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ej8 poblacion2(I0 = 0)  annotation(
    Placement(visible = true, transformation(origin = {28, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(poblacion1.exp, poblacion2.imp) annotation(
    Line(points = {{-34, -12}, {18, -12}}, color = {0, 0, 127}));
  connect(poblacion2.exp, poblacion1.imp) annotation(
    Line(points = {{38, -12}, {46, -12}, {46, -50}, {-76, -50}, {-76, -12}, {-54, -12}}, color = {0, 0, 127}));
end multiSIR;