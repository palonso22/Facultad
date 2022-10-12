function r=raicesChebyshev(n)
    /*Calcula las raices del polinomio de chebyshev
    Entrada:
          -n: grado del polinomio de chebyshev
    Salidaa:
          -r: un vector con las raices de Tn
    */
    if n==0 then
        r=[]
    end
    p0=1
    p1=poly([0 1],'x','c')   
    pn=p1
    for i=2:n        
        p2=poly([0 2],'x','c')
        pn=p2*p1-p0
        p0=p1
        p1=pn                            
    end
    r=roots(pn)    
endfunction
