package CircuitosG

  type Voltage = Real(unit="V");
  type Current = Real(unit="A");
  connector Pin
    Voltage v;
    //Potencial
    flow Real i;
    // Corriente
    annotation(
      Icon(graphics = {Ellipse(origin = {2, 1}, fillColor = {52, 101, 164}, fillPattern = FillPattern.Solid, extent = {{-60, 47}, {60, -47}}, endAngle = 360)}));
  end Pin;

  partial model onePort
    CircuitosG.Pin p annotation(
      Placement(visible = true, transformation(origin = {0, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, 95}, extent = {{-23, -23}, {23, 23}}, rotation = 0)));
  CircuitosG.Pin n annotation(
      Placement(visible = true, transformation(origin = {-2, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1, -89}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
    Voltage u;
    Current i;  
    equation 
    u = p.v-n.v;
    i=p.i;
    p.i+n.i=0;
  annotation(
      Diagram,
      Icon(graphics = {Text(origin = {-50, 80}, lineThickness = 5, extent = {{-40, 28}, {40, -28}}, textString = "+")}));
  end onePort;

  model Resistor
    extends CircuitosG.onePort;
    parameter Real R=1;
  equation
    u=R*i;

  annotation(
      Icon(graphics = {Line(origin = {9.39, -0.97}, points = {{-9.39151, 88.9692}, {-9.39151, 60.9692}, {10.6085, 40.9692}, {-27.3915, 20.9692}, {10.6085, 0.969172}, {-29.3915, -19.0308}, {8.60849, -37.0308}, {-29.3915, -59.0308}, {-9.39151, -65.0308}, {-9.39151, -89.0308}, {-9.3915, -93.0308}}, thickness = 1.5)}));end Resistor;

  model Capacitor
    extends CircuitosG.onePort;
    parameter Real C=1;
    equation      
      C*der(u)=i;

  annotation(
      Icon(graphics = {Line(origin = {0, 71.5}, points = {{0, 18.5}, {0, -19.5}, {0, -17.5}}), Line(origin = {-0.5, 54}, points = {{-37.5, 0}, {38.5, 0}, {32.5, 0}}), Line(origin = {0, -65.5}, points = {{0, -24.5}, {0, 25.5}, {0, 15.5}}), Line(origin = {0, -40}, points = {{-40, 0}, {40, 0}})}));end Capacitor;

  model Ground
  CircuitosG.Pin p annotation(
      Placement(visible = true, transformation(origin = {0, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {4, 94}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    p.v=0;

  annotation(
      Icon(graphics = {Line(origin = {1, 73}, points = {{3, 17}, {3, -17}, {37, -17}, {-37, -17}, {-25, -17}}), Line(origin = {9, 40}, points = {{-23, 0}, {23, 0}, {23, 0}}), Line(origin = {9, 20}, points = {{-13, 0}, {13, 0}, {13, 0}})}));end Ground;

  model RC
  CircuitosG.Resistor Res(R = 0.2)  annotation(
      Placement(visible = true, transformation(origin = {-50, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Capacitor Cap(u(start = 1))  annotation(
      Placement(visible = true, transformation(origin = {46, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Ground G annotation(
      Placement(visible = true, transformation(origin = {0, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(Res.p, Cap.p) annotation(
      Line(points = {{-50, 32}, {46, 32}}));
  connect(Res.n, G.p) annotation(
      Line(points = {{-50, 12}, {0, 12}, {0, -14}}));
  connect(Cap.n, G.p) annotation(
      Line(points = {{46, 12}, {0, 12}, {0, -14}}));
  end RC;

  model Inductor
    extends CircuitosG.onePort;
    parameter Real L=1;
  equation
    L*der(i)=u;
  annotation(
      Icon(graphics = {Rectangle(origin = {-1, 3}, lineThickness = 2, extent = {{-61, 91}, {61, -91}})}));end Inductor;

  model RLC
  CircuitosG.Resistor resistor annotation(
      Placement(visible = true, transformation(origin = {42, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Capacitor capacitor(u(start = 1))  annotation(
      Placement(visible = true, transformation(origin = {-40, 18}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  CircuitosG.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-4, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  CircuitosG.Inductor inductor annotation(
      Placement(visible = true, transformation(origin = {-2, 56}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  equation
    connect(capacitor.p, inductor.n) annotation(
      Line(points = {{-40, 28}, {-10, 28}, {-10, 56}}));
  connect(resistor.p, inductor.p) annotation(
      Line(points = {{42, 29.5}, {8, 29.5}, {8, 56}}));
  connect(capacitor.n, ground.p) annotation(
      Line(points = {{-40, 10}, {-4, 10}, {-4, 4}}));
  connect(resistor.n, ground.p) annotation(
      Line(points = {{42, 11}, {-4, 11}, {-4, 4}}));
  end RLC;
  annotation(
    Icon(graphics = {Ellipse(extent = {{-22, 24}, {-22, 24}}, endAngle = 360)}, coordinateSystem(preserveAspectRatio = true)),
    Diagram(coordinateSystem(preserveAspectRatio = true)),
    version = "",
    uses);
  
  model RCNetwork
  constant Integer N=10;
  Inductor ind(i.start=1);
  Resistor res[N];
  Capacitor cap[N];
  Ground gr;
  equation
     connect(ind.n,res[1].p);
     connect(ind.p,gr.p);
     for i in 1:N loop
        connect(res[i].n,cap[i].p);
        connect(cap[i].n,gr.p);
     end for;
     for i in 2:N loop
       connect(res[i].p,res[i-1].n);
     end for; 
  end RCNetwork;





end CircuitosG;