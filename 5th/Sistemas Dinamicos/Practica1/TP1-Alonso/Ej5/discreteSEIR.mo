model discreteSEIR
  discrete Real S(start=N-10);
  discrete Real E;
  discrete Real I(start=10);
  discrete Real R;    
  parameter Real alpha=1; 
  parameter Real gamma=0.5; 
  parameter Real N=1e6; 
  parameter Real mu=0.5;
  algorithm
  when sample(0,1) then 
          S:=pre(S)-alpha*pre(S)*pre(I)/N;
          E:=pre(E)+alpha*pre(S)*pre(I)/N-mu*pre(E);
          I:=pre(I)+mu*pre(E)-gamma*pre(I);
          R:=pre(R)+gamma*pre(I);
  end when;  


end discreteSEIR;