% a
dim = 100;
tol = 1e-4;
x = zeros(dim, 1);
x_true = ones(dim, 1);
hold on;
error = 0;
iter = 0;
do
  iter = iter + 1;
  x_old = x;
  x(1) = (1 + x_old(2)) / 2;
  for i = 2:(dim - 1)
    x(i) = (x_old(i - 1) + x_old(i + 1)) / 2;
  endfor
  x(dim) = (1 + x_old(dim - 1)) / 2;
  error = norm(x - x_true, inf);
  semilogy(iter, error);
until false

% b
iter = 0;
do
  iter = iter + 1;
  x(1) = (1 + x(2)) / 2;
  for i = 2:(dim - 1)
    x(i) = (x(i - 1) + x(i + 1)) / 2;
  endfor
  x(dim) = (1 + x(dim - 1)) / 2;
  error = norm(x - x_true, inf);
  semilogy(iter, error);
until error < tol
hold off;