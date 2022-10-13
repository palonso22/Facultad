model multiSIR3poblaciones
   discreteSIRimp M[3];
   initial algorithm
   M[2].I:=0;M[2].S:=1e6;
   M[3].I:=0;M[3].S:=1e6;
   algorithm
     when sample(0,1) then 
      M[1].imp := pre(M[2].exp)/2;
      M[2].imp := pre(M[1].exp)+pre(M[3].exp);      
      M[3].imp := pre(M[2].exp)/2;
     end when;
end multiSIR3poblaciones;