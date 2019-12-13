% a
A = diag(2 * ones(10, 1)) + diag(-1 * ones(9, 1), 1) + diag(-1 * ones(9, 1), -1);

% i
x = eye(10)(:,1);
%d_last = 0;
%figure(1);
%hold on;
for i = 1:300
  x = A*x;
  d = sqrt(x'*x);
  %semilogy(i, abs(d - d_last));
  %d_last = d;
  x = x/d;
endfor
%hold off;
d

% largest eigenvalue is around 3.918985947228995
% it took around 275 iterations to converge

% ii
x = ones(10,1);
%d_last = 0;
%figure(2);
%hold on;
for i = 1:100
  x = A*x;
  d = sqrt(x'*x);
  %semilogy(i, abs(d - d_last));
  %d_last = d;
  x = x/d;
endfor
%hold off;
d

% second-largest eigenvalue is around 3.682507065662362
% it took around 75 iterations to converge
% after around 800 iterations it converges to the largest eigenvalue

% iii
% The initial guess for ii is closer to the second largest eigenvector.

% b
Ainv = inv(A);
x = ones(10,1);
%d_last = 0;
%figure(2);
%hold on;
for i = 1:100
  x = Ainv*x;
  d = sqrt(x'*x);
  %semilogy(i, abs(d - d_last));
  %d_last = d;
  x = x/d;
endfor
%hold off;
x
1/d

% c
[Q R] = QR_factor(A);
%figure(3);
%hold on;
for i = 1:600
  RQ = R*Q;
  [Q R] = QR_factor(RQ);
  % From the Gershgorin circle theorem
  %semilogy(i, norm(RQ - diag(diag(RQ)), inf));
endfor
%hold off;
diag(RQ)