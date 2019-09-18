% 1
epsilon = 5e-11;

% Bisection
function y = f(x)
  y = exp(x) + 7 .* x - 7;
endfunction

l = 0; u = 1; m = 0.5;
bi_count = ceil(log2((u - l)/epsilon))
bi_guesses = zeros(1, bi_count);

for i = 1:bi_count
  m = (u - l) / 2 + l;
  bi_guesses(i) = m;
  if f(m) > 0
    u = m;
  else
    l = m;
  endif
endfor

figure(1);
semilogy(1:bi_count, relerr(bi_guesses(bi_count), bi_guesses), ";bisection;");
hold on;

% Newton's method
function dy = df(x)
  dy = exp(x) + 7;
endfunction

newton_guesses = newton(@f, @df, 0.5, epsilon);
i = newton_count = length(newton_guesses);
semilogy(1:i, relerr(newton_guesses(i), newton_guesses), ";newton;");

% Fixed-point
function y = g(x)
  y = 1 - exp(x) ./ 7;
endfunction

fixed_guesses = fixed(@g, 0.5, epsilon);
i = length(fixed_guesses);
fixed_count = i - 1
semilogy(1:i, relerr(fixed_guesses(i), fixed_guesses), ";fixed;");

% Secant
x = newton_guesses(2); x1 = x0 = 0.5;
fx0 = 0;
fx1 = f(x1);
i = 2; error_guess = Inf;
secant_guesses = {x0};
while error_guess > epsilon
  x0 = x1; fx0 = fx1;
  x1 = x; fx1 = f(x);
  secant_guesses{i} = x1;
  x = x1 - fx1 * (x1 - x0) / (fx1 - fx0);
  error_guess = abs(x - x1);
  i = i + 1;
endwhile
secant_guesses(i) = x;

secant_guesses = cell2mat(secant_guesses);
secant_count = i - 2
semilogy(1:i, relerr(secant_guesses(i), secant_guesses), ";secant;");
hold off;

% 3
% a
function y = h(x)
  y = x .^ 2 + 2 .* cos(x) - 2;
endfunction

function dy = dh(x)
  dy = 2 .* x - 2 .* sin(x);
endfunction

guesses1 = newton(@h, @dh, 1, 5e-9);

% b
% h(0) = 0^2 + 2cos(0) - 2 = 0 + 2 - 2 = 0
% Dh(0) = 2*0 - 2sin(0) = 0 - 0
% D^2h(0) = 0 - 2cos(0) = 2 - 2 = 0
% D^3h(0) = 2sin(0) = 0
% D^4h(0) = 2cos(0) = 2
% therefore the multiplicity is 4

% c
guesses2 = newton(@(x) 4.*h(x), @dh, 1, 5e-9);

% d
figure(3)
semilogy(1:length(guesses1), abs(guesses1), 1:length(guesses2), abs(guesses2));

% 4
% a
% 0 = (1 - 3/(4x))^1/3
% 0 = 1 - 3/(4x)
% 1 = 3/4(x)
% 4x = 3
% x = 3/4

% b
function y = e(x)
  y = cbrt(1 - 3 ./ (4 .* x));
endfunction

function dy = de(x)
  dy = 1 / (4 * x ^ 2 * (cbrt(1 - 3 / (4 * x)))^2);
endfunction

x = 0.5 .* ones(1, 50);
for i = 2:50
  x(i) = x(i-1) - e(x(i-1))/de(x(i-1));
endfor
figure(4);
semilogy(1:50, abs(x));

% c
% de(.75) is undefined, so the derivitive is not twice continuously differentiable

% 5
% a
% i
% (4 + 4 + 3 + 2 + 1) + 5 = 19

% ii
% 4 + 5 = 9

% b
% coefficients for g(x) from the problem
a = [1 -12 50 -88 0 -20] ./ -69;

% i
guesses3 = fixed(@(x) polyval(a, x), 4.1, 5e-7);
length(guesses3)

% ii
da = polyder(a);
da4 = abs(polyval(da, 4)) % > 1
da5 = abs(polyval(da, 5)) % < 1
% therefore 5 is an attractor while 4 is a repellor

% iii
guesses4 = fixed(@(x) polyval(a, x), 3.9, 5e-7);
count = length(guesses4)
error = guesses4(count) - 1 % Which is much larger than our epsilon
da1 = abs(polyval(da, 1)) % == 1
% because the derivative at 1 is 1, so there are no strong guarantees on the
% convergence