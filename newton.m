function guesses = newton(f, df, x0, epsilon)
  x = x0; i = 1; error_guess = Inf;
  guesses = {};
  while error_guess > epsilon
    x0 = x;
    guesses{i} = x0;
    x = x0 - f(x0)/df(x0);
    error_guess = abs(x - x0);
    i = i + 1;
  endwhile
  guesses{i} = x;
  guesses = cell2mat(guesses);
endfunction