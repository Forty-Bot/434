% a

% df/dx = 2y(x + 2)
% df/dy = (x + 2)^2 - 3y^2
% dg/dx = 4x^3
% dg/dy = 128y^3

% at (0, 0), we find
% df/dx = 0
% df/dy = 4
% dg/dx = 0
% dg/dy = 0
% which is a matrix with determinant 0 (and hence no inverse)

% Newton's method assumes the Jacobian has an inverse,
% so this guess will not converge.

% b
tol = 1e-6;

function ret = F(x)
  ret(1, 1) = x(2) * (x(1) + 2)^2 - x(2)^3 - 4; 
  ret(2, 1) = x(1)^4 + 32 * x(2)^4 - 81;
endfunction

function ret = J(x)
  ret(1, 1) = 2 * x(2) * (x(1) + 2);
  ret(1, 2) = (x(1) + 2)^2 - 3 * x(2)^2;
  ret(2, 1) = 4 * x(1)^3;
  ret(2, 2) = 128 * x(2)^3;
endfunction

function x = solve1(x, tol)
  do
    diff = J(x) \ -F(x);
    x = x + diff;
  until norm(diff, inf) < tol
endfunction

sol1 = solve1([3; 1], tol)
sol2 = solve1([1; 3], tol)

% c
function color = solve2(x, sol1, sol2, tol, max)
  iter = 0;
  do
    diff = J(x) \ -F(x);
    x = x + diff;
    conv1 = norm(x - sol1, inf) < tol;
    conv2 = norm(x - sol2, inf) < tol;
    iter = iter + 1;
  until conv1 || conv2 || iter >= max;

  if conv1
    color = 1;
  elseif conv2
    color = 2;
  else
    color = 0;
  endif
endfunction

n = 100;
max_iters = 100;
[X, Y] = meshgrid(linspace(0, 4, n), linspace(0, 4, n));
Z = arrayfun(@(x, y) solve2([x; y], sol1, sol2, tol, max_iters), X, Y);
contourf(X, Y, Z);