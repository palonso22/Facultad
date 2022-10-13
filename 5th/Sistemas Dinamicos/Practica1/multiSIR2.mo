model multiSIR2
discreteSIRimp M[3];
   initial algorithm
   algorithm
     when sample(0,1) then 
      M[1].imp := M[2].exp/2;
      M[2].imp := M[1].exp;
      M[3].imp := M[2].exp/2;
     end when;
end multiSIR2;