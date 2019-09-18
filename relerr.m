function err = relerr(real, approx)
  err = abs((real - approx) ./ real);
endfunction