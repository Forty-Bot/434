load hw3_1_data

% a
dim = length(b);
L = eye(dim);
U = A;
for j = 1:dim
  for i = (j + 1):dim
    L(i, j) = U(i, j) / U(j, j);
    U(i, :) = U(i, :) - U(j, :) * L(i, j);
    endfor
endfor

L
U

% b
y = x = zeros(size(b));
for i = 1:dim
  y(i) = b(i) - L(i, 1:(i-1)) * y(1:(i-1));
endfor
for i = dim:-1:1
  x(i) = (y(i) - U(i, (i+1):dim) * x((i+1):dim)) / U(i, i);
endfor
x