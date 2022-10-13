model discreteSEIRRE
  parameter Real alpha=1; 
  parameter Real gamma=0.5; 
  parameter Real poblacion=1e6;   
  parameter Integer TI = 3;
  parameter Integer TR = 12;
  parameter Real R0 = 1.5;
  discrete Real S(start=poblacion-10);
  discrete Real E;
  discrete Real I(start=10);
  discrete Real R;  
  discrete Real N[TR];  
  algorithm
   when sample(0,1) then 
          N[1]:= R0/(TR-TI)*pre(I)*pre(S)/poblacion;
          S:=pre(S)-N[1];
          E:=pre(E)+N[1]-N[TI];
          I:=pre(I)+N[TI]-N[TR];
          R:=pre(R)+N[TR]; 
          for k in 0:(TR-2) loop
              N[TR-k]:=N[TR-(k+1)];          
          end for;
                   
   end when;  
annotation(
    Diagram(graphics = {Rectangle(origin = {-61, 43}, extent = {{-7, 9}, {7, -9}})}));
end discreteSEIRRE;