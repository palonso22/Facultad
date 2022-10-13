package Mecs2D
  type Acceleration=Real(unit="m/s/s");
  type Velocity=Real(unit="m/s");
  type Position=Real(unit="m");
  type Force=Real(unit="N");
  type Length=Real(unit="m");
  type Distance=Real(unit="m");
  type Mass=Real(unit="Kg");
  type Acceleration2D=Acceleration[2];
  type Velocity2D=Velocity[2];
  type Position2D=Position[2];
  type Force2D=Force[2];
  
  connector Flange2D
    Position2D s;
    flow Force2D f;
  end Flange2D;
  
  model Fixed2D
    Flange2D flange_a;
    parameter Position2D s0={0,0};
    equation 
      flange_a.s=s0;
  end Fixed2D;
  
  
  model PointMass2D
    Flange2D flange_a; 
    Position2D s;
    Velocity2D v;
    parameter Mass m=1;
    equation
      flange_a.f=m*der(v);
      der(s)=v;
      s=flange_a.s;
  end PointMass2D;   
  
  
  partial model Compliant2D
     Flange2D flange_a;
     Flange2D flange_b;
     Length s_rel;
     Force f;
     Force2D f2;
     equation
        s_rel=sqrt((flange_b.s[1]-flange_a.s[1])^2+(flange_b.s[2]-flange_a.s[2])^2);
        f2[1]=f*(flange_b.s[1]-flange_a.s[1])/s_rel;
        f2[2]=f*(flange_b.s[2]-flange_a.s[2])/s_rel;
        flange_a.f=-f2;
        flange_b.f=f2;
  end Compliant2D;


  model Spring2D
     extends Compliant2D;
     parameter Length s_rel0=0;
     parameter Real k(unit="N/m")=1;
     equation
        f=k*(s_rel-s_rel0);        
     end Spring2D;
 
 model Damper2D
     extends Compliant2D;
     parameter Real b(unit="N.s/m")=1;
     equation
        f=b*der(s_rel);
 end Damper2D; 
 
 
 model ConstForce2D
    Flange2D flange_a;
    parameter Force2D F={1,1};
    equation
       flange_a.f=-F;
 end ConstForce2D;
 
 model Bar2D 
    extends Compliant2D;
    parameter Length L=1;
 equation 
    s_rel=1;
 end Bar2D;
 
 
 
 model Pendulum
   Fixed2D F;
   PointMass2D M(s(start={2,-10}));
   ConstForce2D G(F={0,-9.8});
   Bar2D B(L=10.2);
   equation
     connect(F.flange_a,B.flange_b);
     connect(B.flange_a,M.flange_a);
     connect(G.flange_a,M.flange_a);
end Pendulum;

model Pendulumb
   Fixed2D F;
   PointMass2D M(s(start={2,-10}));
   ConstForce2D G(F={0,-9.8});
   Spring2D S(s_rel0=10,k=10);
   Damper2D D;
   equation
      connect(F.flange_a,S.flange_b);
      connect(S.flange_a,M.flange_a);
      connect(G.flange_a,M.flange_a);
      connect(F.flange_a,D.flange_a);
      connect(D.flange_b,M.flange_a);
end Pendulumb;
    
 

end Mecs2D;