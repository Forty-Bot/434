% 1
p = [1 3 -5 9 -8 9];
NestedEval(p, 2)

% 2.a
deriv = [2 1 -2 -1];
order = 6;
% NestedEval uses the length of the vector to determine the order of the
% polynomial, so we can't just pass in a matrix. This incantation will create
% a cell to hold vectors of coefficients.
coeff = cellslices(repmat(deriv, 1, order)(1:order) ./ factorial(0:(order-1)),
                   ones(1, order),
                   1:order);
% The coefficients are backwards (constant term first), so we need to flip them.
coeff = cellfun(@flip, coeff, "UniformOutput", false)

% 2.b
% Helper function to evaluate functions on cells and then shove the output back
% into a matrix
function ret = eval_cell(func, cell, size)
  ret = reshape(cell2mat(cellfun(func, cell, "UniformOutput", false)), size);
endfunction

samples = 512;
x = linspace(-pi, pi, samples);
y = eval_cell(@(a) NestedEval(a, x), coeff, [samples, order]);
real_y = sin(x) + 2 * cos(x);
figure(1)
plot1 = plot(x, [y, real_y']);
legend(plot1, [num2str((1:order)'); "inf"]);
grid("on");

% 2.c
function err = relerr(real, approx)
  err = abs((real - approx) ./ real);
endfunction

x2 = [.1 .5];
real_y2 = sin(x2) + 2 * cos(x2);
y2 = eval_cell(@(a) relerr(real_y2, NestedEval(a, x2)),
               coeff,
               [length(x2) order]);
figure(2)
plot2 = semilogy(1:order, y2');
legend(plot2, num2str(x2'));
grid("on");

% bonus:
y = eval_cell(@(a) relerr(real_y, NestedEval(a, x)), coeff, [length(x), order]);
figure(3)
plot3 = semilogy(x, y);
legend(plot3, num2str((1:order)'));
grid("on");