A = [0,10,-10;-100,-1,0;0,10,-100];

n = 3;
[V,D] = eig(A);
l = D(n,n);

th = linspace(0,2*pi,1000);
z = exp(1i*th);

rho = @(z) z.^3 - z.^2;
sigma = @(z) (23*z.^2 - 16*z + 5)/12;
p = @(z,l,dt) rho(z) - l*dt*sigma(z);
ldt = @(z) rho(z) / sigma(z);

reg = zeros(1,1000);
dts = zeros(1,1000);

for i = 1:1000
    reg(i) = ldt(z(i));
end

for i = 1:1000
    dts(i) = ldt(z(i))/l;
end

dt_best = 0.0055059;

real_z1 = real(reg);
imag_z1 = imag(reg);
real_z2 = real(dts);
imag_z2 = imag(dts);
real_z3 = real(dt_best*l);
imag_z3 = imag(dt_best*l);

% plot(real_z1,imag_z1,real_z3,imag_z3,'r*')
% plot(real_z2,imag_z2,'b', dt_best, 0, 'g*','MarkerSize', 10)

dt = 10^-4;
% dt = dt_best - 0.0001;
N = int16(10/dt);
u = zeros(3,N);
u(:,1) = [3, 3, 3];
u(:,2) = u(:,1) + dt*A*u(:,1);
u(:,3) = u(:,2) + dt*A*u(:,2);

for i = 4:N
    u(:,i) = u(:,i-1) + (dt/12)*(23*A*u(:,i-1) - 16*A*u(:,i-2) + 5*A*u(:,i-3));
end

plot3(u(1,:),u(2,:),u(3,:))

