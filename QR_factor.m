% QR decomposition using the modified Gram-Schmidt process
function [Q R] = QR_factor(A)
  % Project u onto v
  function ret = proj(u, v)
    ret = (u' * v)/(v' * v)*v;
  endfunction

  n = size(A, 1);
  m = size(A, 2);
  Q = zeros(n, n);
  R = zeros(n, m);
  
  for i = 1:m
    u = A(:, i);
    for j = 1:(i - 1)
      u = u - proj(u, Q(:,j));
    endfor
    Q(:,i) = u / sqrt(u' * u);
  endfor
  
  for i = 1:m
    for j = i:m
      R(i, j) = Q(:,i)' * A(:,j);
    endfor
  endfor
endfunction
