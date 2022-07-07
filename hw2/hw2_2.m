
% % *** solve for roots ***
syms x;
rho = x^3 - (18/11)*x^2 + (9/11)*x - (2/11);
r = double(solve(rho==0));
abs(r)

% % *** solve for rho'(1) *** 
subs(diff(rho), 1)

% % *** plot region of stability ***
th = linspace(0,2*pi,1000);
z = exp(1i*th);

Rho = @(z) z.^3 - (18/11)*z.^2 + (9/11)*z - (2/11);
Sig = @(z) (6/11)*z.^3;
ldt = @(z) Rho(z) / Sig(z);

reg = zeros(1,1000);

for i = 1:1000
    reg(i) = ldt(z(i));
end

figure(1)
plot(reg)
ax = gca;
ax.XGrid = 'on';
ax.YGrid = 'on';

% % *** solve for roots of pi ***
Pi = (5/11)*x^3 - (18/11)*x^2 + (9/11)*x - (2/11); %lambda delta t is 1
r = double(solve(Pi==0));
abs(r)

% x = -3:0.05:3;
% [A,B] = meshgrid(x,x);
% 
% xlabel('Real(z)')
% ylabel('Imag(z)')

% % *** surface plot ***
% % rho = (A+1i*B).^3 - (18/11)*(A+1i*B).^2 + (9/11)*(A+1i*B) - (2/11);
% % surfc(a,b,abs(rho))

% % *** level set ***
% rho = @(x,y) (x+1i*y).^3 - (18/11)*(x+1i*y).^2 + (9/11)*(x+1i*y) - (2/11);
% Z = abs(rho(A,B));
% v = [0 0.01];
% contour(x,x,Z,v)

