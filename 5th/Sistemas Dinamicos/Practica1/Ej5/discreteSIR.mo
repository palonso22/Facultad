model discreteSIR
  discrete Real S(start=N-10);
  discrete Real I(start=10);
  discrete Real R;  
  parameter Real alpha=1; 
  parameter Real gamma=0.5; 
  parameter Real N=1e6; 
  algorithm
   when sample(0,1) then 
          S:=pre(S)-alpha*pre(S)*pre(I)/N;
          I:=pre(I)+alpha*pre(S)*pre(I)/N-gamma*pre(I);
          R:=pre(R)+gamma*pre(I);
   end when;  
end discreteSIR;