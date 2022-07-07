
% % *** solve for consistency ***
syms x s;
rho = x^2 - 4*x + 3;
sig = -2;

r = abs(double(solve(rho==0)));
r_p = subs(diff(rho),1);

C0 = subs(rho,1);
C1 = subs(diff(rho),1) - subs(sig,1);
C = (1/factorial(s))*(2^s - 4);
C2 = subs(C,2);
C3 = subs(C,3);

