function y = NestedEval(a, x)
  y = zeros(size(x));
  for i = 1:length(a)
    y = y .* x + a(i);
  endfor
endfunction