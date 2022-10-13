function res = iterator(f)
  res = 0
  for k=1:5
    res = feval(f,res) 
  endfor
endfunction
