model multiSIR2poblaciones
   discreteSIRimp M[2];
   initial algorithm
   M[2].I:=0;M[2].S:=1e6;
   algorithm
     when sample(0,1) then 
      M[1].imp := M[2].exp;
      M[2].imp := M[1].exp;
     end when;
end multiSIR2poblaciones;