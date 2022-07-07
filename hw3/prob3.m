N = 200;
dx = 60/(N-1);
x = (-30:dx:30)';
n = 300;
dt = 10^-4; %;30/(n-1);
t = (0:dt:30)';

D1 = zeros(N);
for i = 1:N-1
    D1(i,i+1) = 1;
    D1(i+1,i) = -1;
end
D1(1,N) = -1;
D1(N,1) = 1;
D1 = D1/(2*dx);

D2 = zeros(N);
for i = 1:N-1
    D2(i,i) = -2;
    D2(i,i+1) = 1;
    D2(i+1,i) = 1;
end
D2(1,N) = 1;
D2(N,1) = 1;
D2(N,N) = -2;
D2 = D2/(dx^2);

D4 = zeros(N);
for i = 1:N-2
    D4(i+2,i) = 1;
    D4(i+1,i) = -4;
    D4(i,i) = 6;
    D4(i,i+2) = 1;
    D4(i,i+1) = -4;
end
D4(N-1,N-1) = 6;
D4(N-1,N) = -4;
D4(N-1,1) = 1;
D4(N,N-1) = -4;
D4(N,N) = 6;
D4(N,1) = -4;
D4(N,2) = 1;
D4(1,N-1) = 1;
D4(1,N) = -4;
D4(2,N) = 1;
D4 = D4/(dx^4);

f = @(s) -s.*(D1*s) - D2*s - D4*s;

u = zeros(N,n);
u(:,1) = exp(-x.^2);
u(:,2) = u(:,1) + dt*f(u(:,1));

for i = 3:n %% ******* the solution blows up if I iterate too mach *******
    u(:,i) = u(:,i-1) + (dt/2)*(3*f(u(:,i-1)) - f(u(:,i-2)));
end

[T,X] = meshgrid(t,x);

surf(T,X,u);
shading interp; 
view(0,90);
